//
//  MenuView.swift
//  ProjectXKG
//
//  Created by Grzegorz Gumieniak on 23/09/2020.
//  Copyright © 2020 Grzegorz Gumieniak. All rights reserved.
//

import SwiftUI
import Combine

struct MenuView: View {
    @Environment(\.colorScheme) var colorScheme
    @State var zabawa: Double = 10
    @Binding var isPresented: Bool
    let user: String
    let signOut: () -> ()
    @ObservedObject var menuViewModel = MenuViewModel()
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack{
                Image(systemName: "person.crop.circle")
                Text(user).foregroundColor(colorScheme == .light ? Color.black : Color.white)
            }.font(.system(.title)).scaledToFit()
            .foregroundColor(colorScheme == .light ? Color.black : Color.white)
            .padding(.top)
            .padding(.leading, 10)
            Spacer()
            Slider(value: $menuViewModel.myDistance, in:1...100,step: 1){ _ in
                zabawa = menuViewModel.myDistance
            }
            HStack{
                Spacer()
                Text("You will get a message away at: \(Int(menuViewModel.displayDistance != 0 ? menuViewModel.displayDistance : 10)) km")
                    .font(.system(.body))
                    .foregroundColor(colorScheme == .light ? Color.black : Color.white)
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

final class MenuViewModel: ObservableObject {
    let didChange = PassthroughSubject<Void,Never>()
    @Published var displayDistance: Double = UserDefaults.standard.double(forKey: "odleglosc")
    @UserDefault(key: "odleglosc", defaultValue: 10.0)
    var myDistance {
        didSet {
            displayDistance = myDistance
            didChange.send()
        }
    }
}
@propertyWrapper
struct UserDefault<Value: Codable> {
    let key: String
    let defaultValue: Value
    
    init(key: String, defaultValue: Value) {
        self.key = key
        self.defaultValue = defaultValue
    }
    
    var wrappedValue: Value {
        get {
            return UserDefaults.standard.object(forKey: key) as? Value ?? defaultValue
        }
        set {
            UserDefaults.standard.set(newValue, forKey: key)
        }
    }
}
