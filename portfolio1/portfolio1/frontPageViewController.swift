//
//  frontPageViewController.swift
//  portfolio1
//
//  Created by Carlos Guedes on 28/02/2019.
//  Copyright © 2019 Carlos Guedes. All rights reserved.
//

import UIKit
import CoreData

class frontPageViewController: UIViewController {

    @IBOutlet weak var idText: UITextField!
    @IBOutlet weak var dobText: UITextField!
    private var datePicker: UIDatePicker?
    
    @IBAction func resultsButton(_ sender: Any) {
        var correctPassword = false
        
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
                    correctPassword = true
                    self.performSegue(withIdentifier: "getResults", sender: nil)
                }else {
                    self.present(alertWrongPW, animated: true, completion: nil)
                    
                }
            })
            //Add button to prompt textfield message
            prompt.addAction(action)
            self.present(prompt, animated:true, completion: nil)
            if correctPassword {
            }
    }
    }
    
    
    var questionaire = Questions(id: "", dob: "", q1:"", q2: "", q3: "", latitude: 0, longitude: 0)
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?)
    {
        if segue.destination is pageOneViewController
        {
            let vc = segue.destination as? pageOneViewController
            vc?.questionaire.id = idText.text!
            vc?.questionaire.dob = dobText.text!
        } else {
            let vc = segue.destination as? resultsViewController
            vc?.idFromSegue = idText.text
        }
    }
    
    @IBAction func startButton(_ sender: Any) {
        
        let alert = UIAlertController(title: "Empty field", message: "Please fill in all fields in order to proceed", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: "Default action"), style: .default, handler: { _ in
            NSLog("The \"OK\" alert occured.")
        }))
        
        if idText.text == "" || dobText.text == ""{
         self.present(alert, animated: true, completion: nil)
        }else {
            self.performSegue(withIdentifier: "start", sender: nil)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        createDatePicker()
    }
    
    func createDatePicker() {
        //format date
        datePicker?.datePickerMode = .date
        datePicker = UIDatePicker()
        datePicker?.datePickerMode = .date
        dobText.inputView = datePicker
        
        //create toolbar
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        
        //create done button
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: nil, action: #selector(doneClicked))
        
        //add button to toolbar
        toolbar.setItems([doneButton], animated: true)
        dobText.inputAccessoryView = toolbar
    }
    
    @objc func doneClicked () {
        //format date
        let dateFormater = DateFormatter()
        dateFormater.dateStyle = .medium
        dateFormater.timeStyle = .none
        
        dobText.text = dateFormater.string(from: datePicker!.date)
        self.view.endEditing(true)
    }
}

