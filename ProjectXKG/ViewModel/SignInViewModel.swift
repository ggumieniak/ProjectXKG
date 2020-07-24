//
//  SignInViewModel.swift
//  ProjectXKG
//
//  Created by Grzegorz Gumieniak on 24/07/2020.
//  Copyright © 2020 Grzegorz Gumieniak. All rights reserved.
//

import Foundation
import Combine

class SignInViewModel: ObservableObject {
    @Published var email: String = ""
    @Published var password: String = ""
    @Published var error: String = ""
}
