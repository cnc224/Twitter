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
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func onTwitterLogin(sender: AnyObject) {
        TwitterClient.sharedInstance.login {
            (success: Bool?, error: NSError?)-> Void in
            self.performSegueWithIdentifier("LoginSegue", sender: self)
        }
    }

}

