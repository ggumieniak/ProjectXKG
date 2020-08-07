//
//  FirebaseDataClassifier.swift
//  ProjectXKG
//
//  Created by Grzegorz Gumieniak on 07/08/2020.
//  Copyright © 2020 Grzegorz Gumieniak. All rights reserved.
//

import Foundation
import FirebaseFirestore

class FirebaseDataClassifier {
    init(from dataFromFirebase:[QueryDocumentSnapshot]) {
        self.dataFromFirebase = dataFromFirebase
    }
    let dataFromFirebase: [QueryDocumentSnapshot]
}
// MARK: Modelling data
extension FirebaseDataClassifier {
    func getDataToClassifier() {
        if let item = dataFromFirebase.last?.data() {
            // TODO: Make class that will convert date do model
            if let date = item["Date"] {
                guard let dateTimeStamp = date as? Timestamp else {
                    return
                }
                guard let timezone = Calendar.current.timeZone.abbreviation() else {
                    return
                }
                print(timezone)
                let dateFormatter = DateFormatter()
                dateFormatter.timeZone = TimeZone(abbreviation: timezone)
                dateFormatter.dateFormat = "EEEE, MM-dd-yyyy HH:mm"
                let wypisz = dateFormatter.string(from: dateTimeStamp.dateValue())
                print(wypisz)
                print("koniec pobiernaia danych")
            }
        }
    }
}
// MARK: Acquire Data
extension FirebaseDataClassifier {
    func getDataToShow() -> [Report] {
        // TODO: Return
        return [Report]()
    }
}
