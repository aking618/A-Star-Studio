//
//  HomeScreen.swift
//  A-Star Studio
//
//  Created by Ayren King on 2/15/24.
//

import Foundation
import SwiftUI

struct HomeScreen: View {
    @Environment(HomeViewModel.self) var model
    
    var body: some View {
        VStack {
            GridControls()
            
            Spacer()
            
            VisualGrid()
        }
        .padding()
        .navigationTitle("A* Studio")
        .environment(model)
        .onAppear {
            model.gridModel.resize(rows: model.rows, columns: model.columns)
        }
        .alert("No path found.",
               isPresented: Binding (
                get: { model.showNoPathFoundAlert },
                set: { newValue in model.showNoPathFoundAlert = newValue}
               )
        ) {
            Button("OK", role: .cancel) {
                model.showNoPathFoundAlert = false
            }
        }
    }
}
