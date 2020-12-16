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
    @EnvironmentObject private var locationManager: LocationManager 
    @ObservedObject var mapViewModel = MapViewModel()
    
    var body: some View {
        Group {
            if (session.session != nil) {
                ZStack {
                    if locationManager.checkAuthorizationStatus() && locationManager.checkAccuracyStatus() {
                        Map(coordinate: $locationManager.location)
                            .edgesIgnoringSafeArea(.all)
                            .onAppear{
                                self.mapViewModel.fetchData()
                                self.mapViewModel.scheduleTimer()
                                print("Pojawiam sie")
                            }
                            .onReceive(self.locationManager.$location, perform: { _ in
                                self.mapViewModel.location = self.locationManager.location
                            })
                    } else {
                        VStack{
                            Image(systemName: "exclamationmark.triangle.fill").fixedSize().scaledToFit().font(.system(.title))
                            Text("You have give acces to location")
                        }
                    }
                    VStack {
                        Spacer()
                        HStack {
                            Button(action: {
//                                print("Menu")
//                                print("Lokalne",UserDefaults.standard.bool(forKey: K.Firestore.Collection.Categories.localThreaten))
//                                print("Drogowe",UserDefaults.standard.bool(forKey: K.Firestore.Collection.Categories.roadAccident))
//                                print("Pogodowe",UserDefaults.standard.bool(forKey: K.Firestore.Collection.Categories.weather))
                                self.mapViewModel.showMenuView.toggle()
                            }) {
                                Image(systemName: "gear") 
                            }.sheet(isPresented: self.$mapViewModel.showMenuView, content: {
                                MenuView(isPresented: self.$mapViewModel.showMenuView, user: self.session.session?.email ?? "Undefined", signOut: self.session.signOut )
                            })
                            .padding()
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
                                    self.mapViewModel.showAlertView.toggle()
                                }){
                                    Image(systemName: "plus")
                                }
                                .padding()
                                .background(MapViewModel.sendedMessage ? Color.gray.opacity(0.75) : Color.red.opacity(0.75))
                                .foregroundColor(Color.white)
                                .font(.system(.title))
                                .clipShape(Circle())
                                .sheet(isPresented: $mapViewModel.showAlertView, content: {
                                    AlertView(isPresented: self.$mapViewModel.showAlertView).environmentObject(self.locationManager)
                                }).disabled(MapViewModel.sendedMessage)
                            }
                        }.padding()
                    }
                }
            } else {
                AuthView()
            }
        }.onAppear{
            self.session.listen()
            UNUserNotificationCenter.current().requestAuthorization(options: [.alert,.badge,.sound]){
                succes, error in
                if succes {
                    print("Notification granted")
                }else if let error = error {
                    print(error.localizedDescription)
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        MapView().environmentObject(SessionStore())
    }
}
