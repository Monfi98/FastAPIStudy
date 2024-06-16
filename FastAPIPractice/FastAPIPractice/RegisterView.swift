//
//  ContentView.swift
//  FastAPIPractice
//
//  Created by 신승재 on 6/16/24.
//

import SwiftUI

struct RegisterView: View {
    
    @State private var name: String = ""
    @State private var id: String = ""
    @State private var password: String = ""
    @State private var errorMessage: String = ""
    
    @State private var showingAlert: Bool = false
    
    var body: some View {
        VStack {
            Spacer()
            
            VStack(alignment: .leading, spacing: 15) {
                TextField("이름", text: $name)
                    .padding()
                    .background(Color.gray.opacity(0.2))
                    .cornerRadius(5.0)
                    .autocapitalization(.none)
                
                TextField("아이디", text: $id)
                    .padding()
                    .background(Color.gray.opacity(0.2))
                    .cornerRadius(5.0)
                    .autocapitalization(.none)
                
                SecureField("비밀번호", text: $password)
                    .padding()
                    .background(Color.gray.opacity(0.2))
                    .cornerRadius(5.0)
            }
            .padding(.horizontal, 25)
            
            Button(action: {
                if name.isEmpty || id.isEmpty || password.isEmpty {
                    showingAlert = true
                } else {
                    registerUser(user: User(username: name, id: id, password: password))
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
    func registerUser(user: User) {
        NetworkManager.shared.registerUser(user: user) { result in
            DispatchQueue.main.async {
                switch result {
                case .success(let message):
                    print("회원가입 성공!")
                case .failure(let error):
                    print("에러 --> \(error.localizedDescription)")
                }
            }
        }
    }
}

#Preview {
    RegisterView()
}
