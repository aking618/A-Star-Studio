//
//  EditMode.swift
//  A-Star Studio
//
//  Created by Ayren King on 3/2/24.
//

import Foundation
import SwiftUI

enum EditMode: Identifiable, CaseIterable {
    case startPoint
    case endPoint
    case obstacle
    
    var id: Self { self }
    
    var title: String {
        switch self {
        case .startPoint:
            "Start Point"
        case .endPoint:
            "End Point"
        case .obstacle:
            "Obstacle"
        }
    }
    
    var systemImage: String {
        switch self {
        case .startPoint:
            "flag"
        case .endPoint:
            "flag.checkered"
        case .obstacle:
            "xmark.octagon"
        }
    }
    
    var keyboardShortcut: KeyboardShortcut {
        switch self {
        case .startPoint:
            KeyboardShortcut("1", modifiers: .numericPad)
        case .endPoint:
            KeyboardShortcut("2", modifiers: .numericPad)
        case .obstacle:
            KeyboardShortcut("3", modifiers: .numericPad)
        }
    }
}
