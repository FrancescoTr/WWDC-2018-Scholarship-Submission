import Foundation

public struct Parameters {
    public var density:Double {
        didSet {
            density = checkValue(0.2, 0.95, density)
        }
    }
    public var numberOfColors:Int {
        didSet {
            numberOfColors = checkValue(2, 4, numberOfColors)
        }
    }
    public var happinesThreshold:Double {
        didSet {
            happinesThreshold = checkValue(0.05, 0.8, happinesThreshold)
        }
    }
    public var speed:Int {
        didSet {
            speed = checkValue(1, 50, speed)
        }
    }
    public static let standardParameters = Parameters(density: 0.8, numberOfColors: 2, happinesThreshold: 0.3, speed:10)
    
    public func checkValue<T:Comparable>(_ minValue:T, _ maxValue:T, _ value:T) -> T {
        return max(minValue, min(value,maxValue))
    }
}
