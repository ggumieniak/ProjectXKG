//
//  MapViewModel.swift
//  ProjectXKG
//
//  Created by Grzegorz Gumieniak on 05/08/2020.
//  Copyright © 2020 Grzegorz Gumieniak. All rights reserved.
//

import Foundation
import MapKit
import FirebaseFirestore

// MARK: Initialization
class MapViewModel:ObservableObject {
    @Published var reportedLocations = [MKAnnotation]()
    @Published var showAlertView: Bool = false
    @Published var showMenuView: Bool = false
    private let db = Firestore.firestore()
    var location:CLLocation? {
        willSet {
            self.fetchData()
        }
    }
}
// MARK: Methods
extension MapViewModel {
    
    func test() {
        print("Test delegata")
    }
    
    
    func fetchData() {
        guard let location = location?.coordinate else {
            return
        }
        print(location)
//        print("Now we have that Timestamp: \(Timestamp.init())\nA 12 hour ago was: \(Timestamp(date: dayBefore))")
        let queryLocation = location.getNearBy(at: location, with: 10)
        self.db.collection(K.Firestore.Collection.categories).document(K.Firestore.Collection.Categories.localThreaten).collection(K.Firestore.Collection.Categories.Report.reports)
            .whereField(K.Firestore.Collection.Categories.Report.Fields.location, isLessThan: queryLocation.greaterGeoPoint)
            .whereField(K.Firestore.Collection.Categories.Report.Fields.location, isGreaterThan: queryLocation.lesserGeoPoint)
            .addSnapshotListener { documentShapshot, error in
                guard let document = documentShapshot?.documents else {
                    print("Error fetching document \(error!)")
                    return
                }
                print("Przechwytuje dane")
                let firebaseReports = document.map { QueryDocumentSnapshot -> Report in
                    // TODO: zwroc skonwertowane lokacje
                    let queryClassifier = FirebaseDataClassifier()
                    let classifiedReport = queryClassifier.classifierDataToReport(from: QueryDocumentSnapshot)
                    return classifiedReport
                }
                firebaseReports.printReports()
                self.reportedLocations = MKPointAnnotationFactory(from: firebaseReports).createPointsToAnnotation()
        }
        
    }
    
    func setReportedLocations(reportedLocations: [MKPointAnnotation]) {
        self.reportedLocations = reportedLocations
    }
    
    private func getTwelveHoursEarlierDate() -> Date?{
        return Calendar.current.date(byAdding: .hour, value: -12, to: Date())
    }
}


