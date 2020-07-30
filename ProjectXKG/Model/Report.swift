//
//  Report.swift
//  ProjectXKG
//
//  Created by Grzegorz Gumieniak on 30/07/2020.
//  Copyright © 2020 Grzegorz Gumieniak. All rights reserved.
//

import Foundation

protocol Report {
    var location: Location {get set}
    var description: String {get set}
    var user: User {get set}
}
