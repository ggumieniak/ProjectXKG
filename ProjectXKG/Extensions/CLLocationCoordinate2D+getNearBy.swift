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
    func getNearBy(at location: CLLocationCoordinate2D,with accuracy: Double) -> (lesserGeoPoint: GeoPoint,greaterGeoPoint: GeoPoint) {
        let geoDistance = 0.01 // around 1.11km
        let distance = geoDistance * accuracy
        let lowerLat = location.latitude.advanced(by: -distance)
        let lowerLon = location.longitude.advanced(by: -distance)
        let lowerGeoPoint = GeoPoint(latitude: lowerLat, longitude: lowerLon)
        let greaterLat = location.latitude.advanced(by: distance)
        let greaterLon = location.longitude.advanced(by: distance)
        let greaterGeoPoint = GeoPoint(latitude: greaterLat, longitude: greaterLon)
 
        return (lowerGeoPoint,greaterGeoPoint)
    }
}
