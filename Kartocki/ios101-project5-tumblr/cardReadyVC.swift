//
//  cardReadyVC.swift
//  ios101-project5-tumblr
//
//  Created by Darian Lee on 11/5/23.
//

import UIKit

class cardReadyVC: UIViewController {

    @IBOutlet weak var createNewCC: UIButton!
    @IBOutlet weak var mainMenu: UIButton!
    
    @IBOutlet weak var preview: UIButton!
    var card: Card?
    var sesh: Sesh?
    override func viewDidLoad() {
        if sesh != nil{
            preview.setTitle("return to practice", for: .normal)
        }
        super.viewDidLoad()
        preview.layer.cornerRadius = 15

        // Do any additional setup after loading the view.
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destinationVC = segue.destination as? PraticeYellowVC1{
            destinationVC.modalPresentationStyle = .fullScreen
            destinationVC.card = card!
            if sesh == nil{
                destinationVC.sesh = Sesh(score: 0, cards: [card!], card: card!, color: 0, count: 0, total: 0, practice: true, done: false)
            }
            else{
                destinationVC.sesh = sesh
            }
        }
            
            // special code for practice
            else{
                let destinationVC = segue.destination
                destinationVC.modalPresentationStyle = .fullScreen
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

}
