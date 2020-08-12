//
//  CLLocationCoordinate2D+GeoPoint.swift
//  ProjectXKG
//
//  Created by Grzegorz Gumieniak on 12/08/2020.
//  Copyright © 2020 Grzegorz Gumieniak. All rights reserved.
//

import Foundation
import MapKit
import FirebaseFirestore

extension CLLocationCoordinate2D {
    func convertCLLocationCoordinate2DToGeoPoint() -> GeoPoint{
        return GeoPoint(latitude: self.latitude, longitude: self.longitude)
    }
}
