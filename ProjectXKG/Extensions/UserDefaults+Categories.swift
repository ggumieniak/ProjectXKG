//
//  UserDefaults+Categories.swift
//  ProjectXKG
//
//  Created by Grzegorz Gumieniak on 10/11/2020.
//  Copyright © 2020 Grzegorz Gumieniak. All rights reserved.
//

import Foundation

extension UserDefaults {
    static var localActivated: Bool {
        get {
            return UserDefaults.standard.bool(forKey: K.Firestore.Collection.Categories.localThreaten)
        }
        set {
            UserDefaults.standard.setValue(newValue, forKey: K.Firestore.Collection.Categories.localThreaten)
        }
    }
    static var roadActivated: Bool {
        get {
            return UserDefaults.standard.bool(forKey: K.Firestore.Collection.Categories.roadAccident)
        }
        set {
            UserDefaults.standard.setValue(newValue, forKey: K.Firestore.Collection.Categories.roadAccident)
        }
    }
    static var weatherActivated: Bool {
        get {
            return UserDefaults.standard.bool(forKey: K.Firestore.Collection.Categories.weather)
        }
        set {
            UserDefaults.standard.setValue(newValue, forKey: K.Firestore.Collection.Categories.weather)
        }
    }
}
