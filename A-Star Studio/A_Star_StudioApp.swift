//
//  A_Star_StudioApp.swift
//  A-Star Studio
//
//  Created by Ayren King on 1/14/24.
//

import SwiftUI
import SwiftData

@main
struct A_Star_StudioApp: App {
    @State private var model = HomeViewModel()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(model)
        }
        .commands {
            CommandMenu("Editor") {
                Button("Allow diagonals") {
                    model.allowDiagnoals.toggle()
                }
                .keyboardShortcut("d", modifiers: [])
                .disabled(model.isPathfinding)
                
                ForEach(EditMode.allCases) { mode in
                    Button(mode.title) {
                        model.editMode = mode
                    }
                    .keyboardShortcut(mode.keyboardShortcut)
                    .disabled(model.isPathfinding)
                }
                
                Button("Cancel") {
                    model.editMode = nil
                }
                .keyboardShortcut(KeyboardShortcut("4", modifiers: .numericPad))
                .disabled(model.isPathfinding)
            }
            
            CommandMenu("Algorithm") {
                Button("Start Pathfinding") {
                    model.startPathfinding()
                }
                .keyboardShortcut("p")
                .disabled(model.disableStart)
                
                Button("Reset") {
                    model.gridModel.reset()
                }.keyboardShortcut("r")
            }
        }
    }
}
