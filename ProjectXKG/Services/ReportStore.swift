//
//  ReportStore.swift
//  ProjectXKG
//
//  Created by Grzegorz Gumieniak on 30/07/2020.
//  Copyright © 2020 Grzegorz Gumieniak. All rights reserved.
//

import Foundation
import FirebaseFirestore
import FirebaseAuth
import CoreLocation

class ReportStore {
    let db = Firestore.firestore()
    var location: GeoPoint?
    @Published private(set) var buttonOn: Bool = false
}

extension ReportStore {
    func sendReport() -> Bool {
        buttonOn = true
        guard let userMail = Auth.auth().currentUser?.email, location != nil, let location = self.location else {
            return false
        }
        db.collection("Test").addDocument(data: [
            K.Firestore.kategorie : "Test",
            "Lokalizacja" : location,
            "User" : userMail,
            "Date" : Date().timeIntervalSince1970
        ]) { err in
            if let error = err {
                print(error.localizedDescription)
            } else {
                print("Udalo sie wyslac")
                self.buttonOn = false
            }
        }
        return true
    }
    func getLocationBeforeSend(_ location: CLLocation) {
        self.location = location.convertCLLocationToGeoPoint()
    }
}

