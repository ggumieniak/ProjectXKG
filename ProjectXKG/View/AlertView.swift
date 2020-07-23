//
//  AlertView.swift
//  ProjectXKG
//
//  Created by Grzegorz Gumieniak on 23/07/2020.
//  Copyright © 2020 Grzegorz Gumieniak. All rights reserved.
//

import SwiftUI

struct AlertView: View {
    @State var opis: String = ""
    
    var body: some View {
        VStack {
            Text("Request a dangerous")
            Spacer()
            VStack {
                TextField("Tresc wiadomosci: ", text: $opis)
                TextField("Tresc wiadomosci: ", text: $opis)
            }.padding(20)
            Spacer()
            Button(action:{
                print("Nacisnalem guziczek")
            }){
                Text("Wyglad przycisku")
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
