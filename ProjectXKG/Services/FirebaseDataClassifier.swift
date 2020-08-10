//
//  FirebaseDataClassifier.swift
//  ProjectXKG
//
//  Created by Grzegorz Gumieniak on 07/08/2020.
//  Copyright © 2020 Grzegorz Gumieniak. All rights reserved.
//

import Foundation
import FirebaseFirestore


// MARK: Initialization
class FirebaseDataClassifier {
    let dataFromFirebase: [QueryDocumentSnapshot]
    private var reports: [Report]?
    
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
                let data = convertDateToString(report[K.Firestore.Categories.Fields.date]!)
                print(data.description)
            }
            if let item = dataFromFirebase.last?.data() {
                // TODO: Make class that will convert date do model
                if let date = item[K.Firestore.Categories.Fields.date] {
                    guard let dateTimeStamp = date as? Timestamp else {
                        return
                    }
                    print("Ostatnia wiadomosc zostala wyslana o \(convertTimeStampToString(dateTimeStamp))")
                }
            }
        }
    }
    private func convertTimeStampToString(_ dateTimeStamp: Timestamp) -> String  {
        print(#function)
        guard let timezone = Calendar.current.timeZone.abbreviation() else {
            return "Error"
        }
        let dateFormatter = DateFormatter()
        dateFormatter.timeZone = TimeZone(abbreviation: timezone)
        dateFormatter.dateFormat = "EEEE, MM-dd-yyyy HH:mm"
        let wypisz = dateFormatter.string(from: dateTimeStamp.dateValue())
        return wypisz
    }
    private func convertDateToString(_ date: Any) -> String {
        let dateTimeStamp = date as! Timestamp
        let dateFormatter = DateFormatter()
        dateFormatter.timeZone = TimeZone(abbreviation: Calendar.current.timeZone.abbreviation()!)
        dateFormatter.dateFormat = "EEEE, MM-dd-yyyy HH:mm"
        let dateString = dateFormatter.string(from: dateTimeStamp.dateValue())
        return dateString
    }
}
// MARK: Acquire Data
extension FirebaseDataClassifier {
    func getDataToShow() -> [Report] {
        // TODO: Return
        return [Report]()
    }
}
