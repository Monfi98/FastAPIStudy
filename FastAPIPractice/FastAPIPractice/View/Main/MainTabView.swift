//
//  MainView.swift
//  FastAPIPractice
//
//  Created by 신승재 on 6/25/24.
//

import SwiftUI

struct MainTabView: View {
    @AppStorage("UserID") var userId: String = ""
    @State var path: [NavigationDestination] = []
    @State var loginStatus = false
    
    var body: some View {
        NavigationStack(path: $path) {
            TabView {
                HomeView(path: $path)
                    .tabItem {
                        Image(systemName: "house.fill")
                        Text("Home")
                    }
                
                ProfileView(path: $path)
                    .tabItem {
                        Image(systemName: "person.fill")
                        Text("Profile")
                    }
                
                SettingsView(path: $path)
                    .tabItem {
                        Image(systemName: "gearshape.fill")
                        Text("Settings")
                    }
            }
            .navigationDestination(for: NavigationDestination.self) { destination in
                            switch destination {
                            case .loginView:
                                LoginView(userId: $userId, path: $path)
                            case .registerView:
                                RegisterView(path: $path)
                            case .postEditView:
                                PostEditView(userId: $userId, path: $path)
                            }
                        }
        }
        .onAppear() {
            if !loginStatus {
                path.append(NavigationDestination.loginView)
            }
        }
    }
}

enum NavigationDestination: String {
    case loginView
    case registerView
    case postEditView
}

#Preview {
    MainTabView()
}
