//
//  User.swift
//  SoFiCodeChallenge
//
//  Created by Tyler Clonts on 10/23/18.
//  Copyright © 2018 Tyler Clonts. All rights reserved.
//

import Foundation

class User {
  
        private let avatarKey = "avatar"
        private let bioKey = "bio"
        private let titleKey = "title"
        
        var avatar: String
        var bio: String
        var title: String
        
        init(avatar: String, bio: String, title: String) {
            self.avatar = avatar
            self.bio = bio
            self.title = title
        }
        
        init?(dictionary: [String : Any]) {
            guard let avatar = dictionary[avatarKey] as? String,
                let bio = dictionary[bioKey] as? String,
                let title = dictionary[titleKey] as? String else { return nil }
            
            self.avatar = avatar
            self.bio = bio
            self.title = title
        }
        
}
