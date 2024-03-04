//
//  VisualGrid.swift
//  A-Star Studio
//
//  Created by Ayren King on 2/25/24.
//

import SwiftUI

struct VisualGrid: View {
    @Environment(HomeViewModel.self) var model
    
    var body: some View {
        Grid {
            ForEach(model.gridModel.values, id: \.self) { rows in
                GridRow {
                    ForEach(rows) { box in
                        GridBox(box:
                            Binding(
                                get: { box },
                                set: { new in
                                    model.gridModel.values[box.point] = new
                                }
                            )
                        )
                    }
                }
            }
        }
    }
}
