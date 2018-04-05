import SpriteKit

public class Simulation {
    public var tick = 0
    weak var sceneView:SKView?
    weak var delegate:SimulationDelegate?
    public var agents = [SchellingAgent]()
    public var world:Grid
    public var parameters:Parameters
    public var isPaused:Bool = true {
        didSet {
            sceneView?.scene?.isPaused = isPaused
        }
    }
    public var timeLimit = 10000
    
    // MARK: - Initializers & Setup
    
    public init(sceneView:SKView) {
        self.parameters = Parameters.standardParameters
        self.sceneView = sceneView
        let nCol = Int(sceneView.frame.width / CGFloat(30))
        let nRows = Int(sceneView.frame.height / CGFloat(30))
        world = Grid(nRows, nCol, sceneView)
    }
    
    public init(parameters:Parameters, sceneView:SKView){
        self.parameters = parameters
        self.sceneView = sceneView
        let nCol = Int(sceneView.frame.width / CGFloat(30))
        let nRows = Int(sceneView.frame.height / CGFloat(30))
        world = Grid(nRows, nCol, sceneView)
    }
    
    public func setup() {
        let numberOfAgents = Int(parameters.density * Double(world.columns * world.rows))
        let allowedColors = Colors.colorsArray[..<parameters.numberOfColors]
        for _ in 1...numberOfAgents {
            let randomCell = world.returnRandomEmptyCell()
            let randomColor = allowedColors[Int(arc4random_uniform(UInt32(allowedColors.endIndex)))]
            let agent = SchellingAgent(cell: randomCell, color: randomColor)
            agent.setup()
            agents.append(agent)
        }
    }
    
    //MARK: - Model logic
    
//    public func update() {
//        let unhappyAgents = agents.filter { (agent) -> Bool in
//            !(agent.isHappy(for: parameters.happinesThreshold))
//        }
//        if !isEveryOneHappy() && tick < timeLimit {
//            for agent in unhappyAgents {
//                let cell = world.returnRandomEmptyCell()
//                agent.move(to: cell)
//            }
//        }
//        tick += 1
//    }
    
    public func multiStep(speed:Int) {
        if !isEveryOneHappy() && tick < timeLimit {
            for _ in 1...speed {
                stepUpdate()
            }
        } else {
            delegate?.simulationDidEnd()
        }
    }
    
    public func stepUpdate() {
        if !isEveryOneHappy() && tick < timeLimit {
            let agent = agents[tick % agents.count]
            if agent.isHappy(for: parameters.happinesThreshold) == false {
                let cell = world.returnRandomEmptyCell()
                agent.move(to: cell)
            }
        tick += 1
        }
    }
    
    public func isEveryOneHappy() -> Bool {
        return agents.filter { (agent) -> Bool in
            !(agent.isHappy(for: parameters.happinesThreshold))}.count == 0
    }
    
    //MARK: - Simulation controls
    
    public func reset() {
//        if isPaused == false {
//            pause()
//        }
        for cell in world.grid {
            cell.agents.removeAll()
        }
        for agent in agents {
            agent.sprite.removeFromParent()
        }
        agents.removeAll(keepingCapacity: true)
        setup()
        for agent in agents {
            sceneView?.scene?.addChild(agent.sprite)
        }
        tick = 0
        delegate?.simulationDidReset()
    }
    
    public func resetViewChange() {
        
    }
    
    public func start() {
        isPaused = false
        //sceneView?.isPaused = false
    }
    
    public func pause() {
        isPaused = true
        //sceneView?.isPaused = true
    }
}

protocol SimulationDelegate:AnyObject {
    func simulationDidEnd()
    func simulationDidReset()
}
