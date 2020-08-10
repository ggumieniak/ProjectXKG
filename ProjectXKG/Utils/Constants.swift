//
//  Constants.swift
//  ProjectXKG
//
//  Created by Grzegorz Gumieniak on 29/07/2020.
//  Copyright © 2020 Grzegorz Gumieniak. All rights reserved.
//

import Foundation

struct K {
    struct Firestore {
        static let category: String = "category"
        struct Categories {
            static let roadAccident: String = "Road Accident"
            static let weather: String = "Weather"
            static let localThreaten: String = "Local Threaten"
            struct Fields {
                static let date: String = "Date"
                static let description: String = "Description"
                static let location: String = "Location"
                static let user: String = "User"
                static let category: String = "Category"
            }
        }
    }
    
}

