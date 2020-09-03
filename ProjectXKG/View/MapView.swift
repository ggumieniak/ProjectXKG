//
//  ContentView.swift
//  ProjectXKG
//
//  Created by Grzegorz Gumieniak on 27/06/2020.
//  Copyright © 2020 Grzegorz Gumieniak. All rights reserved.
//

import MapKit
import SwiftUI

struct MapView: View {
    
    @EnvironmentObject var session: SessionStore
    //    @EnvironmentObject var repoStore:
    @EnvironmentObject private var locationManager: LocationManager
    @EnvironmentObject var report: ReportStore
    @ObservedObject var mapViewModel = MapViewModel()
    
    var body: some View {
        Group {
            if (session.session != nil) {
                ZStack {
                    Map(coordinate: locationManager.get2DLocationCoordinate(),annotations: MapViewModel.shared.locations)
                        .edgesIgnoringSafeArea(.all)
                    VStack {
                        Spacer()
                        HStack {
                            Button(action: {
                                print("Informacje")
                                self.session.signOut()
                            }) {
                                Image(systemName: "gear") // TODO: iOS14 change for gearshape if it wont break my entire code
                            }.padding()
                                .background(Color.blue.opacity(0.75))
                                .foregroundColor(Color.white)
                                .font(.system(.title))
                                .clipShape(Circle())
                                .padding(.trailing)
                            Spacer()
                            VStack {
                                Text("\(locationManager.location?.coordinate.latitude.description ?? "Brak lat")")
                                Text("\(locationManager.location?.coordinate.longitude.description ?? "Brak long")")
                            }
                            Spacer()
                            if locationManager.checkAuthorizationStatus()
                            {
                                Button(action: {
                                    self.mapViewModel.isModel.toggle()
                                }){
                                    Image(systemName: "plus")
                                }
                                .padding()
                                .background(Color.red.opacity(0.75))
                                .foregroundColor(Color.white)
                                .font(.system(.title))
                                .clipShape(Circle())
                                .sheet(isPresented: $mapViewModel.isModel, content: {
                                    AlertView(isPresented: self.$mapViewModel.isModel).environmentObject(self.report).environmentObject(self.locationManager)
                                    
                                })
                            }
                        }.padding()
                    }
                }
            } else {
                AuthView()
            }
        }.onAppear{
            self.session.listen()
            self.mapViewModel.fetchData(currentLocation: self.locationManager.get2DLocationCoordinate())
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        MapView().environmentObject(SessionStore())
    }
}
