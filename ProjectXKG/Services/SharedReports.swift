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
    static var shared = SharedReports()
    private var localThreaten = [MKAnnotation]()
    private var roadAccident = [MKAnnotation]()
    private var weather = [MKAnnotation]()
    var summaryAccidentArray = [MKAnnotation]()
    
    func setLocalThreatenArray(from reports:[MKAnnotation]) {
        self.localThreaten = reports
    }
    func setRoadAccidentArray(from reports:[MKAnnotation]) {
        self.roadAccident = reports
    }
    func setWeatherArray(from reports:[MKAnnotation]) {
        self.weather = reports
    }
    
    func getSummaryAccidentArray() -> [MKAnnotation] {
        summaryAccidentArray.removeAll()
        summaryAccidentArray = localThreaten + roadAccident + weather
        return summaryAccidentArray
    }
}
