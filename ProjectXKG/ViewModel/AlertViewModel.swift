//
//  AlertViewModel.swift
//  ProjectXKG
//
//  Created by Grzegorz Gumieniak on 29/07/2020.
//  Copyright © 2020 Grzegorz Gumieniak. All rights reserved.
//

import Foundation

class AlertViewModel: ObservableObject {
    @Published var description: String = ""
    @Published var disabledButton: Bool = false
}
