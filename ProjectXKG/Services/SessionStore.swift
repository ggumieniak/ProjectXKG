//
//  SessionStore.swift
//  ProjectXKG
//
//  Created by Grzegorz Gumieniak on 17/07/2020.
//  Copyright © 2020 Grzegorz Gumieniak. All rights reserved.
//

import SwiftUI
import Firebase
import Combine

class SessionStore: ObservableObject {
    var didChange = PassthroughSubject<SessionStore, Never>()
    var handle: AuthStateDidChangeListenerHandle?
    @Published var session: User? {
        didSet {self.didChange.send(self)}
    }
    
    deinit {
        unbing()
    }
    
    func listen() {
        handle = Auth.auth().addStateDidChangeListener({ (auth,user) in
            if let user = user {
                self.session = User(uid: user.uid, email: user.email)
            }
        })
    }
    
    func signUp(email: String, password: String, handler: @escaping AuthDataResultCallback) {
        Auth.auth().createUser(withEmail: email, password: password, completion: handler)
    }
    
    func signIn(email: String, password: String, handler: @escaping AuthDataResultCallback) {
        Auth.auth().signIn(withEmail: email, password: password, completion: handler)
    }
    
    func signOut() {
        do {
            try Auth.auth().signOut()
            self.session = nil
        } catch {
            print("Error when signOut \(error.localizedDescription)")
        }
    }
    
    func unbing() {
        if let handle = handle {
            Auth.auth().removeStateDidChangeListener(handle)
        }
    }
    
}
