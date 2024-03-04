//
//  HomeViewModel.swift
//  A-Star Studio
//
//  Created by Ayren King on 2/25/24.
//

import SwiftUI

@Observable
class HomeViewModel {
    var rows: Int = 5
    var columns: Int = 5
    var allowDiagnoals: Bool = false
    
    var editMode: EditMode? = .startPoint
    
    var isPathfinding: Bool = false
    var showNoPathFoundAlert: Bool = false
    
    // Grid
    var gridModel: VisualGridModel = VisualGridModel()
    
    var disableStart: Bool {
        gridModel.startPoint == nil || gridModel.endPoint == nil || isPathfinding
    }
    
    func startPathfinding() {
        isPathfinding = true
        
        Task {
            guard let path = await gridModel.aStarDistance(allowDiagonals: allowDiagnoals, delay: .milliseconds(200)) else {
                await MainActor.run {
                    showNoPathFoundAlert = true
                    isPathfinding = false
                }
                return
            }
            
            // clear all other nodes
            await MainActor.run { gridModel.reset() }
            
            // animate path in order
            await gridModel.highlightGrid(for: path.reversed())
            
            await MainActor.run { isPathfinding = false }
        }
    }
}
