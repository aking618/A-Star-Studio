//
//  GridBoxModel.swift
//  A-Star Studio
//
//  Created by Ayren King on 2/27/24.
//

import Foundation

struct GridBoxValue: Identifiable, Hashable {
    var type: GridBoxType = .none
    var point: CGPoint
    
    var value: Int = 0
    
    var id: UUID = .init()
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}

extension MutableCollection where Element == [GridBoxValue] {
    subscript(point: CGPoint) -> Element.Element {
        get {
            first(where: { $0.contains(where: { $0.point == point }) })!.filter { $0.point == point }.first!
        }
        mutating set {
            let box = first(where: { $0.contains(where: { $0.point == point }) })!.filter { $0.point == point }.first!
            self[Int(box.point.x) as! Self.Index][Int(box.point.y)] = newValue
        }
    }
}
