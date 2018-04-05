import UIKit
import SpriteKit

public class RulesViewController:UIViewController {
    var world:Grid!
    var sceneView = SKView(frame: CGRect(x:0 , y:0, width: 768, height: 1024))
    let cellSize = CGFloat(30)
    var agents = [SchellingAgent]()
    let threshold = 0.3
    override public func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white
        view.addSubview(sceneView)
        
    }
    
    override public func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        sceneView.frame.size = view.frame.size
        if let scene = sceneView.scene {
            if let gridNode = scene.childNode(withName: "grid") {
                gridNode.removeFromParent()
            }
            setGridNode()
            scene.addChild(world.returnGridNode(sceneView))
        } else {
            let scene = SKScene(size: sceneView.frame.size)
            scene.scaleMode = .resizeFill
            setGridNode()
            scene.addChild(world.returnGridNode(sceneView))
            sceneView.presentScene(scene)
        }
        reset()
        setAgents()
        
    }
    
    func setGridNode() {
        let nCol = Int(floor(sceneView.frame.width / cellSize))
        let nRows = Int(floor(sceneView.frame.height / cellSize))
        world = Grid(nRows, nCol, sceneView)
    }
    
    func reset() {
        for cell in world.grid {
            cell.agents.removeAll()
        }
        for agent in agents {
            agent.sprite.removeFromParent()
        }
        agents.removeAll(keepingCapacity: true)
    }
    
    override public func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        let touch = touches.first!
        let col = world.gridNode.tileColumnIndex(fromPosition: touch.location(in: view))
        let row = world.gridNode.tileRowIndex(fromPosition: touch.location(in: view))
        let adjustedRow = (world.rows - row - 1)
        let movableAgents = agents.filter { (item) -> Bool in
            item.sprite.name == "rulesSchellingAgent"
        }
        if let agent = movableAgents.first {
            if world.indexIsValid(row: adjustedRow, column: col) {
                let cell = world[adjustedRow, col]
                if cell.agents.isEmpty {
                    agent.move(to: cell)
                    (agent as! RulesSchellingAgent).showHappiness(for: threshold)
                }
            }
        }
    }
    
    func setAgents() {
        let unHappyNeigborhoodCoord = [world.rows - 4, 3]
        let happyNeigborhoodCoord = [3, world.columns - 4]
        let otherNeighborhood = [(unHappyNeigborhoodCoord[0], happyNeigborhoodCoord[1]), (unHappyNeigborhoodCoord[1], happyNeigborhoodCoord[0])]
        let allowedColors = Array(Colors.colorsArray[2...3])
        if world.indexIsValid(row: unHappyNeigborhoodCoord[0], column: unHappyNeigborhoodCoord[1]) {
            let centerCell = world[unHappyNeigborhoodCoord[0], unHappyNeigborhoodCoord[1]]
            let smileAgent = RulesSchellingAgent(cell: centerCell, color: .red)
            smileAgent.setup()
            smileAgent.showHappiness(for: threshold)
            sceneView.scene?.addChild(smileAgent.sprite)
            agents.append(smileAgent)
            let neighBorsCell = world.returnNeighbors(of: centerCell)
            for (i, neighBor) in neighBorsCell.enumerated() {
                let color:Colors = (i < 6) ? Colors.green : Colors.red
                let agent = SchellingAgent(cell: neighBor, color: color)
                agent.setup()
                sceneView.scene?.addChild(agent.sprite)
                agents.append(agent)
            }
        }
        if world.indexIsValid(row: happyNeigborhoodCoord[0], column: happyNeigborhoodCoord[1]) {
            let centerCell = world[happyNeigborhoodCoord[0], happyNeigborhoodCoord[1]]
            let neighBorsCell = world.returnNeighbors(of: centerCell)
            for (i, neighBor) in neighBorsCell.enumerated() {
                let color:Colors = (i > 2) ? Colors.green : Colors.red
                let agent = SchellingAgent(cell: neighBor, color: color)
                agent.setup()
                sceneView.scene?.addChild(agent.sprite)
                agents.append(agent)
            }
        }
        
        for (row, col) in otherNeighborhood {
            if world.indexIsValid(row: row, column: col) {
                let centerCell = world[row, col]
                let neighBorsCell = world.returnNeighbors(of: centerCell)
                print(row)
                print(col)
                for neighBor in neighBorsCell {
                    let randomColor = allowedColors[Int(arc4random_uniform(UInt32(allowedColors.count)))]
                    let agent = SchellingAgent(cell: neighBor, color: randomColor)
                    agent.setup()
                    sceneView.scene?.addChild(agent.sprite)
                    agents.append(agent)
                }
            }
        }
    }
}

class RulesSchellingAgent:SchellingAgent {
    var happySprite:SKSpriteNode
    var unHappySprite:SKSpriteNode
    
    override init(cell: Cell, color: Colors) {
        switch color {
        case .red:
            happySprite = SKSpriteNode(imageNamed: "HappyRed")
            unHappySprite = SKSpriteNode(imageNamed: "unHappyRed")
        case .green:
            happySprite = SKSpriteNode(imageNamed: "HappyGreen")
            unHappySprite = SKSpriteNode(imageNamed: "unHappyGreen")
        default:
            happySprite = SKSpriteNode(imageNamed: "HappyRed")
            unHappySprite = SKSpriteNode(imageNamed: "unHappyRed")
        }
        super.init(cell: cell, color: color)
    }
    
    override public func setup() {
        super.setup()
        //happySprite.position = sprite.position
        sprite.name = "rulesSchellingAgent"
        happySprite.scale(to: sprite.size)
        happySprite.zPosition = sprite.zPosition
        happySprite.name = "happyAgent"
        //unHappySprite.position = sprite.position
        unHappySprite.scale(to: sprite.size)
        unHappySprite.zPosition = sprite.zPosition
        unHappySprite.name = "unHappyAgent"
    }
    
    public func showHappiness(for threshold:Double) {
        if self.isHappy(for: threshold) {
            self.sprite.texture = happySprite.texture
        } else {
            self.sprite.texture = unHappySprite.texture
        }
    }
}
