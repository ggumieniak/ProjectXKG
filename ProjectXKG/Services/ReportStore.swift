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
import Combine

class ReportStore {
    let db = Firestore.firestore()
    var location: GeoPoint?
    var description: String?
}

extension ReportStore {
    func sendReport() -> Bool {
        guard let userMail = Auth.auth().currentUser?.email, location != nil, let location = self.location, let description = description else {
            return false
        }
        db.collection("Test").addDocument(data: [
            K.Firestore.kategorie : "Test",
            "Location" : location,
            "Description" : description,
            "User" : userMail,
            "Date" : Date().timeIntervalSince1970
        ]) { err in
            if let error = err {
                print(error.localizedDescription)
            } else {
                print("Successfully sended report")
            }
        }
        return true
    }
    func getLocationBeforeSend(_ location: CLLocation) {
        self.location = location.convertCLLocationToGeoPoint()
    }
    func getDescriptionBeforeSend(_ description: String) {
        self.description = description
    }
}

