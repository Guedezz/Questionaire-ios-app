//
//  questionaire.swift
//  portfolio1
//
//  Created by Carlos Guedes on 28/02/2019.
//  Copyright © 2019 Carlos Guedes. All rights reserved.
//

import Foundation

class Questions {
    var id: String
    var dob: String
    var q1: String
    var q2: String
    var q3: String
    var latitude: Double
    var longitude: Double
    
    init(id:String,dob:String, q1:String, q2:String, q3:String, latitude: Double, longitude: Double) {
        self.id = id
        self.dob = dob
        self.q1 = q1
        self.q2 = q2
        self.q3 = q3
        self.latitude = latitude
        self.longitude = longitude
    }
}
