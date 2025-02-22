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

enum FirebaseDataClassifierError {
    case NotExistingDataFromServer(line: Int = #line)
}

// MARK: Initialization
class FirebaseDataClassifier {
    func classifierDataToReport(from dataFromFirebase:QueryDocumentSnapshot) -> Report  {
        let id = dataFromFirebase.documentID
        let data = convertDateToString(dataFromFirebase[K.Firestore.Collection.Categories.Report.Fields.date]!)
        let description = convertDescriptionToString(dataFromFirebase[K.Firestore.Collection.Categories.Report.Fields.description]!)
        let location = convertGeopointToLocation(dataFromFirebase[K.Firestore.Collection.Categories.Report.Fields.location]!)
        let title = convertTitleToString(dataFromFirebase[K.Firestore.Collection.Categories.Report.Fields.title]!)
        let report = makeReport(from: id,data,description,location,title)
        return report
    }
    
    private func makeUUID(_ uuidString: Any) -> UUID {
        let uuid = UUID(uuidString: uuidString as! String)
        return uuid!
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
    
    private func convertTitleToString(_ title: Any) -> String {
        let titleString = title as! String
        return titleString
    }
    
    private func makeReport(from id: String, _ date: String,_ description: String, _ location:CLLocationCoordinate2D,_ title: String) -> Report {
        return Report(id: id,date: date, description: description, location: location, title: title)
    }
}
