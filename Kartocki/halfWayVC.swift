//
//  halfWayVC.swift
//  ios101-project5-tumblr
//
//  Created by Darian Lee on 11/9/23.
//

import UIKit

class halfWayVC: UIViewController {
    var sesh: Sesh?
    @IBOutlet weak var score: UILabel!
    override func viewDidLoad() {
        score.text = "\(sesh!.score)/\(sesh!.count)"
        super.viewDidLoad()

        // Do any additional setup after loading the view.
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
