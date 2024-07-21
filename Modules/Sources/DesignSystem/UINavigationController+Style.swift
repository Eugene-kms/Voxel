import UIKit

public extension UINavigationController {
    func styleVoxel() {
        navigationBar.tintColor = .accent
        
        let imgBack = UIImage(resource: .chevronLeft)

        navigationBar.backIndicatorImage = imgBack
        navigationBar.backIndicatorTransitionMaskImage = imgBack
        
        navigationBar.topItem?.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: self, action: nil)
    }
}
