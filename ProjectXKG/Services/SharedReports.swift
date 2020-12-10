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
            if localReports != newValue {
                print("sa rozne lokalne")
            }
        }
    }
    static var shared = SharedReports()
    var roadAccident: [Report]? {
        willSet {
            if localReports != newValue {
                print("sa rozne drogowe")
            }
        }
    }
    var weather: [Report]? {
        willSet {
            if localReports != newValue {
                print("sa rozne pogodowe")
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
