//
//  Student.swift
//  Dorm Activity Tracker Student
//
//  Created by Brian Wilkinson on 3/20/15.
//  Copyright (c) 2015 Brian Wilkinson. All rights reserved.
//

import UIKit

class Student: BAAObject {
   
    var firstName: String
    var lastName: String
    var fullName: String
    var userName: String
    var graduationYear: Int
    var activities: [String] = []

    override init(dictionary: [NSObject: AnyObject]!) {
        
        self.firstName = dictionary["firstName"]! as String
        self.lastName = dictionary["lastName"] as String
        self.fullName = dictionary["fullName"] as String
        self.userName = dictionary["userName"] as String
        self.graduationYear = dictionary["graduationYear"]! as Int
        self.activities = dictionary["activities"] as [String]
        
        super.init(dictionary: dictionary)
    }
    
    override func collectionName() -> String! {
        
        return "document/students"
    }
    
}
