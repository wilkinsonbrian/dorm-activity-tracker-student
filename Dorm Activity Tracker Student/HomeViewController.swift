//
//  HomeViewController.swift
//  Dorm Activity Tracker Student
//
//  Created by Brian Wilkinson on 2/19/15.
//  Copyright (c) 2015 Brian Wilkinson. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {

    @IBOutlet weak var statusLabel: UILabel!
    let client = BAAClient.sharedClient()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(animated: Bool)  {
        
        super.viewWillAppear(animated)
        
        
        
        if client.isAuthenticated() {
            
            statusLabel.text = "Logged in"
            
        } else {
            
            statusLabel.text = "Not logged in"
            
            self.navigationController?.performSegueWithIdentifier("showLogin", sender: nil)
            
        }      
        
    }

    @IBAction func logoutTapped(sender: UIButton) {
        client.logoutWithCompletion({(success: Bool, error: NSError!) -> () in
            
            if (success) {
                self.navigationController?.performSegueWithIdentifier("showLogin", sender: nil)
            } else {
                println(error)
            }
        })
    }
    
    @IBAction func viewCurrentAvtivities(sender: UIButton) {
        navigationController?.performSegueWithIdentifier("viewAndRegisterForActivities", sender: nil)
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
