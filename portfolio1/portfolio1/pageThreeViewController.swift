//
//  pageThreeViewController.swift
//  portfolio1
//
//  Created by Carlos Guedes on 28/02/2019.
//  Copyright © 2019 Carlos Guedes. All rights reserved.
//

import UIKit
import CoreData
import CoreLocation

class pageThreeViewController: UIViewController, CLLocationManagerDelegate {
    
    var locationManager = CLLocationManager()
    
    var questionaire = Questions(id: "", dob: "", q1:"", q2: "", q3: "", latitude: 0, longitude: 0)
    
    @IBOutlet weak var yesButton: UIButton!
    
    @IBOutlet weak var noButton: UIButton!
    
    @IBAction func onYesClick(_ sender: Any) {
        yesButton.isSelected = true;
        noButton.isSelected = false;
        questionaire.q3 = "Yes";
    }
    
    @IBAction func onNoClick(_ sender: Any) {
        yesButton.isSelected = false;
        noButton.isSelected = true;
        questionaire.q3 = "No";

    }
    
    @IBAction func submitButton(_ sender: Any) {
        
         self.locationManager.requestWhenInUseAuthorization()
        if CLLocationManager.locationServicesEnabled() {
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
            locationManager.startUpdatingLocation()
        }

        let alert = UIAlertController(title: "Saved", message: "Your anwsers have been saved", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: "Default action"), style: .default, handler: { _ in
            NSLog("The \"OK\" alert occured.")
            
            //perform segue after clicking ok button
            self.performSegue(withIdentifier: "submit", sender: nil)
        }))
        
        
        // Declare Alert message
        let dialogMessage = UIAlertController(title: "Confirm", message: "Are you sure you want to submit your anwsers?", preferredStyle: .alert)
         
         // Create Yes button with action handler
         let yes = UIAlertAction(title: "Yes", style: .default, handler: { (action) -> Void in
         print("Yes button tapped")
            self.present(alert, animated: true, completion: nil)
            //If yes button pressed, save the data
            self.savingData()
         })
         
         // Create No button with action handlder
         let no = UIAlertAction(title: "No", style: .cancel) { (action) -> Void in
         print("No button tapped")
         }
         
         //Add YES and NO button to dialog message
         dialogMessage.addAction(yes)
         dialogMessage.addAction(no)
         
         // Present dialog message to user
         self.present(dialogMessage, animated: true, completion: nil)

    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let locValue:CLLocationCoordinate2D = manager.location!.coordinate
        //set user's location
        questionaire.latitude = locValue.latitude
        questionaire.longitude = locValue.longitude
        print ("1.location: Lat=\(questionaire.latitude) Long=\(questionaire.longitude)")
    }
    
    
    func savingData(){
        
        //As we know that container is set up in the AppDelegates so we need to refer that container.
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        
        //We need to create a context from this container
        let managedContext = appDelegate.persistentContainer.viewContext
        
        //Now let’s create an entity and new user records.
        let userEntity = NSEntityDescription.entity(forEntityName: "Data", in: managedContext)!
        
        let user = NSManagedObject(entity: userEntity, insertInto: managedContext)
        user.setValue(questionaire.id, forKeyPath: "id")
        user.setValue(questionaire.dob, forKey: "dob")
        user.setValue(questionaire.q1, forKey: "q1")
        user.setValue(questionaire.q2, forKey: "q2")
        user.setValue(questionaire.q3, forKey: "q3")
        user.setValue(questionaire.latitude, forKey: "latitude")
        user.setValue(questionaire.longitude, forKey: "longitude")
        print("Data saved!")
        //The next step is to save them inside the Core Data
        do {
            try managedContext.save()
            
        } catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
}
