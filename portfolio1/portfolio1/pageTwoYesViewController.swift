//
//  pageTwoYesViewController.swift
//  portfolio1
//
//  Created by Carlos Guedes on 28/02/2019.
//  Copyright © 2019 Carlos Guedes. All rights reserved.
//

import UIKit

class pageTwoYesViewController: UIViewController {

    var questionaire = Questions(id: "", dob: "", q1:"", q2: "", q3: "", latitude: 0, longitude: 0)
    
    @IBOutlet weak var btn1: UIButton!
    
    @IBOutlet weak var btn2: UIButton!
    
    @IBOutlet weak var btn3: UIButton!
    
    @IBOutlet weak var btn4: UIButton!
    
    @IBOutlet weak var btn5: UIButton!
    
    
    @IBAction func onClickBtn1(_ sender: Any) {
        btn1.isSelected = true;
        btn2.isSelected = false;
        btn3.isSelected = false;
        btn4.isSelected = false;
        btn5.isSelected = false;
        questionaire.q2 = "Work"
    }
    
    @IBAction func onClickBtn2(_ sender: Any) {
        btn1.isSelected = false;
        btn2.isSelected = true;
        btn3.isSelected = false;
        btn4.isSelected = false;
        btn5.isSelected = false;
        questionaire.q2 = "Games";
    }
    
    @IBAction func onClickBtn3(_ sender: Any) {
        btn1.isSelected = false;
        btn2.isSelected = false;
        btn3.isSelected = true;
        btn4.isSelected = false;
        btn5.isSelected = false;
        questionaire.q2 = "Internet Browsing";

    }
    
    @IBAction func onClickBtn4(_ sender: Any) {
        btn1.isSelected = false;
        btn2.isSelected = false;
        btn3.isSelected = false;
        btn4.isSelected = true;
        btn5.isSelected = false;
        questionaire.q2 = "Comunication/Social Networking";

    }
    
    @IBAction func onClickBtn5(_ sender: Any) {
        btn1.isSelected = false;
        btn2.isSelected = false;
        btn3.isSelected = false;
        btn4.isSelected = false;
        btn5.isSelected = true;
        questionaire.q2 = "Other";
    }
    
    
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
        // Do any additional setup after loading the view.
    }
}
