//
//  SignInView.swift
//  ProjectXKG
//
//  Created by Grzegorz Gumieniak on 18/07/2020.
//  Copyright © 2020 Grzegorz Gumieniak. All rights reserved.
//

import SwiftUI

struct SignInView: View {
    @State var email: String = ""
    @State var password: String = ""
    @State var error: String = ""
    @EnvironmentObject var session: SessionStore
    
    func signIn() {
        session.signIn(email: email, password: password) { Result,error in
            if let error = error {
                self.error = error.localizedDescription
            } else {
                self.email = ""
                self.password = ""
            }
        }
    }
    
    var body: some View {
        VStack{
            Text("Welcome back!")
                .font(.system(size: 32,weight: .bold))
            Text("Sign in to get started")
                .font(.system(size: 18,weight: .medium))
                .foregroundColor(Color.gray)
            VStack(spacing: 18) {
                TextField("Email Address", text: $email)
                    .font(.system(size: 16))
                    .padding(12)
                    .background(RoundedRectangle(cornerRadius: 5).stroke(Color(.systemBlue), lineWidth: 2))
                SecureField("Password", text: $password)
                    .font(.system(size: 16))
                    .padding(12)
                    .background(RoundedRectangle(cornerRadius: 5).stroke(Color(.systemBlue), lineWidth: 2))
                
            }.padding(.vertical, 64)
            
            Button(action: signIn) {
                Text("Sign In")
                    .frame(minWidth: 0,maxWidth: .infinity)
                    .frame(height: 50)
                    .foregroundColor(.white)
                    .font(.system(size: 14, weight: .bold))
                    .background(LinearGradient(gradient: Gradient(colors: [Color.blue,Color.pink]), startPoint: .leading, endPoint: .trailing))
                    .cornerRadius(5)
            }
            if (error != "") {
                Text(error)
                    .font(.system(size: 16,weight: .semibold))
                    .foregroundColor(.red)
                    .padding()
            }
            Spacer()
            NavigationLink(destination: SignUpView())
            {
                HStack{
                    Text("Im new user")
                        .font(.system(size: 14, weight: .light))
                        .foregroundColor(Color.primary)
                    Text("Create an account")
                        .font(.system(size: 14, weight: .semibold))
                        .foregroundColor(Color.blue)
                }
            }
        }.padding(.horizontal,32)
    }
}

struct SignInView_Previews: PreviewProvider {
    static var previews: some View {
        SignInView()
    }
}
