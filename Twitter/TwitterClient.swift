//
//  TwitterClient.swift
//  Twitter
//
//  Created by Chen NC on 5/20/15.
//  Copyright (c) 2015 cnc224. All rights reserved.
//

import UIKit

let twitterBaseUrl = NSURL(string: "https://api.twitter.com")
let twitterConsumerKey = "4t0TQjT06jv81AHKkVW9vMkhB"
let twitterConsumerSecret = "dzV5tP3a1Z95FFwDiAY9SRdq9Ho7gblFXUccOWJzX4jJmKtFV7"

class TwitterClient: BDBOAuth1RequestOperationManager {
    struct Static {
        static var instance = TwitterClient(baseURL: twitterBaseUrl,
            consumerKey: twitterConsumerKey,
            consumerSecret: twitterConsumerSecret)
    }
    
    class var sharedInstance : TwitterClient {
        get { return Static.instance }
    }
    var loginCompletion: ((success: Bool?, error: NSError?) -> Void)?
    func checkLogin() -> Bool {
        return requestSerializer.accessToken != nil
    }
    func login(completion: ((Bool?, NSError?) -> Void)? ) {
        loginCompletion = completion
        requestSerializer.removeAccessToken()
        fetchRequestTokenWithPath("oauth/request_token", method: "GET", callbackURL: NSURL(string: "cptwitterdemo://oauth"), scope: nil, success: { (requestToken: BDBOAuth1Credential!) -> Void in
            println("success in fetchRequestTokenWithPath")
            
            var authURL = NSURL(string: "https://api.twitter.com/oauth/authorize?oauth_token=\(requestToken.token)")!
            UIApplication.sharedApplication().openURL(authURL)
            /*self.fetchAccessTokenWithPath("oauth/authorize", method: "GET", requestToken: requestToken, success: { (accessToken: BDBOAuth1Credential!) -> Void in
                println("success in fetchAccessTokenWithPath")
            }, failure: { (error: NSError!) -> Void in
                println("error fetchAccessTokenWithPath")
                println(error)
            })*/
            
        }) { (error: NSError!) -> Void in
            println("error fetchRequestTokenWithPath")
        }
    }
    
    func openAuthURL(authURL: NSURL) {
        fetchAccessTokenWithPath("oauth/access_token", method: "POST", requestToken: BDBOAuth1Credential(queryString: authURL.query), success: { (accessToken: BDBOAuth1Credential!) -> Void in
            println("success in fetchAccessTokenWithPath")
            TwitterClient.sharedInstance.requestSerializer.saveAccessToken(accessToken)
            self.loginCompletion?(success: true, error: nil)
            
        }) { (error: NSError!) -> Void in
                println("failed in fetchAccessTokenWithPath")
                self.loginCompletion!(success: false, error: error)
        }
    }
    // login 
    
    func loadHomeline(completion: (([NSDictionary]?) -> Void)?) {
        GET("https://api.twitter.com/1.1/statuses/home_timeline.json", parameters: nil, success: { (operation: AFHTTPRequestOperation!, data: AnyObject!) -> Void in
            println(data)
            completion!(data as? [NSDictionary])
        }, failure: { (operation: AFHTTPRequestOperation!, error: NSError!) -> Void in
            println(error)
        })
    }

    func tweet(status: String) {
        GET("https://api.twitter.com/1.1/statuses/update.json?status="+status, parameters: nil, success: { (operation: AFHTTPRequestOperation!, data: AnyObject!) -> Void in
            
            }) { (operation: AFHTTPRequestOperation!, error: NSError!) -> Void in
            
        }
    }
    func retweet(id: Int) {
        GET("https://api.twitter.com/1.1/statuses/retweet/"+String(id)+".json", parameters: nil, success: { (operation: AFHTTPRequestOperation!, data: AnyObject!) -> Void in
            
            }) { (operation: AFHTTPRequestOperation!, error: NSError!) -> Void in
                
        }
    }
    
    func favorite(id: Int) {
        GET("https://api.twitter.com/1.1/favorites/create.json?id="+String(id), parameters: nil, success: { (operation: AFHTTPRequestOperation!, data: AnyObject!) -> Void in
            
            }) { (operation: AFHTTPRequestOperation!, error: NSError!) -> Void in
                
        }
        
    }
    
    func reply(id: Int) {
        GET("https://api.twitter.com/1.1/statuses/retweet.json?id="+String(id), parameters: nil, success: { (operation: AFHTTPRequestOperation!, data: AnyObject!) -> Void in
            
            }) { (operation: AFHTTPRequestOperation!, error: NSError!) -> Void in
                
        }
    }
}
