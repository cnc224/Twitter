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
    
    var index: Int?
    var tweet : Tweet? {
        didSet {
            profileImageView.setImageWithURL(NSURL(string: (tweet?.user?.image!)!))
            timestampLabel.text = tweet?.createdAtString
            tweetLabel.text = tweet?.text
            usernameLabel.text = tweet?.user?.name
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
