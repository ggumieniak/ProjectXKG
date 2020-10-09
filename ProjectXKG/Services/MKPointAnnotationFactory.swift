//
//  MKAnnotationFactory.swift
//  ProjectXKG
//
//  Created by Grzegorz Gumieniak on 11/08/2020.
//  Copyright © 2020 Grzegorz Gumieniak. All rights reserved.
//

import Foundation
import MapKit

// MARK: Initialization
class MKPointAnnotationFactory {
    var reports: [Report]
    
    init(from reports: [Report]) {
        self.reports = reports
    }
}
// MARK: Methods
extension MKPointAnnotationFactory {
    func createPointsToAnnotation() -> [MKPointAnnotation] {
        print(#function)
        print("Posiadam \(reports.count) zgloszen w sobie")
        print(reports)
        var annotations = [MKPointAnnotation]()
        for report in reports {
            let annotation = createPointAnnotation(from: report)
            annotations.append(annotation)
        }
        return annotations
    }
    private func createPointAnnotation(from report: Report) -> MKPointAnnotation {
        let annotation = MKPointAnnotation()
        annotation.coordinate = report.location
        annotation.title = report.user
        annotation.subtitle = report.description
        
        return annotation
    }
}
