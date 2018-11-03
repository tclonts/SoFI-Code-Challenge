//
//  UserController.swift
//  SoFiCodeChallenge
//
//  Created by Tyler Clonts on 10/23/18.
//  Copyright © 2018 Tyler Clonts. All rights reserved.
//

import Foundation
import UIKit

class UserController {
    
    static let shared = UserController()

    var users = [User]()
    
    func fetchUser() {
        
        if let path = Bundle.main.path(forResource: "team", ofType: "json") {
            do {
                let url = URL(fileURLWithPath: path)
                guard let data = try? Data(contentsOf: url) else { return }
        
        let userDictionary = try(JSONSerialization.jsonObject(with: data, options: .mutableContainers))
        
                guard let resultsDictionary = userDictionary as? [[String : Any]] else { return }
                
                for user in resultsDictionary {
                    guard let user = User(dictionary: user) else { return }
                    users.append(user)
                }
            } catch let err {
                    print(err)
            }
        }
    }
}





