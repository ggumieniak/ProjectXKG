//
//  User.swift
//  ProjectXKG
//
//  Created by Grzegorz Gumieniak on 17/07/2020.
//  Copyright © 2020 Grzegorz Gumieniak. All rights reserved.
//

import Foundation

// MARK: Initialization
struct User {
    var uid: String
    var email: String?
    
    init(uid: String, email: String?) {
        self.uid = uid
        self.email = email
    }
}
