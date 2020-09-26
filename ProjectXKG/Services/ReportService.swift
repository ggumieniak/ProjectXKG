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

class ReportService: ObservableObject {
    private let db = Firestore.firestore()
    @Published var annotations = [MKAnnotation]()
}


// MARK: Send Data
extension ReportService {
    // TODO: Make a category specified report
    func sendReport(location: GeoPoint, description: String, category: String) -> Bool {
        guard let userMail = Auth.auth().currentUser?.email else {
            return false
        }
        db.collection(K.Firestore.Collection.categories).document(category).collection(K.Firestore.Collection.Categories.Report.reports)
            .addDocument(data: [
                K.Firestore.Collection.Categories.Report.Fields.location : location,
            K.Firestore.Collection.Categories.Report.Fields.description : description,
            K.Firestore.Collection.Categories.Report.Fields.user : userMail,
            K.Firestore.Collection.Categories.Report.Fields.date : Timestamp.init()
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
extension ReportService {
    // TODO: To delete after make service
    func fetchData(at location:CLLocationCoordinate2D,with accuracy: Double,acquireData: @escaping ([QueryDocumentSnapshot]) -> [MKPointAnnotation]) /* -> [MKPointAnnotation] */ {
        guard let dayBefore = getTwelveHoursEarlierDate() else {
            return // if cant get time dont downlad any date
        }
        print("Now we have that Timestamp: \(Timestamp.init())\nA 12 hour ago was: \(Timestamp(date: dayBefore))")
        let queryLocation = location.getNearBy(at: location, with: accuracy)
        self.db.collection(K.Firestore.Collection.categories).document(K.Firestore.Collection.Categories.localThreaten).collection(K.Firestore.Collection.Categories.Report.reports)
            .whereField(K.Firestore.Collection.Categories.Report.Fields.location, isLessThan: queryLocation.greaterGeoPoint)
            .whereField(K.Firestore.Collection.Categories.Report.Fields.location, isGreaterThan: queryLocation.lesserGeoPoint)
            //TODO: Make cron-job to delete reports older then 1 day
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
extension ReportService {
    private func getTwelveHoursEarlierDate() -> Date?{
        return Calendar.current.date(byAdding: .hour, value: -12, to: Date())
    }
}
