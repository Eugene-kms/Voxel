import UIKit

public enum Fonts: String {
    
    case ibmPlexSerifBold = "IBMPlexSerif-Bold"
    case iBMPlexSansRegular = "IBMPlexSans-Regular"
    
}

public extension UIFont {
    static var title: UIFont {
        UIFont(name: Fonts.ibmPlexSerifBold.rawValue, size: 34)!
    }
    
    static var subtitle: UIFont {
        UIFont(name: Fonts.iBMPlexSansRegular.rawValue, size: 17)!
    }
}
