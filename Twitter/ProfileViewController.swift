//
//  ProfileViewController.swift
//  Twitter
//
//  Created by Chen NC on 5/31/15.
//  Copyright (c) 2015 cnc224. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController {

    var user: User?
    @IBOutlet weak var tweetsCountLabel: UILabel!
    @IBOutlet weak var twitterNameLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var profileImageView: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()

        nameLabel.text = user?.name
        profileImageView.setImageWithURL(NSURL(string: (user?.image!)!))
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
