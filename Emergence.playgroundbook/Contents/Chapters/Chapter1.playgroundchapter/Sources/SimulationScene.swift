import SpriteKit

public class SimulationScene:SKScene {
    public var simulation:Simulation
    
    //MARK: - Initializers
    public init(size:CGSize, simulation:Simulation) {
        self.simulation = simulation
        super.init(size: size)
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override public func didMove(to view: SKView) {
        addChild(simulation.world.gridNode)
        for agent in simulation.agents {
            addChild(agent.sprite)
        }
        self.isPaused = true
    }
    
    override public func didChangeSize(_ oldSize: CGSize) {
        super.didChangeSize(oldSize)
        print(oldSize)
    }
    
    override public func update(_ currentTime: TimeInterval) {
        let speed = (currentTime == 0) ? 1 : simulation.parameters.speed
        simulation.multiStep(speed: speed)
        
    }
}

