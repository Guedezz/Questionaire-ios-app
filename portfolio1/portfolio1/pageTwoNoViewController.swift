//
//  pageTwoNoViewController.swift
//  portfolio1
//
//  Created by Carlos Guedes on 28/02/2019.
//  Copyright © 2019 Carlos Guedes. All rights reserved.
//

import UIKit

class pageTwoNoViewController: UIViewController {
    
    // Create and imnitialise Questions object
    var questionaire = Questions(id: "", dob: "", q1:"", q2: "", q3: "", latitude: 0, longitude: 0)
    
    @IBOutlet weak var sldLabel: UILabel!
    
    @IBAction func slider(_ sender: UISlider) {
       //empty text on slider label
        sldLabel.text = ""
        
        // Change text depending on slide value
        switch sender.value {
        case 1...20:
            sldLabel.text = "Very easy"
        case 20...40:
            sldLabel.text = "Easy"
        case 40...60:
            sldLabel.text = "Neither easy or difficult"
        case 60...80:
            sldLabel.text = "Difficult"
        case 80...100:
            sldLabel.text = "Very difficult"
        default:
            sldLabel.text = "Move slider to choose difficulty"
        }
        
        //Question 2 is determined by value in the slider
        questionaire.q2 = sldLabel.text!
    }
    
    //prepare for segue function
    override func prepare(for segue: UIStoryboardSegue, sender: Any?)
    {
        if segue.destination is pageThreeViewController
        {
            let vc = segue.destination as? pageThreeViewController
            vc?.questionaire.id = questionaire.id
            vc?.questionaire.dob = questionaire.dob
            vc?.questionaire.q1 = questionaire.q1
            vc?.questionaire.q2 = questionaire.q2
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}
