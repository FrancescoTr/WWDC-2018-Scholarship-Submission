import UIKit
import SpriteKit

// Generic class for a grid

public class Grid {
    public var rows:Int
    public var columns:Int
    public var grid:[Cell] = []
    public lazy var gridNode:SKTileMapNode = SKTileMapNode()
    
    public init(_ rows:Int, _ columns:Int, _ sceneView:SKView) {
        self.rows = rows
        self.columns = columns
        for r in 0..<rows {
            for c in 0..<columns {
                grid.append(Cell(r,c,self))
            }
        }
       gridNode = returnGridNode(sceneView)
    }
    
    // MARK: - Return the 8 neighbors of a cell
    
    public func returnNeighbors(of cell:Cell) -> [Cell] {
        var neighbors = [Cell]()
        let cellRow = cell.row
        let cellColumn = cell.column
        for rowOffset in [-1,0,1] {
            for colOffset in [-1,0,1] {
                if indexIsValid(row: cellRow + rowOffset, column: cellColumn + colOffset) && !(cellRow + rowOffset == cellRow && cellColumn + colOffset == cellColumn){
                    neighbors.append(self[cellRow + rowOffset, cellColumn + colOffset])
                }
            }
            
        }
        return neighbors
    }
    
    // MARK: - Return a SKTileMapNode to draw the grid in a SKScene
    
    public func returnGridNode(_ sceneView:SKView) -> SKTileMapNode {
        let width = (sceneView.frame.width) / CGFloat(columns)
        let height = (sceneView.frame.height) / CGFloat(rows)
//        let size = min(width,height)
        let cellSize = CGSize(width: width, height: height)
        let node = SKShapeNode(rectOf: cellSize, cornerRadius: 5)
        node.fillColor = UIColor.black
        node.strokeColor = UIColor.lightGray
        node.lineWidth = 3
        let cellTexture = sceneView.texture(from: node)
        let tileSetDefinition = SKTileDefinition(texture: cellTexture!)
        let tileGroup = SKTileGroup(tileDefinition: tileSetDefinition)
        let tileSet = SKTileSet(tileGroups: [tileGroup])
        let gridNode = SKTileMapNode(tileSet: tileSet, columns: columns, rows: rows, tileSize: cellSize, fillWith: tileGroup)
        gridNode.anchorPoint = CGPoint.zero
        gridNode.zPosition = 1
        gridNode.name = "grid"
        return gridNode
    }
    
    // MARK: - Random cell methods
    
    public func returnRandomCell() -> Cell {
        let randomRow = Int(arc4random_uniform(UInt32(rows)))
        let randomCol = Int(arc4random_uniform(UInt32(columns)))
        return self[randomRow,randomCol]
    }
    
    public func returnRandomEmptyCell() -> Cell {
        var cell = returnRandomCell()
        var isEmpty = cell.agents.isEmpty
        while isEmpty == false {
            cell = returnRandomCell()
            isEmpty = cell.agents.isEmpty
        }
        return cell
    }
    
    // MARK: - Convenience methods to manage a matrix
    
    func indexIsValid(row: Int, column: Int) -> Bool {
        return row >= 0 && row < rows && column >= 0 && column < columns
    }
    
    public subscript(row: Int, column: Int) -> Cell {
        get {
            assert(indexIsValid(row: row, column: column), "Index out of range")
            return grid[(row * columns) + column]
        }
        set {
            assert(indexIsValid(row: row, column: column), "Index out of range")
            grid[(row * columns) + column] = newValue
        }
    }
}
