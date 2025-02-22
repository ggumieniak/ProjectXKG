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
    var delegate: MapView?
    private let locationManager = CLLocationManager()
    @Published var location: CLLocation?
    private var authorizationStatus: CLAuthorizationStatus?
    
    override init() {
        super.init()
        self.locationManager.delegate = self
        self.locationManager.allowsBackgroundLocationUpdates = true
        self.locationManager.pausesLocationUpdatesAutomatically = false
        self.locationManager.showsBackgroundLocationIndicator = false
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
            return false
        }
    }
    
    func checkAccuracyStatus() -> Bool {
        if #available(iOS 14.0, *) {
            switch locationManager.accuracyAuthorization {
            case .fullAccuracy:
                return true
            case .reducedAccuracy:
                return false
            @unknown default:
                fatalError()
            }
        }
        return true
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
    func stopUpdatingWhileReporting() {
        self.locationManager.stopUpdatingLocation()
    }
    
    func startUpdatingWhileReporting() {
        self.locationManager.startUpdatingLocation()
    }
}
