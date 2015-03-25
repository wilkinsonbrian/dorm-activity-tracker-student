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
    var activity = Activity()
    
    var name: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        activityTitle.text = activity.name
        activityDescription.text = activity.activityDescription
        remainingSpots.text = String(activity.maximum)
        activityDate.text = activity.eventDate

        // Do any additional setup after loading the view.
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
                
                    studentRecord.saveObjectWithCompletion({(object:AnyObject!, error: NSError!) -> () in
                        if (error == nil) {
                            println("Student record updated")
                        } else {
                            println("Error updating student")
                        }
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
            })
            
            activity.maximum--
            
        } else {
            let alertController = UIAlertController(title: "Activity Full", message: "There are no spots left for this activity", preferredStyle: .Alert)
            
            let defaultAction = UIAlertAction(title: "OK", style: .Default, handler: nil)
            alertController.addAction(defaultAction)
            
            self.presentViewController(alertController, animated: true, completion: nil)
        }
        
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
