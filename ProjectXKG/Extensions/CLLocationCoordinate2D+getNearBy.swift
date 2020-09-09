//
//  GeoPoint+getNearBy.swift
//  ProjectXKG
//
//  Created by Grzegorz Gumieniak on 09/09/2020.
//  Copyright © 2020 Grzegorz Gumieniak. All rights reserved.
//

import Foundation
import FirebaseFirestore
import CoreLocation

extension CLLocationCoordinate2D {
    func getNearBy(at location: CLLocationCoordinate2D) -> (lesserGeoPoint: GeoPoint,greaterGeoPoint: GeoPoint) {
        
        // TODO: Delete after make entire code
        return (GeoPoint(latitude: 0.0, longitude: 0.0),GeoPoint(latitude: 1.0, longitude: 1.0))
    }
}
