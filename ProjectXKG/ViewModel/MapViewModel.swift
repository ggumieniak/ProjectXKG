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
    @Published var showAlertView: Bool = false
    @Published var showMenuView: Bool = false
}
// MARK: Methods
extension MapViewModel {
    func fetchData(currentLocation locations:CLLocationCoordinate2D?) {
        guard let location = locations else  {
            return
        }
        
        print("Pobieram dane")
        
        reportManager.downloadData(at: location)
        self.locations = reportManager.getAnnotation()
        print("Skonczylem juz w \(#function)")
    }
    func getLocations(locations: [MKPointAnnotation]) {
        self.locations = locations
    }
}


