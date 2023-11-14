//
//  cardEditor.swift
//  ios101-project5-tumblr
//
//  Created by Darian Lee on 11/6/23.
//

import UIKit

class cardEditor: UIViewController {
    var card: Card?
    var sesh: Sesh?

    @IBOutlet weak var saveButton: UIButton!
    @IBOutlet weak var frontTextEdit: UITextField!
    @IBOutlet weak var backTextEdit: UITextField!
    @IBOutlet weak var deleteCardButton: UIButton!
    override func viewDidLoad() {
        deleteCardButton.layer.cornerRadius = 8
        saveButton.layer.cornerRadius = 8
        frontTextEdit.text = card!.front
        backTextEdit.text = card!.back
        super.viewDidLoad()
        

        // Do any additional setup after loading the view.
    }
    
    @IBAction func showConfirmationAlert(_ sender: UIButton) {
        let alertController = UIAlertController(
            title: "Confirmation",
            message: "Are you sure you want to delete your card? This action cannot be undone",
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
            title: "Delete",
            style: .default,
            handler: { [weak self] action in
                // Handle the confirmation action here
                print("User confirmed the action.")
                if let cardToDelete = self?.card {
                    var existingCards = CardManager.shared.loadCards()
                    if let index = existingCards.firstIndex(where: { $0.front == cardToDelete.front }) {
                        print("Found a matching card: \(existingCards[index])")
                        existingCards.remove(at: index) // Remove the card from the array
                        
                        CardManager.shared.saveCards(cards: existingCards)
                        self?.deleteFromSesh()
                        
                        // Show a success message
                        self?.showDeleteSuccessPopup()
                    }
                }
            }
        )
        
        // Add the actions to the alert controller
        alertController.addAction(cancelAction)
        alertController.addAction(confirmAction)
        
        // Present the alert controller
        present(alertController, animated: true, completion: nil)
    }
    func deleteFromSesh() {
        if self.sesh != nil{
            sesh!.card = sesh!.cards![0]
            sesh!.cards = Array(sesh!.cards!.dropFirst())
        }
    }
   
    func showDeleteSuccessPopup() {
        let successAlert = UIAlertController(
            title: "Success",
            message: "Card successfully deleted",
            preferredStyle: .alert
        )
        
        let okAction = UIAlertAction(
            title: "OK",
            style: .default,
            handler: nil
        )
        
        successAlert.addAction(okAction)
        
        present(successAlert, animated: true, completion: nil)
    }
    @IBAction func didEdit(_ sender: UIButton) {
        if let oldFront = card?.front,
           let newFront = frontTextEdit.text,
           let newBack = backTextEdit.text {
            card = Card(front: newFront, back: newBack)
            var existingCards = CardManager.shared.loadCards()
            
            if let index = existingCards.firstIndex(where: { $0.front == oldFront }) {
                print("Found a matching card: \(existingCards[index])")
                existingCards[index] = card!
                CardManager.shared.saveCards(cards: existingCards)
                
            }
            if sesh != nil{
                sesh!.card = card!
            }
            else {
                print("No matching card found")
            }
        }
        
    }


    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destinationVC = segue.destination as? cardReadyVC{
            if sesh != nil{
                destinationVC.sesh = sesh
            }
            destinationVC.modalPresentationStyle = .fullScreen
            destinationVC.card = card
        }
        else{
            let destinationVC = segue.destination
            destinationVC.modalPresentationStyle = .fullScreen
        }
        
    }
}
