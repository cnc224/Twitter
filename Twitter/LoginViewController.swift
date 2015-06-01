//
//  ViewController.swift
//  Twitter
//
//  Created by Chen NC on 5/20/15.
//  Copyright (c) 2015 cnc224. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = TwitterClient.sharedInstance.backgroundColor
        // Do any additional setup after loading the view, typically from a nib.
        if TwitterClient.sharedInstance.checkLogin() {
            performSegueWithIdentifier("LoginSegue", sender: self)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func onTwitterLogin(sender: AnyObject) {
        TwitterClient.sharedInstance.loginWithCompletion {
            (success: Bool?, error: NSError?)-> Void in
            self.performSegueWithIdentifier("LoginSegue", sender: self)
        }
    }

}

