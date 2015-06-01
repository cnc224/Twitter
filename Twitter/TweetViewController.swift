//
//  TweetViewController.swift
//  Twitter
//
//  Created by Chen NC on 5/24/15.
//  Copyright (c) 2015 cnc224. All rights reserved.
//

import UIKit

class TweetViewController: UIViewController {
    
    @IBOutlet weak var tweetLabel: UILabel!
    var tweet : Tweet?
    
    @IBAction func onRetweet(sender: AnyObject) {
        //TwitterClient.sharedInstance.retweet(tweet!["id"] as! Int)
    }
    
    @IBAction func onFavorite(sender: AnyObject) {
        //TwitterClient.sharedInstance.favorite(tweet!["id"] as! Int)
    }
    
    @IBAction func onReply(sender: AnyObject) {
        //TwitterClient.sharedInstance.reply(tweet!["id"] as! Int)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        //tweetLabel.text = tweet!["text"] as? String
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
