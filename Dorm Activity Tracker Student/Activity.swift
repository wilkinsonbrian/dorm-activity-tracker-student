//
//  Activity.swift
//  Dorm Activity Tracker Admin
//
//  Created by Brian Wilkinson on 2/7/15.
//  Copyright (c) 2015 Brian Wilkinson. All rights reserved.
//

import UIKit

class Activity: BAAObject {
    var name: String
    var maximum: Int
    var activityDescription: String
    var eventDate: String
    var startTime: String
    var endTime: String
    var participantsSignedUp: [String] = []
    var participantsAttended: [String] = []
    
    
    override init(dictionary: [NSObject: AnyObject]!) {
        
        self.name = dictionary["name"]! as String
        self.maximum = dictionary["maximum"]! as Int
        
        self.activityDescription = dictionary["activityDescription"]! as String
        
        self.eventDate = dictionary["eventDate"]! as String
        self.startTime = dictionary["startTime"]! as String
        self.endTime = dictionary["endTime"]! as String
        
        self.participantsSignedUp = dictionary["participantsSignedUp"] as [String]
        self.participantsAttended = dictionary["participantsAttended"] as [String]
        
        super.init(dictionary: dictionary)
    }
    
    override func collectionName() -> String! {
        
        return "document/activities"
    }
    
}
