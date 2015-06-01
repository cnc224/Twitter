//
//  User.swift
//  Twitter
//
//  Created by Chen NC on 5/26/15.
//  Copyright (c) 2015 cnc224. All rights reserved.
//

import UIKit

class User: NSObject {
    var name: String?
    var image: String?
    var tagline: String?
    var dict: NSDictionary
    
    init(dict: NSDictionary) {
        self.dict = dict
        name = dict["name"] as? String
        image = dict["profile_image_url"] as? String
        tagline = dict["description"] as? String
    }
    
    
}
