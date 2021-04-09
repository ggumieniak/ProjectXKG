//
//  AlertViewModel.swift
//  ProjectXKG
//
//  Created by Grzegorz Gumieniak on 29/07/2020.
//  Copyright © 2020 Grzegorz Gumieniak. All rights reserved.
//

import Foundation
import FirebaseFirestore
import FirebaseAuth

// MARK: Initialization
class AlertViewModel: ObservableObject {
    private let db = Firestore.firestore()
    var disabledButton: Bool {
        return category == "" ? true : description.count < K.AlertView.minimumLengthOfDescription ? true : false
    }
    @Published var title: String = ""
    @Published var category: String = ""
    @Published var description: String = ""
    
    func sendReport(location: GeoPoint, title: String, category: String, description: String) -> Bool {
        guard let _ = Auth.auth().currentUser?.email else {
            return false
        }
        db.collection(K.Firestore.Collection.categories).document(category).collection(K.Firestore.Collection.Categories.Report.reports)
            .addDocument(data: [
                K.Firestore.Collection.Categories.Report.Fields.location : location,
                K.Firestore.Collection.Categories.Report.Fields.title : title,
                K.Firestore.Collection.Categories.Report.Fields.description : description,
                K.Firestore.Collection.Categories.Report.Fields.date : Timestamp.init()
            ]) { err in
                if let error = err {
                    print(error.localizedDescription)
                } else {
                    MapViewModel.sendedMessage = true
                    print("Successfully sended report")
                }
            }
        return true
    }
}
