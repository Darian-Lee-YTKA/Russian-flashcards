//
//  finalPracticeVC.swift
//  ios101-project5-tumblr
//
//  Created by Darian Lee on 11/10/23.
//

import UIKit

class finalPracticeVC: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet weak var pictureButton: UIButton!
    @IBOutlet weak var finalScore: UILabel!
    @IBOutlet weak var backToMain: UIButton!
    @IBOutlet weak var reviewMissed: UIButton!
    var selectedImage: UIImage?
    var sesh: Sesh?
    var newSesh: Sesh?
    override func viewDidLoad() {
        super.viewDidLoad()
        backToMain.layer.cornerRadius = 8
        reviewMissed.layer.cornerRadius = 8
        finalScore.text = "\(sesh!.score)/\(sesh!.total)"
        // Do any additional setup after loading the view.
    }
    func presentImagePicker() {
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.sourceType = .camera
        present(imagePicker, animated: true, completion: nil)
    }
    
    @IBAction func didPressReview(_ sender: UIButton){
        if sesh!.review == nil || sesh!.review!.count == 0 {
            let alertController = UIAlertController(
                title: "No cards to review",
                message: "Congrations! You have no missed cards",
                preferredStyle: .alert
            )
            
            let cancelAction = UIAlertAction(
                title: "Cancel",
                style: .cancel,
                handler: nil
            )
            
            alertController.addAction(cancelAction)
            
            present(alertController, animated: true, completion: nil)
        }
        else{
            
            var newCard = sesh!.review![0]
            var newCards = Array(sesh!.review!.dropFirst())
            
            newSesh = Sesh(score: 0, cards: newCards, card: newCard, color: 0, count: 0, total: newCards.count, review: nil, practice: false, done: false)
            performSegue(withIdentifier: "toReview", sender: nil)
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
        if let destinationVC = segue.destination as? PraticeYellowVC1{
            destinationVC.modalPresentationStyle = .fullScreen
            destinationVC.sesh = newSesh}
        if let destinationVC = segue.destination as? endingPic{
            destinationVC.modalPresentationStyle = .fullScreen
            destinationVC.image = selectedImage!
        }
        else {
                let destinationVC = segue.destination
                    destinationVC.modalPresentationStyle = .fullScreen
                }
            
            
           
            
            
        }
    @IBAction func takePictureButtonTapped(_ sender: UIButton) {
        // for testing
        selectedImage = UIImage(named: "hottieWithSandwich")
        // deleted for testing purposes 
        //presentImagePicker()
        performSegue(withIdentifier: "showImage", sender: sender)
        
        
    }
    
    
    
    
}

