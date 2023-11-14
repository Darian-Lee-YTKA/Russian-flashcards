//
//  PraticeYellowVC1.swift
//  ios101-project5-tumblr
//
//  Created by Darian Lee on 11/6/23.
//

import UIKit

class PraticeYellowVC1: UIViewController {
    var sesh: Sesh?

    @IBOutlet weak var showAnswer: UIButton!
    @IBOutlet weak var frontText: UILabel!
    @IBOutlet weak var typeAnswerLabel: UILabel!
    @IBOutlet weak var userAnswer: UITextField!
    @IBOutlet weak var orLabel: UILabel!
    var correct: String?
    var yourAnswer: String?
    var card: Card?
    @IBOutlet weak var checkA: UIButton!
    @IBOutlet weak var checkAnswer: UIButton!
    
    @IBOutlet weak var numberLabel: UILabel!
    
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        if sesh!.practice == true{
            checkA.isHidden = true
            orLabel.isHidden = true
            numberLabel.isHidden = true
            userAnswer.isHidden = true
            typeAnswerLabel.isHidden = true
        }
        checkA.layer.cornerRadius = 15
        numberLabel.text = "\(sesh!.count)/\(sesh!.total+1)"
        showAnswer.layer.cornerRadius = 15
        card = sesh!.card
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
                if sesh!.practice == false{
                    destinationVC.sesh = sesh!
                }
                
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
