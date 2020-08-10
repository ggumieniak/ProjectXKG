//
//  FirebaseDataClassifier.swift
//  ProjectXKG
//
//  Created by Grzegorz Gumieniak on 07/08/2020.
//  Copyright © 2020 Grzegorz Gumieniak. All rights reserved.
//

import Foundation
import FirebaseFirestore
import MapKit


// MARK: Initialization
class FirebaseDataClassifier {
    let dataFromFirebase: [QueryDocumentSnapshot]
    private var reports = [ReportDate]()
    
    init(from dataFromFirebase:[QueryDocumentSnapshot]) {
        self.dataFromFirebase = dataFromFirebase
        getDataToClassifier()
    }
}
// MARK: Modelling data
extension FirebaseDataClassifier {
    func getDataToClassifier() {
        if dataFromFirebase.count != 0 {
            for report in dataFromFirebase {
                print(#function)
                let data = convertDateToString(report[K.Firestore.Categories.Fields.date]!)
                let description = convertDescriptionToString(report[K.Firestore.Categories.Fields.description]!)
                let location = convertGeopointToLocation(report[K.Firestore.Categories.Fields.location]!)
                let user = convertUserToString(report[K.Firestore.Categories.Fields.user]!)
                
                let annotation = makeReport(from: data,description,location,user)
                reports.append(annotation)
//                let rawString = """
//                Accident date: \(data)
//                Localization: \(location)
//                Description: \(description)
//                User: \(user)
//                ________________________________________________
//                """
//                print(rawString)
            }
        }
    }
    
    private func convertDateToString(_ date: Any) -> String {
        let dateTimeStamp = date as! Timestamp
        let dateFormatter = DateFormatter()
        dateFormatter.timeZone = TimeZone(abbreviation: Calendar.current.timeZone.abbreviation()!)
        dateFormatter.dateFormat = "EEEE, MM-dd-yyyy HH:mm"
        let dateString = dateFormatter.string(from: dateTimeStamp.dateValue())
        return dateString
    }
    
    private func convertDescriptionToString(_ description: Any) -> String {
        return description as! String
    }
    
    private func convertGeopointToLocation(_ geoPoint: Any) -> CLLocationCoordinate2D {
        let location = geoPoint as! GeoPoint
        let locationCLLocationCoordinate2D = CLLocationCoordinate2D(latitude: location.latitude, longitude: location.longitude)
        return locationCLLocationCoordinate2D
    }
    
    private func convertUserToString(_ user: Any) -> String {
        let userString = user as! String
        return userString
    }
    
    private func makeReport(from date: String,_ description: String, _ location:CLLocationCoordinate2D,_ user: String) -> ReportDate {
        return ReportDate(date: date, description: description, location: location, user: user)
    }
}
// MARK: Acquire Data
extension FirebaseDataClassifier {
    func getDataToShow() -> [Report] {
        return reports
    }
}
