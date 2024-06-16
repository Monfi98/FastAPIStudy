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
    
    @State private var showingWarningAlert: Bool = false
    @State private var showingIdExistsAlert: Bool = false
    @State private var showingSuccessAlert: Bool = false
    
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
                    showingWarningAlert = true
                } else {
                    // Handle login action
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
            .alert(isPresented: $showingWarningAlert) {
                Alert(title: Text("경고"),
                      message: Text("텍스트 필드에 빈 값이 있습니다."),
                      dismissButton: .default(Text("확인")))
            }
            .alert(isPresented: $showingIdExistsAlert) {
                Alert(title: Text("경고"),
                      message: Text("중복된 아이디가 존재합니다."),
                      dismissButton: .default(Text("확인")))
            }
            .alert(isPresented: $showingSuccessAlert) {
                Alert(title: Text("성공"),
                      message: Text("회원가입에 성공했습니다."),
                      dismissButton: .default(Text("확인")))
            }
            
            Spacer()
        }
        .padding()
    }
}

// MARK: - Extension
extension RegisterView {
    
}

#Preview {
    RegisterView()
}
