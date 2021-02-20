//
//  SharedReports.swift
//  ProjectXKG
//
//  Created by Grzegorz Gumieniak on 29/10/2020.
//  Copyright © 2020 Grzegorz Gumieniak. All rights reserved.
//

import Foundation
import MapKit

class SharedReports {
    var localReports: [Report]? {
        willSet {
            if localReports != newValue && localReports != nil && localReports != Optional([]) {
                NotificationPusher.pushNotification(type: K.Firestore.Collection.Categories.localThreaten)
            }
        }
    }
    static var shared = SharedReports()
    var roadAccident: [Report]? {
        willSet {
            if roadAccident != newValue && roadAccident != nil && roadAccident != Optional([]) {
                NotificationPusher.pushNotification(type: K.Firestore.Collection.Categories.roadAccident)
            }
        }
    }
    var weather: [Report]? {
        willSet {
            if weather != newValue && weather != nil && weather != Optional([]){
                NotificationPusher.pushNotification(type: K.Firestore.Collection.Categories.weather)
            }
        }
    }
    var summaryAccidentArray: [MKAnnotation] {
        return (MKPointAnnotationFactory(from: localReports).createPointsToAnnotation() + MKPointAnnotationFactory(from: roadAccident).createPointsToAnnotation() + MKPointAnnotationFactory(from: weather).createPointsToAnnotation())
    }
    
    func resetWeatherArray() {
        self.weather?.removeAll()
    }
    
    func resetRoadArray() {
        self.weather?.removeAll()
    }
}
