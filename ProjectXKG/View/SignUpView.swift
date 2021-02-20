//
//  SignUpView.swift
//  ProjectXKG
//
//  Created by Grzegorz Gumieniak on 18/07/2020.
//  Copyright © 2020 Grzegorz Gumieniak. All rights reserved.
//

import SwiftUI

struct SignUpView: View {
    @EnvironmentObject var session: SessionStore
    @ObservedObject var signUpViewModel =  SignUpViewModel()
    
    var body: some View {
        VStack {
            Text("Create an account")
                .font(.system(size: 32,weight: .bold))
            Text("Sign up to get started")
                .font(.system(size: 18,weight: .medium))
                .foregroundColor(Color.gray)
            VStack(spacing: 18) {
                TextField("Email Address", text: self.$signUpViewModel.email)
                    .font(.system(size: 16))
                    .padding(12)
                    .background(RoundedRectangle(cornerRadius: 5).stroke(Color(.systemBlue), lineWidth: 2))
                SecureField("Password", text: self.$signUpViewModel.password)
                    .font(.system(size: 16))
                    .padding(12)
                    .background(RoundedRectangle(cornerRadius: 5).stroke(Color(.systemBlue), lineWidth: 2))
            }.padding(.vertical, 64)
            Button(action: self.signUpViewModel.signUp) {
                Text("Create account")
                    .frame(minWidth: 0,maxWidth: .infinity)
                    .frame(height: 50)
                    .foregroundColor(.white)
                    .font(.system(size: 14, weight: .bold))
                    .background(LinearGradient(gradient: Gradient(colors: [Color.blue,Color.pink]), startPoint: .leading, endPoint: .trailing))
                    .cornerRadius(5)
            }
            if (self.signUpViewModel.error != "") {
                Text(self.signUpViewModel.error)
                    .font(.system(size: 16,weight: .semibold))
                    .foregroundColor(.red)
                    .padding()
            }
        }
    }
}

struct SignUpView_Previews: PreviewProvider {
    static var previews: some View {
        SignUpView()
    }
}
