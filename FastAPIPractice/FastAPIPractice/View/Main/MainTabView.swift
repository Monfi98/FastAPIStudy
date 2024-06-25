//
//  MainView.swift
//  FastAPIPractice
//
//  Created by 신승재 on 6/25/24.
//

import SwiftUI

struct MainTabView: View {
    @State var path: [NavigationDestination] = []
    @State var loginStatus = false
    
    var body: some View {
        NavigationStack(path: $path) {
            TabView {
                HomeView()
                    .tabItem {
                        Image(systemName: "house.fill")
                        Text("Home")
                    }
                
                ProfileView()
                    .tabItem {
                        Image(systemName: "person.fill")
                        Text("Profile")
                    }
                
                SettingsView()
                    .tabItem {
                        Image(systemName: "gearshape.fill")
                        Text("Settings")
                    }
            }
            .navigationDestination(for: NavigationDestination.self) { destination in
                            switch destination {
                            case .loginView:
                                LoginView(path: $path)
                            case .registerView:
                                RegisterView(path: $path)
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
}

#Preview {
    MainTabView()
}
