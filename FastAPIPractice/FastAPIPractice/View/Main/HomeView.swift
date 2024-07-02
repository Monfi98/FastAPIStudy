//
//  HomeView.swift
//  FastAPIPractice
//
//  Created by 신승재 on 6/25/24.
//

import SwiftUI

struct HomeView: View {
    @Binding var path: [NavigationDestination]
    @State var posts: [Post] = []
    
    var body: some View {
        NavigationView {
            ZStack {
                Color(.secondarySystemBackground)
                VStack {
                    List(posts, id: \.id) { post in
                        VStack(alignment: .leading) {
                            Text(post.title)
                                .font(.headline)
                            Text("By: \(post.author_id)")
                                .font(.subheadline)
                            Text(post.date.toDateWithZeroTime()!)
                                .font(.subheadline)
                            Text(post.content)
                                .font(.body)
                                .lineLimit(3)
                        }
                        .padding()
                    }
                }
            }
            .toolbar {
                ToolbarItem(placement: .topBarTrailing, content: {
                    Button(action: {
                        path.append(.postEditView)
                    }) {
                        Image(systemName: "plus")
                    }
                })
            }
            .onAppear() {
                fetchAllPosts { posts in
                    if let posts = posts {
                        self.posts = posts
                    }
                }
            }
        }

    }
}

extension HomeView {
    private func fetchAllPosts(completion: @escaping ([Post]?) -> Void) {
        NetworkManager.shared.session.request(NetworkRouter.readAllPost)
            .responseDecodable(of: [Post].self) { response in
                guard let statusCode = response.response?.statusCode else { return }
                switch statusCode {
                case 200:
                    print("Read All Posts Success ->")
                    if let posts = response.value {
                        for post in posts {
                            print("PostID: \(post.id), Date: \(post.date), AutorID: \(post.author_id), Title: \(post.title), Content: \(post.content)")
                        }
                        
                        completion(posts)
                    }
                    
                case 422:
                    print("Validation Error")
                default:
                    print("Other status code ->\(statusCode)")
                }
            }
    }
}

#Preview {
    HomeView(path: .constant([]))
}
