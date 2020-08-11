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
import MapKit

class ReportStore: ObservableObject {
    private let db = Firestore.firestore()
    @Published var annotations = [MKPointAnnotation]() {
        didSet {
            print("Zmienilem sie na lepsze!")
        }
    }
}


// MARK: Send Data
extension ReportStore {
    // TODO: Check which collection you want send a message
    func sendReport(location: GeoPoint, description: String/*, collection: String */) -> Bool {
        guard let userMail = Auth.auth().currentUser?.email else {
            return false
        }
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
}

// MARK: Acquire Data
extension ReportStore {
    // TODO: To delete after make service
    func fetchData(acquireData: @escaping ([QueryDocumentSnapshot]) -> [MKPointAnnotation]) {
        guard let dayBefore = getTwelveHoursEarlierDate() else {
            return
        }
        print("Now we have that Timestamp: \(Timestamp.init())\nA 12 hour ago was: \(Timestamp(date: dayBefore))")
        self.db.collection("Test")
            .whereField("Date", isGreaterThan: dayBefore)
            .order(by: "Date", descending: false)
            .addSnapshotListener { documentShapshot, error in
                guard let document = documentShapshot?.documents else {
                    print("Error fetching document \(error!)")
                    return
                }
                
                self.annotations = acquireData(document)
                print("Adnotacje \(self.annotations.count)")
                // TODO: Przeslij do widoku
                DispatchQueue.main.async {
                    MapViewModel.shared.locations = self.annotations
                    print("\(#function) liczba lokalizacji w shared mapviewmodel = \(MapViewModel.shared.locations.count)")
                }
        }
    }
}
// MARK: Create Date
extension ReportStore {
    private func getTwelveHoursEarlierDate() -> Date?{
        return Calendar.current.date(byAdding: .hour, value: -12, to: Date())
    }
}
