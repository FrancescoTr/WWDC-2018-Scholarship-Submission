import Foundation

// Generic class for a Cell

public class Cell {
    public var column:Int
    public var row:Int
    public var agents:[Agent] = []
    public weak var world:Grid?
    
    public init(_ row:Int, _ column:Int, _ world:Grid) {
        self.row = row
        self.column = column
        self.world = world
    }
    
    public func addAgent(_ agent:Agent) {
        agents.append(agent)
    }
    
    public func removeAgent(_ agent:Agent) {
        if let i = agents.index(of: agent) {
             agents.remove(at: i)
        }
    }
}
