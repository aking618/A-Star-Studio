//
//  GridBoxType.swift
//  A-Star Studio
//
//  Created by Ayren King on 2/27/24.
//

import Foundation
import SwiftUI

enum GridBoxType {
    case start
    case end
    case obstacle
    case none
    
    @ViewBuilder var icon: some View {
        switch self {
        case .start:
            Image(systemName: EditMode.startPoint.systemImage)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .foregroundStyle(.black)
                .bold()
        case .end:
            Image(systemName: EditMode.endPoint.systemImage)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .foregroundStyle(.black)
                .bold()
        case .obstacle:
            Image(systemName: EditMode.obstacle.systemImage)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .foregroundStyle(.red)
                .bold()
        case .none:
            EmptyView()
        }
    }
}
