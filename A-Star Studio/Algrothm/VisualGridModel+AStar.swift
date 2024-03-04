//
//  VisualGridModel+AStar.swift
//  A-Star Studio
//
//  Created by Ayren King on 2/27/24.
//

import Foundation
import RoyalSwift

extension VisualGridModel {
    public func aStarDistance(
        allowDiagonals: Bool = false,
        delay: Duration? = nil
    ) async -> [CGPoint]? {
        guard let startPoint, let endPoint else { return nil }
        
        await reset()
        
        let startNode = Node(parent: nil, point: startPoint.point)
        let endNode = Node(parent: nil, point: endPoint.point)

        var openList: [Node] = [startNode]
        var closedList: [Node] = []

        var adjacentPositions: [CGPoint] = [.init(x: 0, y: 1), .init(x: 0, y: -1), .init(x: 1, y: 0), .init(x: -1, y: 0)]
        if allowDiagonals {
            adjacentPositions.append(contentsOf: [.init(x: -1, y: -1), .init(x: 1, y: -1), .init(x: -1, y: 1), .init(x: 1, y: 1)])
        }

        while !openList.isEmpty {
            let currentNode = openList.sorted(by: { $0.f < $1.f }).first!
            openList.remove(at: openList.firstIndex(of: currentNode)!)
            closedList.append(currentNode)

            if currentNode == endNode {
                return returnPath(from: currentNode)
            }

            var children: [Node] = []
            for adjacentPosition in adjacentPositions {
                let nodePosition: CGPoint = .init(x: currentNode.point.x + adjacentPosition.x, y: currentNode.point.y + adjacentPosition.y)

                guard Int(nodePosition.x) < values.count &&
                    nodePosition.x >= 0 &&
                    Int(nodePosition.y) < values.first!.count &&
                    nodePosition.y >= 0
                else {
                    continue
                }
                
                guard values[Int(nodePosition.x)][Int(nodePosition.y)].type != .obstacle else { continue }

                let newNode = Node(parent: currentNode, point: nodePosition)
                children.append(newNode)
            }

            for (childIndex, _) in children.enumerated() {
                guard !closedList.contains(children[childIndex]) else { continue }
                let point = children[childIndex].point

                children[childIndex].g = currentNode.g + 1
                children[childIndex].h = (Int(point.x) - Int(endNode.point.x)).squared + (Int(point.y) - Int(endNode.point.y)).squared
                children[childIndex].f = children[childIndex].g + children[childIndex].h
                
                let child = children[childIndex]
                await MainActor.run { values[Int(child.point.x)][Int(child.point.y)].value = Int(Double(child.f) * 0.5) }
                
                if let delay {
                    try? await Task.sleep(for: delay)
                }

                guard !openList.contains(children[childIndex]) else { continue }

                openList.append(children[childIndex])
            }
        }

        return nil
    }
    
    private func returnPath(from start: Node) -> [CGPoint] {
        var path: [CGPoint] = []
        var current: Node? = start
        while current != nil {
            path.append(current!.point)
            current = current?.parent
        }
        return path
    }
}
