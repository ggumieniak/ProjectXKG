//
//  SessionStore.swift
//  ProjectXKG
//
//  Created by Grzegorz Gumieniak on 17/07/2020.
//  Copyright © 2020 Grzegorz Gumieniak. All rights reserved.
//

import SwiftUI
import FirebaseAuth
import Combine

protocol SessionStoreProtocol {
    func signUp(email: String, password: String, handler: @escaping (Result<Void,Error>) -> Void)
    func signIn(email: String, password: String, handler: @escaping (Result<Void,Error>) -> Void)
}

class SessionStore: ObservableObject, SessionStoreProtocol {
    var didChange = PassthroughSubject<SessionStore, Never>()
    var handle: AuthStateDidChangeListenerHandle?
    @Published var session: User? {
        didSet {
            self.didChange.send(self)
        }
    }
    
    deinit {
        unbind()
    }
    
    func listen() {
        handle = Auth.auth().addStateDidChangeListener({ (auth,user) in
            if let user = user {
                self.session = User(uid: user.uid, email: user.email)
            }
        })
    }
    
    func signUp(email: String, password: String, handler: @escaping (Result<Void,Error>) -> Void) {
        Auth.auth().createUser(withEmail: email, password: password) { result, error in
            if let error = error {
                handler(.failure(error))
            } else {
                handler(.success(()))
            }
        }
    }
    
    func signIn(email: String, password: String, handler: @escaping (Result<Void,Error>) -> Void) {
        Auth.auth().signIn(withEmail: email, password: password) { result, error in
            if let error = error {
                handler(.failure(error))
            } else {
                handler(.success(()))
            }
        }
    }
    
    func signOut() {
        do {
            try Auth.auth().signOut()
            self.session = nil
        } catch {
            print("Error when signOut \(error)")
        }
    }
    
    func unbind() {
        if let handle = handle {
            Auth.auth().removeStateDidChangeListener(handle)
        }
    }
}
