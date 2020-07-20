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
        annotation.title = "London"
        annotation.subtitle = "Jakas przykladowa lokalizacja"
        annotation.coordinate = CLLocationCoordinate2D(latitude: 51.1, longitude: 0.12)
        return annotation
    }
}
