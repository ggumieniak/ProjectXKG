//
//  Array+Report.swift
//  ProjectXKG
//
//  Created by Grzegorz Gumieniak on 09/10/2020.
//  Copyright © 2020 Grzegorz Gumieniak. All rights reserved.
//

import Foundation

extension Array where Element == Report {
    func printReports() {
        for report in self {
            let rawString = """
            Accident date: \(report.date)
            Localization: \(report.location)
            Description: \(report.description)
            User: \(report.user)
            ________________________________________________
            """
            print(rawString)
        }
        
    }
}
