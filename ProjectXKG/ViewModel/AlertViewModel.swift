//
//  AlertViewModel.swift
//  ProjectXKG
//
//  Created by Grzegorz Gumieniak on 29/07/2020.
//  Copyright © 2020 Grzegorz Gumieniak. All rights reserved.
//

import Foundation

// MARK: Initialization
class AlertViewModel: ObservableObject {
    @Published var description: String = ""
    var tempDescription: String?
    @Published var disabledButton: Bool = false
    @Published var category: String = ""
}
