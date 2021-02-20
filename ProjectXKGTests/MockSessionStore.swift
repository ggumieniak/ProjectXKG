//
//  MockSessionStore.swift
//  ProjectXKGTests
//
//  Created by Grzegorz Gumieniak on 19/02/2021.
//  Copyright © 2021 Grzegorz Gumieniak. All rights reserved.
//

import Foundation
@testable import ProjectXKG


final class MockSessionStore: SessionStoreProtocol {
    var signInResult: Result<Void,Error> = .success(())
    var signUpResult: Result<Void,Error> = .success(())
    
    func signIn(email: String, password: String, handler: @escaping (Result<Void, Error>) -> Void) {
        handler(signInResult)
    }
    
    func signUp(email: String, password: String, handler: @escaping (Result<Void, Error>) -> Void) {
        handler(signUpResult)
    }
}
