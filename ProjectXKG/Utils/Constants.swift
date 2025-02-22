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
        struct Collection {
            static let users: String = "Users"
            static let categories: String = "Categories"
            struct Categories {
                static let roadAccident: String = "RoadAccident"
                static let weather: String = "Weather"
                static let localThreaten: String = "LocalThreaten"
                struct Report {
                    static let reports: String = "Reports"
                    struct Fields {
                        static let uuid: String = "uuid"
                        static let date: String = "Date"
                        static let title: String = "Title"
                        static let description: String = "Description"
                        static let location: String = "Location"
                    }
                }
            }
        }
    }
    struct AlertView {
        static let minimumLengthOfDescription: Int = 20
    }
    struct MapView {
        static let timeUntilNextReport: Int = 5   // How many seconds has to passed to one more time to unlock ReportButton
    }
    struct UserDefaultKeys {
        static let distance: String = "Distance"
    }
}

