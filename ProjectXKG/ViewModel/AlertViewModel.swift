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
    @Published var description: String = ""
    var tempDescription: String?
    @Published var disabledButton: Bool = false
    @Published var category: String = ""
    
    func sendReport(location: GeoPoint, description: String, category: String) -> Bool {
        guard let userMail = Auth.auth().currentUser?.email else {
            return false
        }
        
        db.collection(K.Firestore.Collection.categories).document(category).collection(K.Firestore.Collection.Categories.Report.reports)
            .addDocument(data: [
                K.Firestore.Collection.Categories.Report.Fields.uuid : UUID.init().uuidString,
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
