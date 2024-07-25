import UIKit

public enum Fonts: String {
    
    case ibmPlexSerifBold = "IBMPlexSerif-Bold"
    case iBMPlexSansRegular = "IBMPlexSans-Regular"
    case iBMPlexSansSemiBold = "IBMPlexSans-SemiBold"
}

public extension UIFont {
    static var title: UIFont {
        UIFont(name: Fonts.ibmPlexSerifBold.rawValue, size: 34)!
    }
    
    static var subtitle: UIFont {
        UIFont(name: Fonts.iBMPlexSansRegular.rawValue, size: 17)!
    }
    
    static var title2: UIFont {
        UIFont(name: Fonts.iBMPlexSansSemiBold.rawValue, size: 17)!
    }
    
    static var subtitle2: UIFont {
        UIFont(name: Fonts.iBMPlexSansRegular.rawValue, size: 15)!
    }
    
    static var title3: UIFont {
        UIFont(name: Fonts.iBMPlexSansSemiBold.rawValue, size: 13)!
    }
    
    static var textField: UIFont {
        UIFont(name: Fonts.iBMPlexSansRegular.rawValue, size: 17)!
    }
    
    static var paragraph: UIFont {
        UIFont(name: Fonts.iBMPlexSansRegular.rawValue, size: 17)!
    }
    
    static var footer: UIFont {
        UIFont(name: Fonts.iBMPlexSansRegular.rawValue, size: 13)!
    }
    
    static var button: UIFont {
        UIFont(name: Fonts.iBMPlexSansSemiBold.rawValue, size: 17)!
    }
    
    static var otp: UIFont {
        UIFont(name: Fonts.iBMPlexSansSemiBold.rawValue, size: 17)!
    }
}
