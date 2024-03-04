//
//  VisualGridModel.swift
//  A-Star Studio
//
//  Created by Ayren King on 2/25/24.
//

import RoyalSwift
import SwiftUI

@Observable
class VisualGridModel {
    var values: [[GridBoxValue]] = []
    
    var startPoint: GridBoxValue? {
        values.first(where: { $0.contains(where: { $0.type == .start }) })?.filter { $0.type == .start }.first
    }
    
    var endPoint: GridBoxValue? {
        values.first(where: { $0.contains(where: { $0.type == .end }) })?.filter { $0.type == .end }.first
    }
    
    func resize(rows: Int, columns: Int) {
        values = (0..<rows).map { row in
            (0..<columns).map { col in
                GridBoxValue(type: .none, point: CGPoint(x: row, y: col))
            }
        }
    }
    
    @MainActor func reset() {
        for row in (0..<values.count) {
            for col in (0..<values.first!.count) {
                values[row][col].value = 0
            }
        }
    }
    
    func resetStartPoint() {
        for row in (0..<values.count) {
            for col in (0..<values.first!.count) where values[row][col].type == .start {
                values[row][col].type = .none
            }
        }
    }
    
    func resetEndtPoint() {
        for row in (0..<values.count) {
            for col in (0..<values.first!.count) where values[row][col].type == .end {
                values[row][col].type = .none
            }
        }
    }
    
    @MainActor func highlightGrid(for path: [CGPoint]) async {
        for node in path {
            values[node].value = 5
            try? await Task.sleep(for: .milliseconds(200))
        }
    }
}
