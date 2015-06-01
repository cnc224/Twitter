//
//  HomeViewController.swift
//  Twitter
//
//  Created by Chen NC on 6/1/15.
//  Copyright (c) 2015 cnc224. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var menuView: UITableView!
    @IBOutlet weak var containerView: UIView!
    // view controllers
    var profileViewController: ProfileViewController!
    var twitterViewController: TwitterViewController!
    var mentionsViewController: MentionsViewController!
    
    var activeViewController: UIViewController? {
        didSet(oldViewControllerorNil) {
            if let oldVC = oldViewControllerorNil {
                oldVC.willMoveToParentViewController(nil)
                oldVC.view.removeFromSuperview()
                oldVC.removeFromParentViewController()
            }
            if let newVC = activeViewController {
                self.addChildViewController(newVC)
                newVC.view.frame = self.containerView.bounds
                self.containerView.addSubview(newVC.view)
                newVC.didMoveToParentViewController(self)
            }
            
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        profileViewController = storyboard.instantiateViewControllerWithIdentifier("ProfileViewController") as! ProfileViewController
        profileViewController.user = TwitterClient.sharedInstance.currentUser
        twitterViewController = storyboard.instantiateViewControllerWithIdentifier("TwitterViewController") as! TwitterViewController
        mentionsViewController = storyboard.instantiateViewControllerWithIdentifier("MentionsViewController") as! MentionsViewController
        
        menus = [["name": "Profile", "controller": profileViewController], ["name": "Timeline", "controller": twitterViewController], ["name": "Mentions", "controller": mentionsViewController]]
        menuView.reloadData()
        menuView.delegate = self
        menuView.dataSource = self
        activeViewController = twitterViewController
        
        // add Sign Out button
        var leftBarButton = UIBarButtonItem(title: "Sign Out", style: UIBarButtonItemStyle.Plain, target: self, action: "onLogout")
        self.navigationItem.leftBarButtonItem = leftBarButton;
        
        view.backgroundColor = TwitterClient.sharedInstance.backgroundColor
        
        var leftSwipe = UISwipeGestureRecognizer(target: self, action: Selector("onSwipe:"))
        var rightSwipe = UISwipeGestureRecognizer(target: self, action: Selector("onSwipe:"))
        
        leftSwipe.direction = .Left
        rightSwipe.direction = .Right
        
        containerView.addGestureRecognizer(leftSwipe)
        containerView.addGestureRecognizer(rightSwipe)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return menus!.count
    }
    
    var menus: [NSDictionary]?
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCellWithIdentifier("MenuCell", forIndexPath: indexPath) as! MenuCell
        cell.menuNameLabel.text = menus![indexPath.row]["name"] as? String
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        activeViewController = menus![indexPath.row]["controller"] as? UIViewController
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

    func showMenu() {
        UIView.animateWithDuration(0.3, animations: { () -> Void in
            self.containerView.frame.origin.x = self.menuView.frame.width
        })
    }
    
    func hideMenu() {
        UIView.animateWithDuration(0.3, animations: { () -> Void in
            self.containerView.frame.origin.x = 0
        })
    }
    func onSwipe(sender: UISwipeGestureRecognizer) {
        if (sender.direction == .Left) {
            println("Swipe Left")
            hideMenu()
        }
        
        if (sender.direction == .Right) {
            println("Swipe Right")
            showMenu()
        }
    }
    
}
