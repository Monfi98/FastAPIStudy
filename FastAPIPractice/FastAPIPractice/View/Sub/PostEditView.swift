//
//  PostEditView.swift
//  FastAPIPractice
//
//  Created by 신승재 on 7/2/24.
//

import SwiftUI

struct PostEditView: View {
    @Binding var userId: String
    @Binding var path: [NavigationDestination]
    
    @State private var title: String = ""
    @State private var content: String = ""
    
    var body: some View {
        NavigationView {
            VStack(alignment: .leading) {
                Text("Edit Post")
                    .font(.title)
                
                
                TextField("Enter Title", text: $title)
                    .padding()
                    .background(Color(.secondarySystemBackground))
                    .cornerRadius(8)
                
                Spacer().frame(height: 20)
                
                TextEditor(text: $content)
                    .padding()
                    .scrollContentBackground(.hidden)
                    .background(Color(.secondarySystemBackground))
                    .cornerRadius(8)
                    .frame(height: 300)
                
                Spacer()
            }
            .padding()
            .toolbar {
                ToolbarItem(placement: .topBarLeading, content: {
                    Button(action: {
                        path.removeLast()
                    }) {
                        Image(systemName: "chevron.left")
                    }
                })
                
                ToolbarItem(placement: .topBarTrailing, content: {
                    Button(action: {
                        checkButtonTapped(authorId: userId, title: title, content: content)
                    }) {
                        Image(systemName: "checkmark")
                    }
                })
            }
        }.navigationBarBackButtonHidden(true)
    }
}

extension PostEditView {
    private func checkButtonTapped(authorId: String, title: String, content: String) {
        NetworkManager.shared.session.request(NetworkRouter.createPost(authorId: authorId, title: title, content: content))
            .response { response in
                guard let statusCode = response.response?.statusCode else { return }
                switch statusCode {
                case 200:
                    print("Create Post Success")
                    path.removeLast()
                case 422:
                    print("Validation Error")
                default:
                    print("Other status code ->\(statusCode)")
                }
            }
    }
}

#Preview {
    PostEditView(userId: .constant(""), path: .constant([]))
}
