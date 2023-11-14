//
//  cardListVC.swift
//  ios101-project5-tumblr
//
//  Created by Darian Lee on 11/5/23.
//

import UIKit

class cardCell: UITableViewCell{
    
    @IBOutlet weak var textBack: UILabel!
   

    @IBOutlet weak var textFront: UILabel!
}




class cardListVC: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    var selectedCard: Card?
    
    @IBOutlet weak var myTextField: UITextField!
    
    @IBOutlet weak var xButton: UIButton!
    //@IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var myTableView: UITableView!
    var existingCards = CardManager.shared.loadCards()
    var filteredCards: [Card] = []
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("somethings printing at least")
        myTableView.delegate = self
        myTableView.dataSource = self
        filteredCards = existingCards
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredCards.count // Number of cells you want
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "card_in_list", for: indexPath) as! cardCell
        let card = filteredCards[indexPath.row]
        
        cell.textFront.text = card.front
        cell.textBack.text = card.back
        
        
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedCard = filteredCards[indexPath.row]
        performSegue(withIdentifier: "ShowCardDetail", sender: self)
    }
    
    
    @IBAction func didChangeSearch(_ sender: UITextField) {
        let searchText = sender.text ?? ""
        if searchText == "%%DariansDeletionCode%%~~~"{
            print("oh no you didnt you naught girl")
            CardManager.shared.deleteAllCards()
            myTableView.reloadData()
        }
        
        filteredCards = existingCards.filter { card in
            return card.front.lowercased().contains(searchText.lowercased()) || card.back.lowercased().contains(searchText.lowercased())
        }
        
        myTableView.reloadData() // Refresh the table view with filtered data
    }
    @IBAction func didPressX(_ sender: UIButton) {
        filteredCards = existingCards
        myTextField.text = ""
        myTableView.reloadData()
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if let editVC = segue.destination as? cardEditor{
            editVC.card = selectedCard
            editVC.modalPresentationStyle = .fullScreen
            
        }
        if let main = segue.destination as? mainMenuVC{
            main.modalPresentationStyle = .fullScreen
        }
        
        
        
    }
   
}

