//
//  CLLocation+GeoPoint.swift
//  ProjectXKG
//
//  Created by Grzegorz Gumieniak on 30/07/2020.
//  Copyright © 2020 Grzegorz Gumieniak. All rights reserved.
//

import Foundation
import CoreLocation
import FirebaseFirestore

extension CLLocation {
    func convertCLLocationToGeoPoint() -> GeoPoint{
        return GeoPoint(latitude: self.coordinate.latitude, longitude: self.coordinate.longitude)
    }
}
