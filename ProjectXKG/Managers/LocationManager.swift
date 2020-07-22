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

final class LocationManager: NSObject, ObservableObject {
    private let locationManager = CLLocationManager()
    @Published var location: CLLocation? = nil
    @Published var authorizationStatus: CLAuthorizationStatus?
    
    override init() {
        super.init()
        self.locationManager.delegate = self
        self.locationManager.allowsBackgroundLocationUpdates = true
        self.locationManager.pausesLocationUpdatesAutomatically = false
        self.locationManager.showsBackgroundLocationIndicator = true
        self.locationManager.desiredAccuracy = kCLLocationAccuracyBest
        self.locationManager.requestAlwaysAuthorization()
        self.locationManager.startUpdatingLocation()
    }
}

// MARK: Udostepnianie lokalizacji

extension LocationManager: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.last else {
            return
        }
        self.location = location
    }
}

// MARK: Autoryzacja
extension LocationManager {
    func checkAuthorizationStatus() -> Bool {
        if let status = self.authorizationStatus {
            switch status {
            case .notDetermined,.denied,.restricted:
                return false
            default:
                return true
            }
        } else {
            return false
        }
    }
    
    func requestAuthorization() {
        self.locationManager.requestAlwaysAuthorization()
        self.locationManager.startUpdatingLocation()
    }
}
