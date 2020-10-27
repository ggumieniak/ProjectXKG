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
    func classifierDataToReport(from dataFromFirebase:QueryDocumentSnapshot) -> Report {
        let data = convertDateToString(dataFromFirebase[K.Firestore.Collection.Categories.Report.Fields.date]!)
        let description = convertDescriptionToString(dataFromFirebase[K.Firestore.Collection.Categories.Report.Fields.description]!)
        let location = convertGeopointToLocation(dataFromFirebase[K.Firestore.Collection.Categories.Report.Fields.location]!)
        let user = convertUserToString(dataFromFirebase[K.Firestore.Collection.Categories.Report.Fields.user]!)
        
        let report = makeReport(from: data,description,location,user)
        return report
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
    
    private func makeReport(from date: String,_ description: String, _ location:CLLocationCoordinate2D,_ user: String) -> Report {
        return Report(date: date, description: description, location: location, user: user)
    }
}
