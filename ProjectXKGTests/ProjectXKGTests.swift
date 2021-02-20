//
//  ProjectXKGTests.swift
//  ProjectXKGTests
//
//  Created by Grzegorz Gumieniak on 27/06/2020.
//  Copyright © 2020 Grzegorz Gumieniak. All rights reserved.
//

import XCTest
@testable import ProjectXKG

class ProjectXKGTests: XCTestCase {

    var signInViewModel: SignInViewModel!
    var signUpViewModel: SignUpViewModel!
    var mockSessionStore: MockSessionStore!
    
    override func setUp() {
        mockSessionStore = MockSessionStore()
        signInViewModel = .init(session: mockSessionStore)
        signUpViewModel = .init(session: mockSessionStore)
    }
        
    func testSignInWithCorrectDetails() {
        mockSessionStore.signInResult = .success(())
        signInViewModel.signIn()
        
        XCTAssertTrue(signInViewModel.sended)
        
    }
    
    func testSignInWithErrorDetails() {
        mockSessionStore.signInResult = .failure(NSError(domain: "", code: -1, userInfo: nil))
        signInViewModel.signIn()
        
        XCTAssertFalse(signInViewModel.sended)
        
    }
    func testSignUpWithCorrectDetails() {
        mockSessionStore.signUpResult = .success(())
        signUpViewModel.signUp()
        
        XCTAssertTrue(signUpViewModel.sended)
        
    }
    
    func testSignUpWithErrorDetails() {
        mockSessionStore.signUpResult = .failure(NSError(domain: "", code: -1, userInfo: nil))
        signUpViewModel.signUp()
        
        XCTAssertFalse(signInViewModel.sended)
        
    }

}
