//
//  Report.swift
//  ProjectXKG
//
//  Created by Grzegorz Gumieniak on 30/07/2020.
//  Copyright © 2020 Grzegorz Gumieniak. All rights reserved.
//

import Foundation
import MapKit

protocol ReportType: Equatable, Identifiable {
    var id: String {get}
    var location: CLLocationCoordinate2D {get}
    var description: String {get}
    var user: String {get}
    var date: String {get}
}

// MARK: Initialization
struct Report: ReportType {
    var id: String
    var date: String
    var description: String
    var location: CLLocationCoordinate2D
    var user: String
    
    init(id: String,date: String, description: String, location: CLLocationCoordinate2D, user: String) {
        self.id = id
        self.date = date
        self.description = description
        self.location = location
        self.user = user
    }
    
    static func == (lhs: Report, rhs: Report) -> Bool {
        return lhs.id == rhs.id
    }
    
}
