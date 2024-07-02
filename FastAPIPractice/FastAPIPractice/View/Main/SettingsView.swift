//
//  SettingsView.swift
//  FastAPIPractice
//
//  Created by 신승재 on 6/25/24.
//

import SwiftUI

struct SettingsView: View {
    @Binding var path: [NavigationDestination]
    var body: some View {
        ZStack {
            Color(.secondarySystemBackground)
            VStack {
                Text("Settings Screen")
            }
        }
    }
}

#Preview {
    SettingsView(path: .constant([]))
}
