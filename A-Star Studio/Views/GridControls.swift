//
//  GridControls.swift
//  A-Star Studio
//
//  Created by Ayren King on 2/25/24.
//

import SwiftUI

struct GridControls: View {
    @Environment(HomeViewModel.self) var model
    
    var body: some View {
        @Bindable var model = model
        Form {
            Section("Grid Size") {
                rowSlider
                    .disabled(model.isPathfinding)
                columnSlider
                    .disabled(model.isPathfinding)
            }
            
            Toggle("Allow diagnoals", isOn: $model.allowDiagnoals)
                .padding(.bottom)
                .disabled(model.isPathfinding)
            
            Section {
                HStack {
                    ForEach(EditMode.allCases) { mode in
                        Button {
                            model.editMode = mode
                        } label: {
                            Image(systemName: mode.systemImage)
                        }
                        .scaleEffect(model.editMode == mode ? 1.2 : 1)
                        .animation(.easeOut(duration: 0.2), value: model.editMode)
                        .disabled(model.editMode == mode)
                        .padding(.horizontal, 5)
                    }
                    
                    if model.editMode != nil {
                        Button {
                            model.editMode = nil
                        } label: {
                            Image(systemName: "xmark")
                        }
                    }
                    
                    Spacer()
                    
                    HStack {
                        Button {
                            model.startPathfinding()
                        } label: {
                            Image(systemName: "play")
                                .foregroundStyle(.green)
                        }
                        .disabled(model.disableStart)
                        
                        Button {
                            model.gridModel.reset()
                        } label: {
                            Image(systemName: "arrow.circlepath")
                        }
                    }
                }
            } header: {
                Text("Grid Markers")
            } footer: {
                HStack {
                    if let mode = model.editMode {
                        Text("Selected marker: ")
                        Image(systemName: mode.systemImage)
                    } else {
                        Text("No selected marker")
                    }
                }
            }
        }
    }
    
    private var rowSlider: some View {
        VStack {
            Slider(
                value: Binding(
                    get: { Double(model.rows) },
                    set: { value in
                        model.rows = Int(value)
                        model.gridModel.resize(rows: model.rows, columns: model.columns)
                    }
                ),
                in: 5...10,
                step: 1
            ) {
                Text("Rows")
            } minimumValueLabel: {
                Text("5")
            } maximumValueLabel: {
                Text("10")
            }
            .labelsHidden()
            
            Text("Rows: \(model.rows)")
        }
    }
    
    private var columnSlider: some View {
        VStack {
            Slider(
                value: Binding(
                    get: { Double(model.columns) },
                    set: { value in
                        model.columns = Int(value)
                        model.gridModel.resize(rows: model.rows, columns: model.columns)
                    }
                ),
                in: 5...10,
                step: 1
            ) {
                Text("Columns")
            } minimumValueLabel: {
                Text("5")
            } maximumValueLabel: {
                Text("10")
            }
            .labelsHidden()
            
            Text("Columns: \(model.columns)")
        }
    }
}

#Preview {
    GridControls()
        .environment(HomeViewModel())
}
