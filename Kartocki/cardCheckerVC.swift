//
//  cardCheckerVC.swift
//  ios101-project5-tumblr
//
//  Created by Darian Lee on 11/7/23.
//

import UIKit

class cardCheckerVC: UIViewController {
    
    @IBOutlet weak var correctShow: UILabel!
    @IBOutlet weak var userShow: UILabel!
    var correct: String?
    @IBOutlet weak var acceptButton: UIButton!
    @IBOutlet weak var rejectButton: UIButton!
    var userA: String?
    @IBOutlet weak var keyView: UIView!
    var sesh: Sesh?
    var points: Bool?
    var card: Card?
    var newSesh: Sesh?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        correctShow.text = correct!
        rejectButton.layer.cornerRadius = 8
        keyView.layer.borderWidth = 1.0
                keyView.layer.borderColor = UIColor.black.cgColor
        acceptButton.layer.cornerRadius = 8
        userShow.attributedText = colorText(correct: correct, userA: userA)
        
        func colorText(correct: String?, userA: String?) -> NSAttributedString? {
            
            let darkerGreen = UIColor(red: 0.0, green: 0.5, blue: 0.0, alpha: 1.0)
            let darkYellow = UIColor(red: 0.8, green: 0.6, blue: 0.0, alpha: 1.0)
            
            
            guard let answerText_temp = correct,
                  let userInput_temp = userA else {
                return nil
            }
            let answerText = answerText_temp.lowercased()
            let userInput = userInput_temp.lowercased()
            
            // get an array of only letters included in the answer but not the input
            let answerText_list = Array(answerText)
            //let userInput_list = Array(userInput)
            
            var intIndex = 0
            
            let attributedString = NSMutableAttributedString(string: "")
            
            var userIndex = userInput.startIndex
            var answerIndex = answerText.startIndex
            
            while userIndex < userInput.endIndex && answerIndex < answerText.endIndex {
                
                print("User index")
                print(userIndex)
                let userChar = userInput[userIndex]
                print(userChar)
                let answerChar = answerText[answerIndex]
                print(answerChar)
                if userChar == answerChar {
                    print("match!")
                    //let range = NSRange(location: userIndex.utf16Offset(in: userInput), length: 1)
                    let add = NSAttributedString(string: String(userChar), attributes: [
                        .foregroundColor: darkerGreen
                    ])
                    attributedString.append(add)
                } else {
                    //if the users character is kind close to its placement in the original, we'll color it yellow
                    // I'm so tired of working with string indexes
                    let lowerBound = max(0, intIndex - 4)
                    
                    var upperBound = min(intIndex + 4, answerText_list.count)
                    
                    
                        //highest possible upperBound that isnt out of bounds
                    
                    
                    
                    if lowerBound < upperBound {
                        
                        let subarray = answerText_list[lowerBound..<upperBound]
                        print(subarray)
                        if subarray.contains(userChar){
                            let add = NSAttributedString(string: String(userChar), attributes: [
                                .foregroundColor: darkYellow
                            ])
                            attributedString.append(add)
                        }
                        else{
                            let add = NSAttributedString(string: String(userChar), attributes: [
                                .foregroundColor: UIColor.red
                            ])
                            attributedString.append(add)
                        }
                        
                        
                        
                    }
                }
                userIndex = userInput.index(after: userIndex)
                answerIndex = answerText.index(after: answerIndex)
                intIndex += 1
                
                
            }
            if userInput.count > attributedString.length {
                
                
                let startIndex = userInput.index(userInput.startIndex, offsetBy: attributedString.length)
                let remainingCharacters = userInput[startIndex..<userInput.endIndex]
                
                for userChar in remainingCharacters {
                    let lowerBound = max(0, intIndex - 4)
                    
                    var upperBound = min(intIndex + 4, answerText_list.count)
                    
                    
                        //highest possible upperBound that isnt out of bounds
                    
                    
                    
                    if lowerBound < upperBound {
                        
                        let subarray = answerText_list[lowerBound..<upperBound]
                        print(subarray)
                        if subarray.contains(userChar){
                            let add = NSAttributedString(string: String(userChar), attributes: [
                                .foregroundColor: darkYellow
                            ])
                            attributedString.append(add)
                        }
                        else{
                            let add = NSAttributedString(string: String(userChar), attributes: [
                                .foregroundColor: UIColor.red
                            ])
                            attributedString.append(add)
                        }
                        
                        
                        
                    }
                    
                }
            }
            
            
            
            return attributedString
            
            
        }
    }
    func chooseSegue(sesh: Sesh, points: Bool) {
        print("in function choose segue")
        print(sesh)
        if sesh.cards?.count == 0 || sesh.cards == nil{
            newSesh = sesh
            performSegue(withIdentifier: "endingSegue", sender: nil)
        }
        else{
            let newCard  = sesh.cards![0]
            let newCards = Array(sesh.cards!.dropFirst())
            let newCount = sesh.count + 1
            var newScore: Int
            
            
            
            if points {
                newScore = sesh.score + 1
            }
            else{
                newScore = sesh.score
            }
            
            let newColor = sesh.color + 1
            
            newSesh = Sesh(score: newScore, cards: newCards, card: newCard, color: newColor, count: newCount, total: sesh.total, review: sesh.review, practice: false, done: false)
            
            if sesh.total / 2 == sesh.count {
                performSegue(withIdentifier: "halfwaySegue", sender: self)
                
            }
            else
            {if sesh.color % 3 == 0 {
                // Perform segue with identifier showYel
                self.performSegue(withIdentifier: "showYel", sender: self)
            } else if sesh.color % 3 == 1 {
                // Perform segue with identifier showRed
                self.performSegue(withIdentifier: "showRed", sender: self)
            } else {
                // Perform segue with identifier showGreen
                self.performSegue(withIdentifier: "showGreen", sender: self)
            }
                
                
            }
            
            
            
            
        }
    }
    func performNextSegue() {
        if sesh!.color % 3 == 0 {
            // Perform segue with identifier showYel
            performSegue(withIdentifier: "showYel", sender: self)
        } else if sesh!.color % 3 == 1 {
            // Perform segue with identifier showRed
            performSegue(withIdentifier: "showRed", sender: self)
        } else {
            // Perform segue with identifier showGreen
            performSegue(withIdentifier: "showGreen", sender: self)
        }
    }
    
    @IBAction func didPressAccept(_ sender: UIButton){
        chooseSegue(sesh: self.sesh!, points: true)
    }
    @IBAction func didPressReject(_ sender: UIButton){
        
            
        if sesh?.review == nil {
            sesh?.review = [card!]
            } else {
                
                sesh?.review?.append(card!)
            }
        
        sesh!.cards!.append(card!) //so that we can keep reviewing it til we get it right
        sesh!.cards!.shuffle()
        
        chooseSegue(sesh: self.sesh!, points: false)
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destinationVC = segue.destination as? PraticeYellowVC1{
            destinationVC.modalPresentationStyle = .fullScreen
            destinationVC.sesh = newSesh!
            
        }
        if let destinationVC = segue.destination as? redPracticeVC{
            destinationVC.modalPresentationStyle = .fullScreen
            destinationVC.sesh = newSesh!
        }
        if let destinationVC = segue.destination as? greenPracticeVC{
            destinationVC.modalPresentationStyle = .fullScreen
            destinationVC.sesh = newSesh!
        }
        if let destinationVC =
            segue.destination as? halfWayVC{
            print("!!!!!!!!!!!!!!!!!!!!!!!!seguing!")
            destinationVC.sesh = newSesh!
            Timer.scheduledTimer(withTimeInterval: 1.5, repeats: false) { timer in
                destinationVC.dismiss(animated: true) {
                    // The completion closure is called when the dismissal is completed
                    self.performNextSegue()
                    
                    
                    
                }
            }
        }
        if let destinationVC = segue.destination as? cardEditor{
            destinationVC.card = card!
            destinationVC.sesh = sesh!
            
        }
            
        if let destinationVC =
            segue.destination as? finalPracticeVC{
            destinationVC.sesh = newSesh!
            destinationVC.modalPresentationStyle = .fullScreen
            
            
        }
        
        else{
            let destinationVC = segue.destination
            destinationVC.modalPresentationStyle = .fullScreen
        }
    }
}

