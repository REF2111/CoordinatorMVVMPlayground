//
//  UserManager.swift
//  CoordinatorPlayground
//
//  Created by Raphael Berendes on 11.01.20.
//  Copyright © 2020 Raphael-Alexander Berendes. All rights reserved.
//

import Foundation

class UserManager {
    
    static var isUserLoggedIn = false
    
    static var username: String {
        UserDefaults.standard.value(forKey: "username") as! String
    }
    
    static var password: String {
        UserDefaults.standard.value(forKey: "password") as! String
    }
    
    static func register(withUsername username: String,
                         andPassword password: String) {
        
        UserDefaults.standard.set(username, forKey: "username")
        UserDefaults.standard.set(password, forKey: "password")
    }
    
    static func login(withUsername username: String,
                         andPassword password: String) -> Bool {
        isUserLoggedIn =
            UserManager.username == username &&
            UserManager.password == password
        
        return isUserLoggedIn
    }

}
