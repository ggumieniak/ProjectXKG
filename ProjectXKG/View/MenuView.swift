//
//  MenuView.swift
//  ProjectXKG
//
//  Created by Grzegorz Gumieniak on 23/09/2020.
//  Copyright © 2020 Grzegorz Gumieniak. All rights reserved.
//

import SwiftUI

struct MenuView: View {
    @Environment(\.colorScheme) var colorScheme
    @State var zabawa: Double = 0
    @Binding var isPresented: Bool
    let user: String
    let signOut: () -> ()

    var body: some View {
        VStack(alignment: .leading) {
            HStack{
                Image(systemName: "person.crop.circle")
                Text(user)
            }.font(.system(.title)).scaledToFit()
                .padding(.top)
                .padding(.leading, 10)
            Spacer()
            Slider(value: $zabawa, in:1...100,step: 1)
            HStack{
                Spacer()
                Text("You will get a message away at: \(Int(zabawa)) km").font(.system(.body))
                Spacer()
            }
            Spacer()
            Button(action: {
                print("Nacisnales przycisk")
                self.signOut()
            }){
                Image(systemName: "arrow.down.left.circle.fill")
                Text("SignOut")
            }.foregroundColor(colorScheme == .light ? Color.black : Color.white )
            .font(.system(.callout))
                .padding(.leading,10)
                .padding(.bottom, 20)
        }
    }
    

    
}
