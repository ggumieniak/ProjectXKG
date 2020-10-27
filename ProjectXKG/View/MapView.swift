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
    /*
     Chwilowo nie dziala wyswietlanie najnowszych raportow (z innych kategorii niz LocalThreat)
     Spowodowane jest to tym, ze dodaje teraz kategorie (wysyla juz dobrze raporty)
     Musze stworzyc menu wyboru kategorii
     Rejestracja i wybor kategorii
     Wyswietlenie wybranych kategorii
     */
    
    @EnvironmentObject var session: SessionStore
    @EnvironmentObject private var locationManager: LocationManager 
    @ObservedObject var mapViewModel = MapViewModel()
    
    var body: some View {
        Group {
            if (session.session != nil) {
                ZStack {
                    if locationManager.checkAuthorizationStatus() && locationManager.checkAccuracyStatus() {
                        Map(coordinate: $locationManager.location,annotations: mapViewModel.reportedLocations)
                            .edgesIgnoringSafeArea(.all)
                            .onAppear{
                                self.mapViewModel.fetchData()
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
                                print("Menu")
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
                                .background(Color.red.opacity(0.75))
                                .foregroundColor(Color.white)
                                .font(.system(.title))
                                .clipShape(Circle())
                                .sheet(isPresented: $mapViewModel.showAlertView, content: {
                                    AlertView(isPresented: self.$mapViewModel.showAlertView).environmentObject(self.locationManager)
                                    
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
