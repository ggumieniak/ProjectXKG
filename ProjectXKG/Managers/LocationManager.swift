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
    @Published var location: CLLocation? {
        willSet {
            // TODO: Delete in production statement
            // Checking the new coordinate
            print("Moving \(newValue?.coordinate ?? CLLocationCoordinate2D.example)")
        }
    }
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
// MARK: Share location and privilages
extension LocationManager: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.last else {
            return
        }
        self.location = location
    }
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        self.authorizationStatus = status
    }
}
// MARK: Authorization
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
            print("Nie nadano zadnych uprawnien")
            return false
        }
    }
}
// MARK: Accessors
extension LocationManager {
    func get2DLocationCoordinate() -> CLLocationCoordinate2D? {
        return location?.coordinate
    }
}

// MARK: UpdatingLocation
extension LocationManager {
    func stopUpdatingWhileReporting() -> Void {
        self.locationManager.stopUpdatingLocation()
    }
    func startUpdatingWhileReporting() -> Void {
        self.locationManager.startUpdatingLocation()
    }
}
