//
//  ContentView.swift
//  A-Star Studio
//
//  Created by Ayren King on 1/14/24.
//

import SwiftUI
import SwiftData

struct ContentView: View {

    var body: some View {
        NavigationStack {
            HomeScreen()
        }
        .frame(minWidth: 300, minHeight: 650)
    }
}

#Preview {
    ContentView()
        .environment(HomeViewModel())
}
