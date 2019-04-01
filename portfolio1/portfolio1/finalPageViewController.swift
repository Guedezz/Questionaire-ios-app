//
//  finalPageViewController.swift
//  portfolio1
//
//  Created by Carlos Guedes on 28/02/2019.
//  Copyright © 2019 Carlos Guedes. All rights reserved.
//

import UIKit
import CoreData

class finalPageViewController: UIViewController {

    @IBOutlet weak var idText: UITextField!
    
    
    @IBAction func resultsButton(_ sender: Any) {
    }
    
    var id: String?
    
    @IBAction func getResultsButton(_ sender: Any) {
        //alert in case id field is empty
        let alertNoID = UIAlertController(title: "Missing ID", message: "Please enter your ID", preferredStyle: .alert)
        alertNoID.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: "Default action"), style: .default, handler: { _ in
            NSLog("The \"OK\" alert occured.")
        }))
        
        // Declare Alert message for password prompt
        let prompt = UIAlertController(title: "Password", message: "Please insert password in order to proceed", preferredStyle: .alert)
        
        // Add textfield to password alert
         prompt.addTextField { (textField) in textField.placeholder = "Enter password"}
        
        // Create Yes button with action handler
        let alertWrongPW = UIAlertController(title: "Wrong password", message: "Please try again", preferredStyle: .alert)
        alertWrongPW.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: "Default action"), style: .default, handler: { _ in
            NSLog("The \"OK\" alert occured.")
        }))
        
        
        if idText.text == "" {
            self.present(alertNoID, animated: true, completion: nil)
        }else {
            
            let action = UIAlertAction(title: "Get results", style: .default, handler: { (action) -> Void in
                print("Retrieve button tapped")
                let textField = prompt.textFields![0] as UITextField
                
                if textField.text == "password1" {
                     self.performSegue(withIdentifier: "fetch", sender: nil)
                }else {
                    self.present(alertWrongPW, animated: true, completion: nil)
                    
                }
            })
            //Add button to prompt textfield message
            prompt.addAction(action)
            self.present(prompt, animated:true, completion: nil)
            }
        }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?)
    {
        if segue.destination is resultsViewController
        {
            let vc = segue.destination as? resultsViewController
            vc?.idFromSegue = idText.text
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}
