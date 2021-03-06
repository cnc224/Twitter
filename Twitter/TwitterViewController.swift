//
//  TwitterViewController.swift
//  Twitter
//
//  Created by Chen NC on 5/24/15.
//  Copyright (c) 2015 cnc224. All rights reserved.
//

import UIKit

class TwitterViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var tweetField: UITextField?
    @IBAction func onSendTweet(sender: AnyObject) {
        if let text = tweetField?.text {
            TwitterClient.sharedInstance.tweet(text, completion: { (success: Bool?, error: NSError?) -> Void in
                if let success = success {
                    self.tweetField?.text = ""
                    // TODO no need to load, just add to top
                    TwitterClient.sharedInstance.loadHomeline(nil, completion: { (data: [Tweet]?) -> Void in
                        self.tweets = data
                    })
                }
            })
        }
    }
    @IBOutlet weak var twitterTableView: UITableView!
    var refreshControl: UIRefreshControl!
    var tweets : [Tweet]? {
        didSet {
            twitterTableView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        // Refresh Control
        refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: "onRefresh", forControlEvents: UIControlEvents.ValueChanged)
            twitterTableView.insertSubview(refreshControl, atIndex: 0)
        
        twitterTableView.rowHeight = UITableViewAutomaticDimension
        twitterTableView.estimatedRowHeight = 120
        
        // end of Refresh Control
        // Do any additional setup after loading the view.
        TwitterClient.sharedInstance.loadHomeline(nil, completion: { (data: [Tweet]?) -> Void in
            self.tweets = data
        })

        
    }
    
    func onLogout() {
        TwitterClient.sharedInstance.logout()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tweets != nil ? tweets!.count : 0
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCellWithIdentifier("TweetCell", forIndexPath: indexPath) as! TweetCell
        cell.tweet = tweets![indexPath.row]
        cell.index = indexPath.row
        return cell
    }
    
    // Refresh Control
    func delay(delay:Double, closure:()->()) {
        dispatch_after(
            dispatch_time(
                DISPATCH_TIME_NOW,
                Int64(delay * Double(NSEC_PER_SEC))
            ),
            dispatch_get_main_queue(), closure)
    }
    
    func onRefresh() {
        delay(2, closure: {
            // pull request again here
            TwitterClient.sharedInstance.loadHomeline(nil, completion: { (data: [Tweet]?) -> Void in
                self.tweets = data
                // only call once at same time.
                // no need to check if there are more refresh
                self.refreshControl.endRefreshing()
            })
            
        })
    }
    // end of Refresh Control
    
}
