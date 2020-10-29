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
    private var fetchedLocalThreaten = [MKAnnotation]()
    private var fetchedRoadAccident = [MKAnnotation]()
    @Published var reportedLocations = [MKAnnotation]()
    @Published var showAlertView: Bool = false
    @Published var showMenuView: Bool = false {
        didSet {
            if oldValue == true {
                self.fetchData()
            }
        }
    }
    private let db = Firestore.firestore()
    var location:CLLocation?
    var timer = Timer()
    
}
// MARK: Methods
extension MapViewModel {
    
    func scheduleTimer() {
        timer = Timer.scheduledTimer(timeInterval: 60, target: self, selector: #selector(fetchData), userInfo: nil, repeats: true)
    }
    
    @objc func fetchData() {
        guard let location = location?.coordinate else {
            return
        }
        print(location)
        //        print("Now we have that Timestamp: \(Timestamp.init())\nA 12 hour ago was: \(Timestamp(date: dayBefore))")
        let queryLocation = location.getNearBy(at: location, with: UserDefaults.standard.double(forKey: "odleglosc") == 0 ? 10 : UserDefaults.standard.double(forKey: "odleglosc"))
        print(UserDefaults.standard.double(forKey: "odleglosc"))
        print(queryLocation)
        if UserDefaults.standard.bool(forKey: K.Firestore.Collection.Categories.localThreaten) == false {
            self.db.collection(K.Firestore.Collection.categories).document(K.Firestore.Collection.Categories.localThreaten).collection(K.Firestore.Collection.Categories.Report.reports)
                .whereField(K.Firestore.Collection.Categories.Report.Fields.location, isLessThan: queryLocation.greaterGeoPoint)
                .whereField(K.Firestore.Collection.Categories.Report.Fields.location, isGreaterThan: queryLocation.lesserGeoPoint)
                .addSnapshotListener { documentShapshot, error in
                    guard let document = documentShapshot?.documents else {
                        print("Error fetching document \(error!)")
                        return
                    }
                    let firebaseReports = document.map { QueryDocumentSnapshot -> Report in
                        // TODO: zwroc skonwertowane lokacje
                        let queryClassifier = FirebaseDataClassifier()
                        let classifiedReport = queryClassifier.classifierDataToReport(from: QueryDocumentSnapshot)
                        return classifiedReport
                    }
                    //                firebaseReports.printReports()
                    self.fetchedLocalThreaten = MKPointAnnotationFactory(from: firebaseReports).createPointsToAnnotation()
                    self.reportedLocations = self.fetchedLocalThreaten
                }
            
        }
        if UserDefaults.standard.bool(forKey: K.Firestore.Collection.Categories.roadAccident) == false {
            self.db.collection(K.Firestore.Collection.categories).document(K.Firestore.Collection.Categories.roadAccident).collection(K.Firestore.Collection.Categories.Report.reports)
                .whereField(K.Firestore.Collection.Categories.Report.Fields.location, isLessThan: queryLocation.greaterGeoPoint)
                .whereField(K.Firestore.Collection.Categories.Report.Fields.location, isGreaterThan: queryLocation.lesserGeoPoint)
                .addSnapshotListener { documentShapshot, error in
                    guard let document = documentShapshot?.documents else {
                        print("Error fetching document \(error!)")
                        return
                    }
                    let firebaseReports = document.map { QueryDocumentSnapshot -> Report in
                        // TODO: zwroc skonwertowane lokacje
                        let queryClassifier = FirebaseDataClassifier()
                        let classifiedReport = queryClassifier.classifierDataToReport(from: QueryDocumentSnapshot)
                        return classifiedReport
                    }
                    //                firebaseReports.printReports()
                    self.fetchedRoadAccident = MKPointAnnotationFactory(from: firebaseReports).createPointsToAnnotation()
//                    self.reportedLocations = self.fetchedRoadAccident
                }
            
        }
    }
    
    private func getTwelveHoursEarlierDate() -> Date?{
        return Calendar.current.date(byAdding: .hour, value: -12, to: Date())
    }
    
    
}


