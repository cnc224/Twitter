//
//  TwitterViewController.swift
//  Twitter
//
//  Created by Chen NC on 5/24/15.
//  Copyright (c) 2015 cnc224. All rights reserved.
//

import UIKit

class TwitterViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var twitterTableView: UITableView!
    var refreshControl: UIRefreshControl!
    var tweets : [NSDictionary]? {
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
        
        // end of Refresh Control
        // Do any additional setup after loading the view.
        TwitterClient.sharedInstance.loadHomeline { (data: [NSDictionary]?) -> Void in
            self.tweets = data
            
        }

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

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        let cell = sender as! TweetCell
        cell.backgroundColor = .lightGrayColor()
        let tweet = tweets![cell.index!]
        let tweetViewController = segue.destinationViewController as! TweetViewController
        tweetViewController.tweet = tweet
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
            TwitterClient.sharedInstance.loadHomeline { (data: [NSDictionary]?) -> Void in
                self.tweets = data
                // only call once at same time.
                // no need to check if there are more refresh
                self.refreshControl.endRefreshing()
            }
            
        })
    }
    // end of Refresh Control
}
