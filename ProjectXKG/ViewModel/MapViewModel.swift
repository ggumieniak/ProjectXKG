//
//  MapViewModel.swift
//  ProjectXKG
//
//  Created by Grzegorz Gumieniak on 05/08/2020.
//  Copyright © 2020 Grzegorz Gumieniak. All rights reserved.
//

import Foundation

// MARK: Initialization
class MapViewModel:ObservableObject {
    let reportStore = ReportStore()
    let reportManager = ReportManager()
}
// MARK: Methods
extension MapViewModel {
    func fetchDataEvery5Minute() {
        reportManager.downloadDataEvery5Minutes()
    }
    func fetchData() {
        reportManager.downloadData()
    }
}
