//
//  LoginView.swift
//  FastAPIPractice
//
//  Created by 신승재 on 6/25/24.
//

import SwiftUI

struct LoginView: View {
    @Binding var userId: String
    @Binding var path: [NavigationDestination]
    
    @State private var id: String = ""
    @State private var password: String = ""
    @State private var showingAlert = false
    
    var body: some View {
        VStack {
            
            Spacer().frame(height: 200)
            
            Text("Login View")
                .font(.largeTitle)
                .fontWeight(.bold)
                .padding(.bottom, 40)
            
            TextField("Username", text: $id)
                .padding()
                .background(Color(.secondarySystemBackground))
                .cornerRadius(5.0)
                .padding(.bottom, 20)
                .autocapitalization(.none)
            
            SecureField("Password", text: $password)
                .padding()
                .background(Color(.secondarySystemBackground))
                .cornerRadius(5.0)
                .padding(.bottom, 20)
                .autocapitalization(.none)
            
            Button(action: {
                if id.isEmpty || password.isEmpty {
                    showingAlert = true
                } else {
                    loginButtonTapped(id: id, password: password)
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
            
            HStack {
                Text("Don't have an account?")
                Button(action: {
                    path.append(NavigationDestination.registerView)
                }) {
                    Text("Sign Up")
                        .fontWeight(.bold)
                        .foregroundColor(.blue)
                }
            }
            Spacer().frame(height: 20)
        }
        .padding(.horizontal, 16)
        .ignoresSafeArea()
        .navigationBarBackButtonHidden()
    }
}

extension LoginView {
    private func loginButtonTapped(id: String, password: String) {
        NetworkManager.shared.session.request(NetworkRouter.login(id: id, password: password))
            .response { response in
                guard let statusCode = response.response?.statusCode else { return }
                switch statusCode {
                case 200:
                    print("Login Success")
                    self.userId = id
                    path.removeLast()
                case 400:
                    print("Invalid credentials")
                case 422:
                    print("Validation Error")
                default:
                    print("Other status code ->\(statusCode)")
                }
            }
    }
}

#Preview {
    LoginView(userId: .constant(""), path: .constant([]))
}
