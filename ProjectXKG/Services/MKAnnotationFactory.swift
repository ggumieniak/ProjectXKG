//
//  MKAnnotationFactory.swift
//  ProjectXKG
//
//  Created by Grzegorz Gumieniak on 11/08/2020.
//  Copyright © 2020 Grzegorz Gumieniak. All rights reserved.
//

import Foundation

// MARK: Initialization
class MKAnnotationFactory {
    var reports: [Report] = [Report]()
    
    init(from reports: [Report]) {
        self.reports = reports
    }
}
