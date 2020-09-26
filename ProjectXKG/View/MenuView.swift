//
//  MenuView.swift
//  ProjectXKG
//
//  Created by Grzegorz Gumieniak on 23/09/2020.
//  Copyright © 2020 Grzegorz Gumieniak. All rights reserved.
//

import SwiftUI

struct MenuView: View {
    @State var zabawa: Double = 0
    @Binding var isPresented: Bool
    let user: String

    var body: some View {
        VStack(alignment: .leading) {
            HStack{
                Image(systemName: "person.crop.circle")
                Text(user).contextMenu {
                    Text("Ziobro ty kurwo jebana")
                    Text("Przestań mi rodzine prześladować")
                }
            }.font(.system(size: 32)).scaledToFit()
            Spacer()
            RadioButtonGroups() { selected in
                print(selected)
            }
            Slider(value: $zabawa, in:0.5...100,step: 0.5){
                Text("To jest slider")
            }
            Spacer()
            Button(action: {
                print("Nacisnales przycisk")
            }){
                Image(systemName: "arrow.down.left.circle.fill")
                Text("SignOut")
            }.padding()
        }.padding(.leading, 10)
    }
    

    
}
