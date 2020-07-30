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
    private var reportStore = ReportStore()
    var body: some View {
        VStack {
            Spacer()
            Text("Request a dangerous")
                .font(.system(size: 32, weight: .bold))
            Spacer()
            VStack {
                TextField("Description: ", text: $alertViewModel.description)
            }.padding(20)
            Spacer()
            Button(action:{
                if self.locationManager.location != nil, let location = self.locationManager.location {
                    // TODO: Secure behind user uses to often a button to request a report
                    // TODO: Make coordinator to shortcut the description way of creating report
                    self.reportStore.getLocationBeforeSend(location)
                    self.reportStore.getDescriptionBeforeSend(self.alertViewModel.description)
                    self.reportStore.sendReport()   // result is for a "feature" todo lately
                }
            }){
                Text("Report")
            }.frame(minWidth: 0, maxWidth: .infinity)
                .frame(height: 50)
                .background(LinearGradient(gradient: Gradient(colors: [Color.blue, Color.purple]),startPoint: .leading,endPoint: .trailing))
                .foregroundColor(Color.white)
                .disabled(alertViewModel.disabledButton)
        }
    }
}

struct AlertView_Previews: PreviewProvider {
    static var previews: some View {
        AlertView()
    }
}
