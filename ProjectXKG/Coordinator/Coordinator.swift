//
//  Coordinator.swift
//  ProjectXKG
//
//  Created by Grzegorz Gumieniak on 21/07/2020.
//  Copyright © 2020 Grzegorz Gumieniak. All rights reserved.
//

import Foundation
import MapKit

final class Coordinator: NSObject, MKMapViewDelegate {
    
    var control: MapView
        
    init(_ control: MapView) {
        self.control = control
    }
}
