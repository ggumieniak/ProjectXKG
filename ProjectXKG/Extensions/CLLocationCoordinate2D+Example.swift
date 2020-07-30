//
//  CLLocationCoordinate2D+Example.swift
//  ProjectXKG
//
//  Created by Grzegorz Gumieniak on 30/07/2020.
//  Copyright © 2020 Grzegorz Gumieniak. All rights reserved.
//

import Foundation
import CoreLocation

extension CLLocationCoordinate2D {
    static var example: CLLocationCoordinate2D {
        let annotation = CLLocationCoordinate2D(latitude: 49.5731321, longitude: 20.4162952) // Browary village
        return annotation
    }
}
