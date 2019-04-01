//
//  resultsViewController.swift
//  portfolio1
//
//  Created by Carlos Guedes on 28/02/2019.
//  Copyright © 2019 Carlos Guedes. All rights reserved.
//

import UIKit
import MapKit
import CoreData

class resultsViewController: UIViewController {
    
    @IBOutlet weak var id: UILabel!
    @IBOutlet weak var dob: UILabel!
    @IBOutlet weak var q1: UILabel!
    @IBOutlet weak var q2: UILabel!
    @IBOutlet weak var q3: UILabel!
    @IBOutlet weak var questionString: UILabel!
    @IBOutlet weak var latLabel: UILabel!
    @IBOutlet weak var longLabel: UILabel!
    @IBOutlet weak var map: MKMapView!
    var latitude: Double?
    var longitude: Double?
    var idFromSegue: String?
    
    @IBOutlet weak var Delbutton: UIButton!
    
    @IBAction func deleteButton(_ sender: Any) {
        deleteData()
    }
    
    
    func retrieveData() {
        
        //As we know that container is set up in the AppDelegates so we need to refer that container.
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        
        //We need to create a context from this container
        let managedContext = appDelegate.persistentContainer.viewContext
        
        //Prepare the request of type NSFetchRequest  for the entity
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Data")
        
        fetchRequest.fetchLimit = 1
        fetchRequest.predicate = NSPredicate(format: "id = %@", idFromSegue!)
        fetchRequest.sortDescriptors = [NSSortDescriptor.init(key: "id", ascending: false)]

        
        do {
            let result = try managedContext.fetch(fetchRequest)
            for data in result as! [NSManagedObject] {
                print(data.value(forKey: "id") as! String)
                id.text = (data.value(forKey:"id") as? String)!
                dob.text = (data.value(forKey:"dob") as? String)!
                q1.text = (data.value(forKey:"q1") as? String)!
                q2.text = (data.value(forKey:"q2") as? String)!
                q3.text = (data.value(forKey:"q3") as? String)!
                latitude = (data.value(forKey:"latitude") as? Double)!
                longitude = (data.value(forKey:"longitude") as? Double)!
            }
            
        } catch {
            
            print("Failed")
        }
    }
    
    func deleteData(){
        
        //As we know that container is set up in the AppDelegates so we need to refer that container.
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        
        //We need to create a context from this container
        let managedContext = appDelegate.persistentContainer.viewContext
        
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Data")
        fetchRequest.predicate = NSPredicate(format: "id = %@", idFromSegue!)
        
        do {
            let test = try managedContext.fetch(fetchRequest)
            
            let objectToDelete = test[0] as! NSManagedObject
            managedContext.delete(objectToDelete)
            print("Deleted!")
            
            do {
                try managedContext.save()
            }
            catch {
                print(error)
            }
        }
        catch {
            print(error)
        }
    }
  
    override func viewDidLoad() {
        super.viewDidLoad()
        retrieveData()
        
        //disable delete button if there are no records to delete
        if id.text == "" {
            Delbutton.isEnabled = false
        }
        
        //display the anwsers
            id.text = idFromSegue;
        if dob.text == "" {
            dob.text = "Not answered or ID not correct"
        }
        if q1.text == "" {
            q1.text = "Not answered or ID not correct"
        }
        
        if q2.text == "" {
            q2.text = "Not answered or ID not correct"
        }else {
            //change the question depending on answer of previous question
            if q1.text == "Yes" {
                questionString.text = "What is your main use of the iPad?"
            }else {
                questionString.text = "After using the iPad today how would you rate its usability?"
            }
        }
        
        if q3.text == "" {
            q3.text = "Not answered or ID not correct"
        }
        if latitude == nil {
            latLabel.text = "Unknown"
            longLabel.text = "Unknown"
        }else {
            latLabel.text = String(latitude!)
            longLabel.text = String(longitude!)
        }
        
        let locationCoord : CLLocationCoordinate2D = CLLocationCoordinate2DMake(latitude ?? 0.0, longitude ?? 0.0)
        //let userLocation = locations.last
        let viewRegion = MKCoordinateRegion(center: (locationCoord), latitudinalMeters: 600, longitudinalMeters: 600)
        
        //let viewRegion =
        self.map.setRegion(viewRegion, animated: true)
        self.map.showsUserLocation = true
        
    }
}
