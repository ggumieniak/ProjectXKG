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
class SignInViewModel: ObservableObject {
    @Published var email: String = ""
    @Published var password: String = ""
    @Published var error: String = ""
    var sended: Bool = false
    
    private var session: SessionStoreProtocol
    
    init(session: SessionStoreProtocol = SessionStore()) {
        self.session = session
    }
    
    func signIn() {
        session.signIn(email: email, password: password) { result in
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
