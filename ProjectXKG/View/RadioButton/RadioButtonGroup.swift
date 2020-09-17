//
//  RadioButtonGroup.swift
//  ProjectXKG
//
//  Created by Grzegorz Gumieniak on 15/09/2020.
//  Copyright © 2020 Grzegorz Gumieniak. All rights reserved.
//

import SwiftUI

struct RadioButtonGroups: View {
    let callback: (String) -> ()
    
    @State var selectedId = ""
    
    var body: some View {
        VStack {
            localThreatenButton
            roadAccidentButton
            weatherButton
        }
    }
    
    var localThreatenButton: some View {
        RadioButtonField(id: K.Firestore.Collection.Categories.localThreaten, label: K.Firestore.Collection.Categories.localThreaten, size: 14, textSize: 14, isMarked: selectedId == K.Firestore.Collection.Categories.localThreaten ? true : false, callback: radioGroupCallback)
    }
    
    var roadAccidentButton: some View {
        RadioButtonField(id: K.Firestore.Collection.Categories.roadAccident, label: K.Firestore.Collection.Categories.roadAccident, size: 14, textSize: 14, isMarked: selectedId == K.Firestore.Collection.Categories.roadAccident ? true : false, callback: radioGroupCallback(id:))
    }
    
    var weatherButton: some View {
        RadioButtonField(id: K.Firestore.Collection.Categories.weather, label: K.Firestore.Collection.Categories.weather, size: 14, textSize: 14, isMarked: selectedId == K.Firestore.Collection.Categories.weather ? true : false, callback: radioGroupCallback(id:))
    }
    
    func radioGroupCallback(id: String) {
        selectedId = id
        callback(id)
    }
}
