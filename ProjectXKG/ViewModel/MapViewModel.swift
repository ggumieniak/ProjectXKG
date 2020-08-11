//
//  MapViewModel.swift
//  ProjectXKG
//
//  Created by Grzegorz Gumieniak on 05/08/2020.
//  Copyright © 2020 Grzegorz Gumieniak. All rights reserved.
//

import Foundation
import MapKit

// MARK: Initialization
class MapViewModel:ObservableObject {
    let reportManager = ReportManager()
    @Published var locations = [MKPointAnnotation]()
    @Published var isModel: Bool = false
}
// MARK: Methods
extension MapViewModel {
    func fetchDataEvery5Minute() {
        reportManager.downloadDataEvery5Minutes()
    }
    func fetchData() {
        reportManager.downloadData()
        self.locations = reportManager.getAnnotation()
        print("Skonczylem juz w \(#function)")
//        locations = reportManager.getReportAnnotations()
//        locations.append(MKPointAnnotation.example) // add to locations that we could oing to show at map automatically
    }
    func getLocations(locations: [MKPointAnnotation]) {
        self.locations = locations
    }
}
