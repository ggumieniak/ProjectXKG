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

class ReportStore {
    let db = Firestore.firestore()
    func sendReport() -> Bool {
        guard let userMail = Auth.auth().currentUser?.email else {
            return false
        }
        var ref: DocumentReference? = nil
        ref = db.collection("Test").addDocument(data: [
            K.Firestore.kategorie : "Test",
            "Lokalizacja" : [
                Location(latitude: 21, longitude: 37).latitude,
                Location(latitude: 21, longitude: 37).longitude
                ],
            "User" : userMail,
            "Date" : Date().timeIntervalSince1970
        ]) { err in
            if let error = err {
                print(err?.localizedDescription)
            } else {
                print("Udalo sie wyslac")
            }
        }
        return true
    }
}
