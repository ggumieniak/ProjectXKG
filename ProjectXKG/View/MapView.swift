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
    @State var isModel: Bool = false
    @EnvironmentObject private var locationManager: LocationManager
    @EnvironmentObject var report: ReportStore
    @ObservedObject var mapViewModel = MapViewModel()
    
    var body: some View {
        Group {
            if (session.session != nil) {
                ZStack {
                    Map(coordinate: locationManager.get2DLocationCoordinate())
                        .edgesIgnoringSafeArea(.all)
                        .onAppear {
                            // TODO: Change to static downloading every
                            self.mapViewModel.fetchData()
                    }
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
                            
                            Button(action: {
                                print("Pobieram dane...")
                            }, label: {
                                Text("Pobierz dane")
                            })
                            VStack {
                                Text("\(locationManager.location?.coordinate.latitude.description ?? "Brak lat")")
                                Text("\(locationManager.location?.coordinate.longitude.description ?? "Brak long")")
                            }
                            if locationManager.checkAuthorizationStatus()
                            {
                                Button(action: {
                                    self.isModel.toggle()
                                }){
                                    Image(systemName: "plus")
                                }
                                .padding()
                                .background(Color.red.opacity(0.75))
                                .foregroundColor(Color.white)
                                .font(.system(.title))
                                .clipShape(Circle())
                                .sheet(isPresented: $isModel, content: {
                                    AlertView(isPresented: self.$isModel).environmentObject(self.report).environmentObject(self.locationManager)
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
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        MapView().environmentObject(SessionStore())
    }
}
