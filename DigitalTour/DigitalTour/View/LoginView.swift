//
//  LoginView.swift
//  DigitalTour
//
//  Created by Shane Chen on 3/25/25.
//

import SwiftUI

struct LoginView: View {
    @State private var username: String = ""
    @State private var password: String = ""
    @AppStorage("isLoggedIn") private var isLoggedIn: Bool = false
    
    var body: some View {
        if isLoggedIn {
            // Move to CitySelectionView once logged in
            CitySelectionView()
        } else {
            VStack(spacing: 20) {
                Text("Welcome to DigitalTour")
                    .font(.largeTitle)
                
                // Custom login fields
                TextField("Username", text: $username)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding(.horizontal)
                SecureField("Password", text: $password)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding(.horizontal)
                
                Button("Login with My Account") {
                    //TODO: Validate username/password, etc.
                    isLoggedIn = true
                }
                .padding()
                
                // Sign in with Apple
                Button("Sign in with Apple") {
                    //TODO: Implement the Apple sign-in flow
                    isLoggedIn = true
                }
                .padding()
                
                // Sign in with Google
                Button("Sign in with Google") {
                    //TODO: Implement the Google sign-in flow
                    isLoggedIn = true
                }
                .padding()
            }
        }
    }
}
