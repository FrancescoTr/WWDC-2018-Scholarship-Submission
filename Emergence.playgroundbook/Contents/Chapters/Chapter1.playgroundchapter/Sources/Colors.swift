import UIKit

public enum Colors:String {
    case red = "Red"
    case green
    case blue
    case yellow
    
    public static let colorsArray = [blue, yellow, red, green]
}


extension Colors:RawRepresentable {
    
    public typealias RawValue = UIColor
    
    public init?(rawValue:RawValue) {
        switch rawValue {
        case UIColor.red:
            self = .red
        case UIColor.green:
            self = .green
        case UIColor.yellow:
            self = .yellow
        case UIColor.blue:
            self = .blue
        default:
            return nil
        }
    }
    
    public var rawValue:RawValue {
        switch self {
        case .red:
            return UIColor.red
        case .green:
            return UIColor.green
        case .yellow:
            return UIColor.yellow
        case .blue:
            return UIColor.blue
        }
    }
}
