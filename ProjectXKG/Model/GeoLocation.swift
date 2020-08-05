//
//  GeoLocation.swift
//  ProjectXKG
//
//  Created by Grzegorz Gumieniak on 30/07/2020.
//  Copyright © 2020 Grzegorz Gumieniak. All rights reserved.
//

import Foundation

protocol GeoLocation {
    var latitude: Double {get set}
    var longitude: Double {get set}
}

// MARK: Initialization
struct Location: GeoLocation {
    var latitude: Double
    var longitude: Double
}
