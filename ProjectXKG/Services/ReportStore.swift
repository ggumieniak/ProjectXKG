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
    func sendReport(location: GeoPoint, description: String) -> Bool {
        guard let userMail = Auth.auth().currentUser?.email else {
            return false
        }
//        print("Timestamp from firestore: \(Timestamp.init())")
        db.collection("Test").addDocument(data: [
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
        guard let dayBefore = createAndSendToConsoleDate() else {
            return
        }
        print("Now we have that Timestamp: \(Timestamp.init())\nA 12 hour ago was: \(Timestamp(date: dayBefore))")
        db.collection("Test")
        .whereField("Date", isGreaterThan: dayBefore)
            .order(by: "Date", descending: false)
            .addSnapshotListener { documentShapshot, error in
            guard let document = documentShapshot?.documents else {
                print("Error fetching document \(error!)")
                return
            }
                print("In array i have: \(document.count) data")
            if let item = document.last?.data() {
                if let description = item["Description"] {
                    print("Last item description: \(description)")
                }
            }
        }
    }
}
// MARK: Create Date
extension ReportStore {
    private func createAndSendToConsoleDate() -> Date?{
        return Calendar.current.date(byAdding: .hour, value: -12, to: Date())
    }
}
