//
//  LocationManager.swift
//  ProjectXKG
//
//  Created by Grzegorz Gumieniak on 21/07/2020.
//  Copyright © 2020 Grzegorz Gumieniak. All rights reserved.
//

import Foundation
import CoreLocation
import Combine
import UIKit

final class LocationManager: NSObject, ObservableObject, CLLocationManagerDelegate {
    private let locationManager = CLLocationManager()
    
    public let locationWillChange = PassthroughSubject<CLLocation, Never>()
    
    @Published public private(set) var location: CLLocation? {
        willSet {
            locationWillChange.send(newValue ?? CLLocation())
        }
    }
    
    override init() {
        super.init()
        self.locationManager.delegate = self
        self.locationManager.allowsBackgroundLocationUpdates = true
        self.locationManager.pausesLocationUpdatesAutomatically = false
        self.locationManager.showsBackgroundLocationIndicator = true
    }
}
