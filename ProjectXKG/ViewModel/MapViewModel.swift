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
    static let shared = MapViewModel()
    let reportManager = ReportManager()
    @Published var locations = [MKAnnotation]()
    @Published var isModel: Bool = false
}
// MARK: Methods
extension MapViewModel {
    func fetchData(currentLocation locations:CLLocationCoordinate2D?) {
        guard let location = locations else  {
            return
        }
        reportManager.downloadData(at: location)
        self.locations = reportManager.getAnnotation()
        print("Skonczylem juz w \(#function)")
//        locations = reportManager.getReportAnnotations()
//        locations.append(MKPointAnnotation.example) // add to locations that we could oing to show at map automatically
    }
    func getLocations(locations: [MKPointAnnotation]) {
        self.locations = locations
    }
}


