//
//  pageOneViewController.swift
//  portfolio1
//
//  Created by Carlos Guedes on 28/02/2019.
//  Copyright © 2019 Carlos Guedes. All rights reserved.
//

import UIKit


class pageOneViewController: UIViewController {

    var questionaire = Questions(id: "", dob: "", q1:"", q2: "", q3: "", latitude: 0, longitude: 0)
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?)
    {
        if segue.destination is pageTwoYesViewController
        {
            let vc = segue.destination as? pageTwoYesViewController
            vc?.questionaire.id = questionaire.id
            vc?.questionaire.dob = questionaire.dob
            vc?.questionaire.q1 = "Yes"
        }
        if segue.destination is pageTwoNoViewController
        {
            let vc = segue.destination as? pageTwoNoViewController
            vc?.questionaire.id = questionaire.id
            vc?.questionaire.dob = questionaire.dob
            vc?.questionaire.q1 = "No"
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}
