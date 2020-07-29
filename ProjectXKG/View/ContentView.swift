//
//  ContentView.swift
//  ProjectXKG
//
//  Created by Grzegorz Gumieniak on 27/06/2020.
//  Copyright © 2020 Grzegorz Gumieniak. All rights reserved.
//

import MapKit
import SwiftUI

struct ContentView: View {
    
    @EnvironmentObject var session: SessionStore
//    @EnvironmentObject var repoStore:
    @State var isModel: Bool = false
    @ObservedObject private var locationManager = LocationManager()
    
    var body: some View {
        Group {
            if (session.session != nil) {
                ZStack {
                    // TODO: Dodac managera, ktory obsluguje wyswietlanie aktualnej lokalizacji (aktywnie)
                    MapView(coordinate: locationManager.get2DLocationCoordinate())
                        .edgesIgnoringSafeArea(.all)
                        .onAppear{
                            // TODO: wlaczenie wyszukiwanie w bazie danych
                            print("Mapa sie pojawila")
                    }
                    VStack {
                        Spacer()
                        HStack {
                            Button(action: {
                                print("Informacje")
                                self.session.signOut()
                            }) {
                                Image(systemName: "gear") // TODO: iOS14 zmiana na gearshape
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
                                    // TODO: Dodac zglaszanie obecnej lokalizacji
                                    print(self.locationManager.location?.coordinate)
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
                                    AlertView()
                                })
                            }
                        }.padding()
                    }
                }
            } else {
                AuthView()
            }
        }.onAppear{ self.session.listen() }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().environmentObject(SessionStore())
    }
}
