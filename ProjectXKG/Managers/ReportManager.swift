//
//  ReportManager.swift
//  ProjectXKG
//
//  Created by Grzegorz Gumieniak on 04/08/2020.
//  Copyright © 2020 Grzegorz Gumieniak. All rights reserved.
//

import Foundation
import MapKit

// MARK: Initialization
class ReportManager {
    private let reportService = ReportService()
    private var timer = Timer()
    private var counter:Int = 0
    private var pauseTimer = 360
    private var data = [Report]()
    @Published var annotation = [MKPointAnnotation]()
}
//MARK: Accesors
extension ReportManager {
    private func getReportAnnotations() -> [MKPointAnnotation] {
        return MKPointAnnotationFactory(from: data).createPointsToAnnotation()
    }
}

// MARK: Fetch data
extension ReportManager {    
    func downloadData(at location: CLLocationCoordinate2D) {
        reportService.fetchData(at: location) { reports in
            self.data = FirebaseDataClassifier(from: reports).getDataToShow()
            self.annotation = self.getReportAnnotations()
            return self.annotation
        }
        
        
    }
    func getAnnotation() -> [MKPointAnnotation] {
        return annotation
    }
}

