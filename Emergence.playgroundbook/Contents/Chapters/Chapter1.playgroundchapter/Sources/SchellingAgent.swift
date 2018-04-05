import UIKit
import SpriteKit

public class SchellingAgent:Agent {
    public var color:Colors
    
    public init(cell:Cell, color:Colors) {
        self.color = color
        super.init(cell: cell)
        self.sprite.color = color.rawValue
    }
    
    //Mark: - Check if the agent is happy
    //The agent is happy if he has at least 'threshold' percentage of similar neighbors
    
    public func isHappy(for threshold:Double) -> Bool {
        let neighbors = self.neighbors()
        if neighbors.count > 0 {
            var similar = 0
            for case let neighbor as SchellingAgent in neighbors {
                if neighbor.color == self.color {
                    similar += 1
                }
            }
            return (Double(similar) / Double(neighbors.count)) > threshold
        } else {
            return false
        }
    }
}

