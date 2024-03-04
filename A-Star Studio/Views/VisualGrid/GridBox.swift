//
//  GridBox.swift
//  A-Star Studio
//
//  Created by Ayren King on 2/27/24.
//

import Foundation
import SwiftUI

struct GridBox: View {
    @Environment(HomeViewModel.self) var mainModel
    @Binding var box: GridBoxValue
    
    var body: some View {
        ZStack {
            Rectangle()
                .fill(box.value > 0 ? .mint : .white)
                .hueRotation(.radians(Double(box.value)))
            
            box.type.icon
                .padding(1)
        }
        .animation(.bouncy, value: box.value)
        .onTapGesture {
            switch mainModel.editMode {
            case .startPoint:
                if box.type != .start {
                    mainModel.gridModel.resetStartPoint()
                    box.type = .start
                } else {
                    box.type = .none
                }
            case .endPoint:
                if box.type != .end {
                    mainModel.gridModel.resetEndtPoint()
                    box.type = .end
                } else {
                    box.type = .none
                }
            case .obstacle:
                box.type = box.type == .obstacle ? .none : .obstacle
            case .none:
                box.type = .none
            }
        }
    }
}
