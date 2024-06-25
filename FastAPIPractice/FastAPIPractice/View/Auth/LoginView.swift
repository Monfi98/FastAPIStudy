//
//  LoginView.swift
//  FastAPIPractice
//
//  Created by 신승재 on 6/25/24.
//

import SwiftUI

struct LoginView: View {
    @State private var username: String = ""
    @State private var password: String = ""
    @State private var showingAlert = false

    var body: some View {
        VStack {
            
            Spacer().frame(height: 100)
            
            // Logo or Title
            Text("Login")
                .font(.largeTitle)
                .fontWeight(.bold)
                .padding(.bottom, 40)
            
            // Username Field
            TextField("Username", text: $username)
                .padding()
                .background(Color(.secondarySystemBackground))
                .cornerRadius(5.0)
                .padding(.bottom, 20)
            
            // Password Field
            SecureField("Password", text: $password)
                .padding()
                .background(Color(.secondarySystemBackground))
                .cornerRadius(5.0)
                .padding(.bottom, 20)
            
            // Login Button
            Button(action: {
                // Perform login action here
                if username.isEmpty || password.isEmpty {
                    showingAlert = true
                }
            }) {
                Text("Login")
                    .font(.headline)
                    .foregroundColor(.white)
                    .padding()
                    .frame(width: 220, height: 60)
                    .background(Color.blue)
                    .cornerRadius(15.0)
            }
            .alert(isPresented: $showingAlert) {
                Alert(title: Text("Error"), message: Text("Please enter both username and password."), dismissButton: .default(Text("OK")))
            }
            
            Spacer()
            
            // Sign Up Button
            HStack {
                Text("Don't have an account?")
                Button(action: {
                    // Navigate to sign up view
                }) {
                    Text("Sign Up")
                        .fontWeight(.bold)
                        .foregroundColor(.blue)
                }
            }
        }
        .padding(.horizontal, 16)
    }
}

#Preview {
    LoginView()
}