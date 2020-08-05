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

class ReportStore: ObservableObject {
    private let db = Firestore.firestore()
    var location: GeoPoint?
    var description: String?
}


// MARK: Send Data
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
            "Date" : Timestamp.init()
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

// MARK: Acquire Data
extension ReportStore {
    func fetchData() {
        db.collection("Test").addSnapshotListener { documentShapshot, error in
            guard let document = documentShapshot?.documents else {
                print("Error fetching document \(error!)")
                return
            }
            for item in document {
                //
                //
                let foo /* test */ = item.data()
                //                print(foo["Location"])
                let loc = foo["Location"]
                let point = loc as? GeoPoint
                if let latitude = point?.latitude, let longtitude = point?.longitude {
                    let location = CLLocation(latitude: latitude, longitude: longtitude)
                    print(location.coordinate)
                }
                //                let lat = loc
            }
        }
    }
}
