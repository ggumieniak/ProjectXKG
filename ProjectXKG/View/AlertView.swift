//
//  AlertView.swift
//  ProjectXKG
//
//  Created by Grzegorz Gumieniak on 23/07/2020.
//  Copyright © 2020 Grzegorz Gumieniak. All rights reserved.
//

import SwiftUI

struct AlertView: View {
    @ObservedObject var alertViewModel = AlertViewModel()
    @ObservedObject private var locationManager = LocationManager()
    
    var body: some View {
        VStack {
            Spacer()
            Text("Request a dangerous")
                .font(.system(size: 32, weight: .bold))
            Spacer()
            VStack {
                TextField("Tresc wiadomosci: ", text: $alertViewModel.opis)
            }.padding(20)
            Spacer()
            Button(action:{
                print("To sa lokalizacje od lm w AlertView")
                print(self.locationManager.location?.coordinate)
                
            }){
                Text("Report")
            }.frame(minWidth: 0, maxWidth: .infinity)
                .frame(height: 50)
                .background(LinearGradient(gradient: Gradient(colors: [Color.blue, Color.purple]),startPoint: .leading,endPoint: .trailing))
                .foregroundColor(Color.white)
        }
    }
}

struct AlertView_Previews: PreviewProvider {
    static var previews: some View {
        AlertView()
    }
}
