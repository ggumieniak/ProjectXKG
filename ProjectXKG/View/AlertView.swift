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
    @EnvironmentObject private var locationManager: LocationManager
    @Environment(\.colorScheme) var colorScheme
    @Binding var isPresented: Bool
    
    var body: some View {
        VStack {
            HStack{
                Spacer()
                Button(action: {
                    self.isPresented = false
                }, label: {
                    Text("Done")
                        .font(.system(.body))
                        .foregroundColor(colorScheme == .light ? Color.black : Color.white)
                        .padding(.trailing)
                })
            }.padding(.top)
            Text("Request a dangerous")
                .font(.system(size: 32, weight: .bold))
            Spacer()
            TextField("Title", text: self.$alertViewModel.title).padding()
            RadioButtonGroups() { selected in
                print("User picked \(selected) button")
                self.alertViewModel.category = selected
            }
            TextField("Description - minimum \(K.AlertView.minimumLengthOfDescription) characters", text: $alertViewModel.description).padding()
            Spacer()
            Button(action:{
                if let location = self.locationManager.location {
                    self.isPresented = !self.alertViewModel.sendReport(location: location.convertCLLocationToGeoPoint(), title: self.alertViewModel.title, category: self.alertViewModel.category, description: self.alertViewModel.description)
                }
            }){
                if !alertViewModel.disabledButton {
                    Text("Report").frame(minWidth: 0, maxWidth: .infinity)
                        .frame(height: 50)
                        .font(.system(size: 14, weight: .bold))
                        .background(LinearGradient(gradient: Gradient(colors: [Color.blue, Color.purple]),startPoint: .leading,endPoint: .trailing))
                        .foregroundColor(Color.white)
                        .cornerRadius(5)
                } else {
                    Text("Report").frame(minWidth: 0, maxWidth: .infinity)
                        .frame(height: 50)
                        .font(.system(size: 14, weight: .bold))
                        .background(Color.black)
                        .foregroundColor(Color.white)
                        .cornerRadius(5)
                }
            }.disabled(alertViewModel.disabledButton)
        }.onAppear{
            self.locationManager.stopUpdatingWhileReporting()
        }.onDisappear{
            self.locationManager.startUpdatingWhileReporting()
        }
    }
}
