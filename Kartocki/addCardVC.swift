//
//  addCardVC.swift
//  ios101-project5-tumblr
//
//  Created by Darian Lee on 11/5/23.
//

import UIKit

//import PythonKit


class addCardVC: UIViewController {
    @IBOutlet weak var front: UITextField!
    
    @IBOutlet weak var autoTranslateButton: UIButton!
    
    @IBOutlet weak var createButton: UIButton!
    @IBOutlet weak var back: UITextField!
    var frontInput: String?
        var backInput: String?
    var addedCard: Card?
   

        @IBAction func saveFront() {
            frontInput = front.text
            autoTranslateButton.isHidden = false
        }
    @IBAction func saveBack() {
        backInput = back.text
        print("PRINTING BACK")
        print(back.text!)
    }
    
    @IBAction func createCard() {

           addedCard = Card(front: frontInput ?? "", back: backInput ?? "")

            var existingCards = CardManager.shared.loadCards()

                print(existingCards)

                

                existingCards.append(addedCard!)
            print("AAAAAAPPPPENDDDDINGG")
            print(existingCards)

                

                CardManager.shared.saveCards(cards: existingCards)

        }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        autoTranslateButton.layer.cornerRadius = 5.0
        autoTranslateButton.isHidden = true
        // Do any additional setup after loading the view.
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destinationVC = segue.destination as? cardReadyVC{
            destinationVC.modalPresentationStyle = .fullScreen
            destinationVC.card = addedCard!
        }
        else{
            let destinationVC = segue.destination
            destinationVC.modalPresentationStyle = .fullScreen
        }
        
    }
    @IBAction func didPressTranslate(_ sender: UIButton){
        print("did press translate")
            guard let text = frontInput else {
                print("no front input")
                return
            }
        let punctuationCharacterSet = CharacterSet.punctuationCharacters

        // Remove punctuation characters from the input text
        let textWithoutPunctuation = String(text.unicodeScalars.filter { !punctuationCharacterSet.contains($0) })

        print("Original Text: \(text)")
        print("Text Without Punctuation: \(textWithoutPunctuation)")
            print(frontInput!)

            translateText(with: textWithoutPunctuation) { translatedText in
                DispatchQueue.main.async {
                    if let translatedText = translatedText {
                        print("translation worked")
                        self.back.text = translatedText
                        self.backInput = self.back.text
                        print("this is the translation \(translatedText)")
                    } else {
                        print("Translation failed or returned nil")
                    }
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
    

    func translateText(with text: String, completion: @escaping (String?) -> Void) {
        // Define the URL
        let url = URL(string: "http://127.0.0.1:5000/translate")!

        // Create the request
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")

        // Create the JSON payload
        let payload: [String: String] = ["text": text]

        do {
            // Convert the payload to JSON data
            let jsonData = try JSONSerialization.data(withJSONObject: payload, options: [])

            // Attach the JSON data to the request
            request.httpBody = jsonData
        } catch {
            print("Error converting payload to JSON: \(error)")
            completion(nil)
            return
        }

        // Perform the request
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                print("Error: \(error)")
                completion(nil)
                return
            }

            // Check if there is data
            guard let data = data else {
                print("No data received.")
                completion(nil)
                return
            }

            do {
                // Parse the JSON response
                let jsonResponse = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any]

                // Handle the response
                if let translation = jsonResponse?["translation"] as? String {
                    completion(translation)
                } else {
                    print("Unexpected response format.")
                    completion(nil)
                }
            } catch {
                print("Error parsing JSON response: \(error)")
                completion(nil)
            }
        }

        // Start the task
        task.resume()
        
    }
    

}
