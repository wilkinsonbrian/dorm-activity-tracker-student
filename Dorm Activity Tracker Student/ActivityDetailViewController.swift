//
//  ActivityDetailViewController.swift
//  Dorm Activity Tracker Student
//
//  Created by Brian Wilkinson on 2/22/15.
//  Copyright (c) 2015 Brian Wilkinson. All rights reserved.
//

import UIKit

class ActivityDetailViewController: UIViewController {

    @IBOutlet weak var activityTitle: UILabel!
    @IBOutlet weak var activityDate: UILabel!
    @IBOutlet weak var activityDescription: UILabel!
    @IBOutlet weak var remainingSpots: UILabel!
    @IBOutlet weak var registerButton: UIButton!
    @IBOutlet weak var cancelRegistrationButton: UIButton!
    
    var activity = Activity()
    
    var name: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        activityTitle.text = activity.name
        activityDescription.text = activity.activityDescription
        remainingSpots.text = String(activity.maximum)
        activityDate.text = activity.eventDate
        registerButton.enabled = true
        cancelRegistrationButton.enabled = false

        var currentUser = BAAUser()
        
        BAAUser.loadCurrentUserWithCompletion({(object:AnyObject!, error:NSError!) -> () in
            currentUser = object as BAAUser
            let parameters = ["where": "userName='\(currentUser.username())'"]
            Student.getObjectsWithParams(parameters, {(student:[AnyObject]!, error:NSError!) -> () in
                
                var studentRecord: Student
                studentRecord = student[0] as Student
                
                for studentID in self.activity.participantsSignedUp {
                    if studentID == studentRecord.objectId {
                        self.registerButton.enabled = false
                        self.cancelRegistrationButton.enabled = true
                    }
                }
            })
        })
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBAction func registerForActivity(sender: UIButton) {
        var currentUser = BAAUser()
        
        if activity.maximum > 0 {
        
            BAAUser.loadCurrentUserWithCompletion({(object:AnyObject!, error: NSError!) -> () in
            
                currentUser = object as BAAUser
            
                let parameters = ["where": "userName='\(currentUser.username())'"]
                Student.getObjectsWithParams(parameters, {(student: [AnyObject]!, error:NSError!) -> () in
                
                    var studentRecord: Student
                    studentRecord = student[0] as Student
                    self.activity.participantsSignedUp.append(studentRecord.objectId)
                
                        self.activity.saveObjectWithCompletion({(object:AnyObject!, error: NSError!) -> () in
                            if (error == nil) {
                                let alertController = UIAlertController(title: "Registration", message: "You have registered for this activity", preferredStyle: .Alert)
                            
                                let defaultAction = UIAlertAction(title: "OK", style: .Default, handler: nil)
                                alertController.addAction(defaultAction)
                            
                                self.presentViewController(alertController, animated: true, completion: nil)
                            } else {
                                println("So much fail")
                            }
                    })
                })
            })
            
            activity.maximum--
            registerButton.enabled = false
            cancelRegistrationButton.enabled = true
            
        } else {
            let alertController = UIAlertController(title: "Activity Full", message: "There are no spots left for this activity", preferredStyle: .Alert)
            
            let defaultAction = UIAlertAction(title: "OK", style: .Default, handler: nil)
            alertController.addAction(defaultAction)
            
            self.presentViewController(alertController, animated: true, completion: nil)
        }
        
    }
    
    @IBAction func cancelRegistration(sender: UIButton) {
        var currentUser = BAAUser()
        
        BAAUser.loadCurrentUserWithCompletion({(object:AnyObject!, error: NSError!) -> () in
            
            currentUser = object as BAAUser
            
            let parameters = ["where": "userName='\(currentUser.username())'"]
            Student.getObjectsWithParams(parameters, {(student: [AnyObject]!, error:NSError!) -> () in
                
                var studentRecord: Student
                studentRecord = student[0] as Student
                
                for var x = 0; x < self.activity.participantsSignedUp.count; ++x {
                    if self.activity.participantsSignedUp[x] == studentRecord.objectId {
                        self.activity.participantsSignedUp.removeAtIndex(x)
                    }
                }
                self.activity.saveObjectWithCompletion({(object:AnyObject!, error: NSError!) -> () in
                    if (error == nil) {
                        let alertController = UIAlertController(title: "Registration", message: "You have canceled your registration for this activity", preferredStyle: .Alert)
                        
                        let defaultAction = UIAlertAction(title: "OK", style: .Default, handler: nil)
                        alertController.addAction(defaultAction)
                        
                        self.presentViewController(alertController, animated: true, completion: nil)
                    } else {
                        println("So much fail")
                    }
                })
            })
        })
        registerButton.enabled = true
        cancelRegistrationButton.enabled = false
        activity.maximum++
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
