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
    @EnvironmentObject var reportStore: ReportService
    @Binding var isPresented: Bool
    
    var body: some View {
        VStack {
            Spacer()
            Text("Request a dangerous")
                .font(.system(size: 32, weight: .bold))
            Spacer()
            Spacer()
            VStack {
                TextField("Description: ", text: $alertViewModel.description)
            }.padding(20)
            Spacer()
            Button(action:{
                if let location = self.locationManager.location {
                    // TODO: Secure behind user uses to often a button to request a report
                    self.isPresented = !self.reportStore.sendReport(location: location.convertCLLocationToGeoPoint(), description: self.alertViewModel.description)
                }
            }){
                Text("Report").frame(minWidth: 0, maxWidth: .infinity)
                    .frame(height: 50)
                    .font(.system(size: 14, weight: .bold))
                    .background(LinearGradient(gradient: Gradient(colors: [Color.blue, Color.purple]),startPoint: .leading,endPoint: .trailing))
                    .foregroundColor(Color.white)
                    .cornerRadius(5)
            }
        }.onAppear{
            self.locationManager.stopUpdatingWhileReporting()
        }.onDisappear{
            self.locationManager.startUpdatingWhileReporting()
        }
    }
}

//struct AlertView_Previews: PreviewProvider {
//    static var previews: some View {
//        AlertView(isPresented: .constant(true))
//    }
//}
