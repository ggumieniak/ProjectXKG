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
    @Published var showMenuView: Bool = false {
        didSet {
            if oldValue == true {
                self.fetchData()
            }
        }
    }
    private var listenerLocal: ListenerRegistration?
    private var listenerRoad: ListenerRegistration?
    private var listenerWeather: ListenerRegistration?
    private let db = Firestore.firestore()
    var location:CLLocation?
    var timer = Timer()
    
}
// MARK: Methods
extension MapViewModel {
    
    private func removeListeners() {
        listenerLocal?.remove()
        listenerRoad?.remove()
        listenerWeather?.remove()
    }
    
    func scheduleTimer() {
        timer = Timer.scheduledTimer(timeInterval: 300, target: self, selector: #selector(fetchData), userInfo: nil, repeats: true)
    }
    
    @objc func fetchData() {
        guard let location = location?.coordinate else {
            return
        }
        removeListeners()
        print(#function)
        //        print("Now we have that Timestamp: \(Timestamp.init())\nA 12 hour ago was: \(Timestamp(date: dayBefore))")
        let queryLocation = location.getNearBy(at: location, with: UserDefaults.standard.double(forKey: K.UserDefaultKeys.distance) == 0 ? 10 : UserDefaults.standard.double(forKey: K.UserDefaultKeys.distance))
        print(UserDefaults.standard.double(forKey: K.UserDefaultKeys.distance))
        print(queryLocation)
        listenerLocal = db.collection(K.Firestore.Collection.categories).document(K.Firestore.Collection.Categories.localThreaten).collection(K.Firestore.Collection.Categories.Report.reports)
            .whereField(K.Firestore.Collection.Categories.Report.Fields.location, isLessThan: queryLocation.greaterGeoPoint)
            .whereField(K.Firestore.Collection.Categories.Report.Fields.location, isGreaterThan: queryLocation.lesserGeoPoint)
            .addSnapshotListener { documentShapshot, error in
                guard let document = documentShapshot?.documents else {
                    print("Error fetching document \(error!)")
                    return
                }
                let firebaseReports = document.map { QueryDocumentSnapshot -> Report in
                    let queryClassifier = FirebaseDataClassifier()
                    let classifiedReport = queryClassifier.classifierDataToReport(from: QueryDocumentSnapshot)
                    return classifiedReport
                }
                if SharedReports.shared.localReports != firebaseReports {
                    SharedReports.shared.localReports = firebaseReports
                }
                
            }
        if UserDefaults.standard.bool(forKey: K.Firestore.Collection.Categories.roadAccident) == true {
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
                    SharedReports.shared.roadAccident = firebaseReports
                }
        }
        if UserDefaults.standard.bool(forKey: K.Firestore.Collection.Categories.weather) == true {
            self.db.collection(K.Firestore.Collection.categories).document(K.Firestore.Collection.Categories.weather).collection(K.Firestore.Collection.Categories.Report.reports)
                .whereField(K.Firestore.Collection.Categories.Report.Fields.location, isLessThan: queryLocation.greaterGeoPoint)
                .whereField(K.Firestore.Collection.Categories.Report.Fields.location, isGreaterThan: queryLocation.lesserGeoPoint)
                .addSnapshotListener { documentShapshot, error in
                    guard let document = documentShapshot?.documents else {
                        print("Error fetching document \(error!)")
                        return
                    }
                    let firebaseReports = document.map { QueryDocumentSnapshot -> Report in
                        let queryClassifier = FirebaseDataClassifier()
                        let classifiedReport = queryClassifier.classifierDataToReport(from: QueryDocumentSnapshot)
                        return classifiedReport
                    }
                    SharedReports.shared.weather = firebaseReports
                }
        }
    }
    
    private func getTwelveHoursEarlierDate() -> Date?{
        return Calendar.current.date(byAdding: .hour, value: -12, to: Date())
    }
    
    
}


