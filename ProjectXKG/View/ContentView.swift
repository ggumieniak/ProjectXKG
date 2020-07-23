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
    @State var isModel: Bool = false
    @ObservedObject private var locationManager = LocationManager()
    
    var body: some View {
        Group {
            if (session.session != nil) {
                ZStack {
                    // TODO: Dodac managera, ktory obsluguje wyswietlanie aktualnej lokalizacji (aktywnie)
                    MapView().edgesIgnoringSafeArea(.all)
                    Circle()
                        .fill(Color.blue)
                        .opacity(0.2)
                        .frame(width: 14, height: 14)
                    VStack {
                        Spacer()
                        HStack {
                            Button(action: {
                                print("Informacje")
                                // TODO: Okno z widokiem ustawien
                            }) {
                                Image(systemName: "gear") // TODO: iOS14 zmiana na gearshape
                            }.padding()
                                .background(Color.blue.opacity(0.75))
                                .foregroundColor(Color.white)
                                .font(.system(.title))
                                .clipShape(Circle())
                                .padding(.trailing)
                            
                            Spacer()
                            
                            Button(action: {
                                print(self.session.session?.email ?? "Brak maila")
                                // TODO: Dodac zglaszanie obecnej lokalizacji
                                print(self.locationManager.location?.coordinate)
                                self.isModel.toggle()
                            }){
                                Image(systemName: "plus")
                            }.padding()
                                .background(Color.red.opacity(0.75))
                                .foregroundColor(Color.white)
                                .font(.system(.title))
                                .clipShape(Circle())
                                .padding(.trailing)
                            .sheet(isPresented: $isModel, content: {
                                AlertView()
                            })
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
