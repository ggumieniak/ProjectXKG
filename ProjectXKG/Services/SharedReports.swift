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
    
    var localThreaten = [MKAnnotation]()
    var roadAccident = [MKAnnotation]()
    var weather = [MKAnnotation]()
}
