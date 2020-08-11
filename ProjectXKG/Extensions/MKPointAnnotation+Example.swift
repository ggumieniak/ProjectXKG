//
//  MKPointAnnotation+Example.swift
//  ProjectXKG
//
//  Created by Grzegorz Gumieniak on 20/07/2020.
//  Copyright © 2020 Grzegorz Gumieniak. All rights reserved.
//

import Foundation
import MapKit

extension MKPointAnnotation {
    static var example: MKPointAnnotation {
        let annotation = MKPointAnnotation()
        annotation.title = "Stalowa Wola"
        annotation.subtitle = "Centrum Edukacji Zawodowej w Stalowej Woli"
        annotation.coordinate = CLLocationCoordinate2D(latitude: 50.5562, longitude: 22.0422)
        return annotation
    }
}
