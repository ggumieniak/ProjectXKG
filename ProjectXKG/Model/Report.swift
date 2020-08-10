//
//  Report.swift
//  ProjectXKG
//
//  Created by Grzegorz Gumieniak on 30/07/2020.
//  Copyright © 2020 Grzegorz Gumieniak. All rights reserved.
//

import Foundation
import MapKit

protocol Report {
    var location: CLLocation {get set}
    var description: String {get set}
    var user: User {get set}
    var date: String {get set}
}

// MARK: Initialization
struct ReportDate: Report {
    var date: String
    var description: String
    var location: CLLocation
    var user: User
}
