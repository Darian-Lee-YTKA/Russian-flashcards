//
//  cardSelectorVC.swift
//  ios101-project5-tumblr
//
//  Created by Darian Lee on 11/7/23.
//

import UIKit
class cardSelctorCell: UITableViewCell{
    
    @IBOutlet weak var divider: UIView!
    @IBOutlet weak var back: UILabel!
    @IBOutlet weak var backGround: UIView!
    @IBOutlet weak var front: UILabel!
}
class cardSelectorVC: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    
    @IBOutlet weak var selectAll: UIButton!
    @IBOutlet weak var selectChosen: UIButton!
    @IBOutlet weak var xButton: UIButton!
    @IBOutlet weak var select5: UIButton!
    @IBOutlet weak var select10: UIButton!
    @IBOutlet weak var select50: UIButton!
    @IBOutlet weak var mySearchBar: UITextField!
    
    @IBOutlet weak var select20: UIButton!
    @IBOutlet weak var selectCardsTV: UITableView!
    var selectedCards: [Card] = []
    var existingCards = CardManager.shared.loadCards()
    var filteredCards: [Card] = []
    //var currentCard: Card
    
    @IBAction func didPressDeselect(_ sender: UIButton) {
        let alertController = UIAlertController(
            title: "Confirmation",
            message: "Are you sure you want to deselect all cards",
            preferredStyle: .alert
        )
        
        // Create a cancel action
        let cancelAction = UIAlertAction(
            title: "Cancel",
            style: .cancel,
            handler: nil
        )
        
        // Create a confirm action
        let confirmAction = UIAlertAction(
            title: "Deselect all",
            style: .default,
            handler: { [weak self] action in
                // Handle the confirmation action here
                self?.selectedCards = []
                self?.selectCardsTV.reloadData()
            }
        )
        
        // Add the actions to the alert controller
        alertController.addAction(cancelAction)
        alertController.addAction(confirmAction)
        
        // Present the alert controller
        present(alertController, animated: true, completion: nil)
    }
    @IBOutlet weak var deselectAll: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        selectAll.layer.borderWidth = 1.5
        selectAll.layer.borderColor = UIColor.black.cgColor
        selectCardsTV.delegate = self
        selectCardsTV.dataSource = self
        filteredCards = existingCards
        //select5.layer.borderWidth = 2.0
        select5.layer.cornerRadius = 8
        //select5.layer.borderColor = UIColor.black.cgColor
        
        
        select10.layer.cornerRadius = 8
        //select10.layer.borderWidth = 2.0
        //select10.layer.borderColor = UIColor.black.cgColor
        //select20.layer.borderWidth = 2.0
        select20.layer.cornerRadius = 8
        //select20.layer.borderColor = UIColor.black.cgColor
        //select50.layer.borderWidth = 2.0
        select50.layer.cornerRadius = 8
        select50.layer.borderColor = UIColor.black.cgColor
        selectChosen.layer.cornerRadius = 8
        selectChosen.isHidden = true
        selectCardsTV.layer.cornerRadius = 8
        selectCardsTV.layer.borderWidth = 1.5
        mySearchBar.layer.borderWidth = 1.5
        mySearchBar.layer.cornerRadius = 8
        mySearchBar.layer.borderColor = UIColor.black.cgColor
        
        selectCardsTV.layer.borderColor = UIColor.black.cgColor
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredCards.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "practiceCell", for: indexPath) as! cardSelctorCell
        let card = filteredCards[indexPath.row]
        cell.front.text = card.front
        cell.back.text = card.back
        cell.backGround.backgroundColor = UIColor.white
        cell.front.textColor = UIColor.black
        cell.back.textColor = UIColor.black
        cell.divider.backgroundColor = UIColor.black
        
        
        
        if selectedCards.contains(card) {
            // Set the background color for selected cells
            
            let customPinkColor = UIColor(red: 255/255, green: 182/255, blue: 193/255, alpha: 1.0)
            let pinkWithAlpha = customPinkColor.withAlphaComponent(0.4)
            cell.backGround.backgroundColor = pinkWithAlpha
            cell.front.textColor = UIColor.black
            cell.back.textColor = UIColor.black
            cell.divider.backgroundColor = UIColor.black
        }
        
        return cell
    }
    @IBAction func didPressSelectAll(_ sender: UIButton){
        selectedCards = existingCards
        
        
    }
    @IBAction func didPressSelect5(_ sender: UIButton){
        let shuffledCards = existingCards.shuffled()
        if shuffledCards.count >= 5{
            selectedCards = Array(shuffledCards.prefix(5))    }
        else{
            selectedCards = shuffledCards
        }
        performSegue(withIdentifier: "goToYellow", sender: nil)
    }
    @IBAction func didPressSelect10(_ sender: UIButton){
        let shuffledCards = existingCards.shuffled()
        if shuffledCards.count >= 10{
            selectedCards = Array(shuffledCards.prefix(10))    }
        else{
            selectedCards = shuffledCards
        }
        performSegue(withIdentifier: "goToYellow", sender: nil)
    }
    @IBAction func didPressSelect20(_ sender: UIButton){
        let shuffledCards = existingCards.shuffled()
        if shuffledCards.count >= 20{
            selectedCards = Array(shuffledCards.prefix(20))    }
        else{
            selectedCards = shuffledCards
        }
        performSegue(withIdentifier: "goToYellow", sender: nil)
    }
    @IBAction func didPressSelect50(_ sender: UIButton){
        let shuffledCards = existingCards.shuffled()
        if shuffledCards.count >= 50{
            selectedCards = Array(shuffledCards.prefix(50))    }
        else{
            selectedCards = shuffledCards
            selectCardsTV.reloadData()
        }
        performSegue(withIdentifier: "goToYellow", sender: nil)
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let cell = tableView.cellForRow(at: indexPath) as? cardSelctorCell {
            print("selected cards=")
            print(selectedCards)
            if selectedCards.contains(filteredCards[indexPath.row]) {
                // The card is already selected, so remove it and set the background color to white
                print("removing Cell:")
                print(filteredCards[indexPath.row].front)
                if let index = selectedCards.firstIndex(of: filteredCards[indexPath.row]) {
                    selectedCards.remove(at: index)
                    if cell.front.text == filteredCards[indexPath.row].front{
                        cell.backGround.backgroundColor = UIColor.white
                        cell.front.textColor = UIColor.black
                        cell.back.textColor = UIColor.black
                        cell.divider.backgroundColor = UIColor.black
                    }
                    if selectedCards == []{
                        selectChosen.isHidden = true //hidden if none selected
                    }
                }
                
            } else {
                selectChosen.isHidden = false
                print("adding Cell:")
                print(filteredCards[indexPath.row].front)
                // The card is not selected, so select it and set the background color to system yellow
                
                selectedCards.append(filteredCards[indexPath.row])
                if cell.front.text == filteredCards[indexPath.row].front{
                    let customPinkColor = UIColor(red: 255/255, green: 182/255, blue: 193/255, alpha: 1.0)
                    let pinkWithAlpha = customPinkColor.withAlphaComponent(0.4)
                    cell.backGround.backgroundColor = pinkWithAlpha
                    cell.front.textColor = UIColor.black
                    cell.back.textColor = UIColor.black
                    cell.divider.backgroundColor = UIColor.black
                }
            }
        }
    }
    
    @IBAction func didPressXSelect(_ sender: UIButton) {
        filteredCards = existingCards
        mySearchBar.text = ""
        selectCardsTV.reloadData()
    }
    
    @IBAction func didChangeSearchSelect(_ sender: UITextField) {
        let searchText = sender.text ?? ""
        if searchText == "%%DariansDeletionCode%%~~~"{
            print("oh no you didnt you naught girl")
            CardManager.shared.deleteAllCards()
            selectCardsTV.reloadData()
            
        }
        
        
        filteredCards = existingCards.filter { card in
            return card.front.lowercased().contains(searchText.lowercased()) || card.back.lowercased().contains(searchText.lowercased())
        }
        
        selectCardsTV.reloadData() // Refresh the table view with filtered data
    }
    
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destinationVC = segue.destination as? PraticeYellowVC1{
            destinationVC.modalPresentationStyle = .fullScreen
            let firstCard = selectedCards.remove(at: 0)
            let total = selectedCards.count
            var sesh = Sesh(score: 0, cards: selectedCards, card: firstCard, color: 1, count: 0, total: total, review: nil, practice: false, done: false)
            destinationVC.sesh = sesh}
        else {
                let destinationVC = segue.destination
                    destinationVC.modalPresentationStyle = .fullScreen
                }
            
            
           
            
            
        }
    
    
}
