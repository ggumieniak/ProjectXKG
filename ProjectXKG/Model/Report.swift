//
//  Report.swift
//  ProjectXKG
//
//  Created by Grzegorz Gumieniak on 30/07/2020.
//  Copyright © 2020 Grzegorz Gumieniak. All rights reserved.
//

import Foundation
import MapKit

protocol ReportType {
    var location: CLLocationCoordinate2D {get set}
    var description: String {get set}
    var user: String {get set}
    var date: String {get set}
}

// MARK: Initialization
struct Report: ReportType {
    var date: String
    var description: String
    var location: CLLocationCoordinate2D
    var user: String
    
    init(date: String, description: String, location: CLLocationCoordinate2D, user: String) {
        self.date = date
        self.description = description
        self.location = location
        self.user = user
    }
}
