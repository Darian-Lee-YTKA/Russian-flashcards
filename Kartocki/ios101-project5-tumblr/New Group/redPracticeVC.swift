//
//  redPracticeVC.swift
//  ios101-project5-tumblr
//
//  Created by Darian Lee on 11/9/23.
//

import UIKit

class redPracticeVC: UIViewController {

    @IBOutlet weak var checkAnswer: UIButton!
    @IBOutlet weak var userAnswer: UITextField!
    @IBOutlet weak var showAnswer: UIButton!
    @IBOutlet weak var frontText: UILabel!
    @IBOutlet weak var whiteView: UIView!
    @IBOutlet weak var numberLabel: UILabel!
    var correct: String?
    var yourAnswer: String?
    var card: Card?
    var sesh: Sesh?
    override func viewDidLoad() {
        super.viewDidLoad()
        whiteView.layer.cornerRadius = 10
        checkAnswer.layer.cornerRadius = 15
        showAnswer.layer.cornerRadius = 15
        card = sesh!.card
        numberLabel.text = "\(sesh!.count+1)/\(sesh!.total)"
        frontText.text = card!.front
        correct = card!.back
        
        // Do any additional setup after loading the view.
    }
    @IBAction func didPressFlip(_ sender: UIButton) {
        if frontText.text == card!.front{
            frontText.text = card!.back
            correct = card!.front
        }
        else{
            frontText.text = card!.front
            correct = card!.back
        }

    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destinationVC = segue.destination as? cardCheckerVC{
            destinationVC.modalPresentationStyle = .fullScreen
            destinationVC.correct = correct!
            destinationVC.userA = yourAnswer ?? "no input given"
            destinationVC.sesh = sesh!
            destinationVC.card = card!
        }
        
        else{
            if let destinationVC = segue.destination as? cardEditor{
                destinationVC.modalPresentationStyle = .fullScreen
                destinationVC.card = card!
                destinationVC.sesh = sesh!
                
            }
            
            let destinationVC = segue.destination
            destinationVC.modalPresentationStyle = .fullScreen
            
            
            
        }
    }
    @IBAction func didEditText(_ sender: UITextField){
        yourAnswer = userAnswer.text
        
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
