//
//  TwitCell.swift
//  Twitter
//
//  Created by Chen NC on 5/24/15.
//  Copyright (c) 2015 cnc224. All rights reserved.
//

import UIKit

class TweetCell: UITableViewCell {

    @IBOutlet weak var timestampLabel: UILabel!
    @IBOutlet weak var tweetLabel: UILabel!
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var profileImageView: UIImageView!
    
    var tweetText: String?
    var index: Int?
    var tweet : NSDictionary? {
        didSet {
            profileImageView.setImageWithURL(NSURL(fileURLWithPath: (tweet!.valueForKeyPath("user.profile_image_url") as? String)!))
            timestampLabel.text = tweet!["created_at"] as? String
            tweetLabel.text = tweet!["text"] as? String
            usernameLabel.text = tweet!.valueForKeyPath("user.name") as? String
            tweetText = tweet!["text"] as? String
        }
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
