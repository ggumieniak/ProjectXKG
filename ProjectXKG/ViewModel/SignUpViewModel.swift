//
//  SignInViewModel.swift
//  ProjectXKG
//
//  Created by Grzegorz Gumieniak on 24/07/2020.
//  Copyright © 2020 Grzegorz Gumieniak. All rights reserved.
//

import Foundation
import Combine

// MARK: Initialization
class SignUpViewModel: ObservableObject {
    @Published var email: String = ""
    @Published var password: String = ""
    @Published var error: String = ""
    
    private var session: SessionStoreProtocol
    var sended: Bool = false
    
    init(session: SessionStoreProtocol = SessionStore()) {
        self.session = session
    }
    
    func signUp() {
        session.signUp(email: email, password: password) { result in
            switch result {
                case .success:
                    self.email = ""
                    self.password = ""
                    self.error = ""
                    self.sended = true
            case let .failure(error):
                self.error = error.localizedDescription
                self.sended = false
            }
        }
    }
}
