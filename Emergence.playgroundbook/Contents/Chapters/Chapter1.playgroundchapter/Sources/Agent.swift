import UIKit
import SpriteKit

// Generic class for an agent

public class Agent {
    public weak var cell:Cell?
    public var sprite:SKSpriteNode
    static let defaultSpriteSize = CGSize(width: 15, height: 15)
    
    
    public convenience init(cell: Cell, sprite:SKSpriteNode) {
        self.init(cell: cell)
        self.sprite = sprite
    }
    
    public init(cell:Cell) {
        self.cell = cell
        var size = cell.world?.gridNode.tileSize ?? Agent.defaultSpriteSize
        size = size * 0.95
        self.sprite = SKSpriteNode(color: UIColor.red, size: size)
        cell.addAgent(self)
    }
    
    // MARK: - Return the agent's neighbors
    
    public func neighbors() -> [Agent] {
        var neighbors = [Agent]()
        guard let cell = cell else {return neighbors}
        let neighborsCells = cell.world!.returnNeighbors(of: cell)
        for cell in neighborsCells {
            neighbors.append(contentsOf: cell.agents)
        }
        return neighbors
    }
    
    // MARK: - Sprite setup
    
    public func setup() {
        if let cell = self.cell {
            sprite.position = getCenterOfCell(cell)
        }
        sprite.zPosition = 100
        sprite.name = "agent"
    }
    
    // MARK: - Agent movement
    
    public func move(to cell:Cell) {
        sprite.position = getCenterOfCell(cell)
        if let originCell = self.cell {
            originCell.removeAgent(self)
        }
        cell.addAgent(self)
        self.cell = cell
    }
    
    public func getCenterOfCell(_ cell:Cell) -> CGPoint {
        if let world = cell.world {
            let position = world.gridNode.centerOfTile(atColumn: cell.column, row: cell.row)
            let cellSize = world.gridNode.tileSize
            let cellTextureSize = world.gridNode.tileDefinition(atColumn: cell.column, row: cell.row)?.textures.first?.size()
            let difference = cellTextureSize! - cellSize
            return position + CGPoint(x: difference.width / 2, y: difference.height / 2)
        }
        return CGPoint.zero
    }
}

extension Agent: Equatable {
    public static func == (lhs: Agent, rhs: Agent) -> Bool {
        return lhs === rhs
    }
}

