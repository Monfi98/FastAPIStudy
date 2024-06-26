//
//  ContentView.swift
//  FastAPIPractice
//
//  Created by 신승재 on 6/16/24.
//

import SwiftUI

struct RegisterView: View {
    
    @Binding var path: [NavigationDestination]
    @State private var name: String = ""
    @State private var id: String = ""
    @State private var password: String = ""
    @State private var errorMessage: String = ""
    
    @State private var showingAlert: Bool = false
    
    var body: some View {
        VStack {
            Spacer().frame(height: 100)
            
            VStack(alignment: .leading, spacing: 15) {
                TextField("username", text: $name)
                    .padding()
                    .background(Color.gray.opacity(0.2))
                    .cornerRadius(5.0)
                    .autocapitalization(.none)
                
                TextField("id", text: $id)
                    .padding()
                    .background(Color.gray.opacity(0.2))
                    .cornerRadius(5.0)
                    .autocapitalization(.none)
                
                SecureField("password", text: $password)
                    .padding()
                    .background(Color.gray.opacity(0.2))
                    .cornerRadius(5.0)
            }
            .padding(.horizontal, 25)
            
            Button(action: {
                if name.isEmpty || id.isEmpty || password.isEmpty {
                    showingAlert = true
                } else {
                    registerButtonTapped(username: self.name, id: self.id, password: self.password)
                }
            }) {
                Text("회원가입")
                    .font(.headline)
                    .foregroundColor(.white)
                    .padding()
                    .frame(width: 200, height: 60)
                    .background(Color.blue)
                    .cornerRadius(15.0)
            }
            .padding(.top, 50)
            .alert(isPresented: $showingAlert) {
                
                Alert(title: Text("경고"),
                      message: Text("텍스트 필드에 빈 값이 있습니다."),
                      dismissButton: .default(Text("확인")))
            }
            
            Spacer()
        }
        .padding()
    }
}

// MARK: - Extension
extension RegisterView {
    func registerButtonTapped(username: String, id: String, password: String) {
        NetworkManager.shared.session.request(NetworkRouter.registerUser(username: username, id: id, password: password))
            .response { response in
                guard let statusCode = response.response?.statusCode else { return }
                switch statusCode {
                case 200:
                    print("Successful Response")
                    path.removeLast()
                case 400:
                    print("ID already exists")
                case 422:
                    print("Validation Error")
                default:
                    print("Other status code ->\(statusCode)")
                }
            }
    }
}

#Preview {
    RegisterView(path: .constant([]))
}
