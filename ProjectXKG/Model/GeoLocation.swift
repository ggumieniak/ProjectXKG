//
//  GeoLocation.swift
//  ProjectXKG
//
//  Created by Grzegorz Gumieniak on 30/07/2020.
//  Copyright © 2020 Grzegorz Gumieniak. All rights reserved.
//

import Foundation
import MapKit

protocol GeoLocation {
    var latitude: Double {get}
    var longitude: Double {get}
}

// MARK: Initialization
struct Location: GeoLocation {
    var latitude: Double
    var longitude: Double
}
