import UIKit
import DesignSystem
import VoxelSettings

class TabBarController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        setupViewControllers()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: false)
    }
    
    private func setupUI() {
        view.backgroundColor = .background
        tabBar.barTintColor = .background
        tabBar.tintColor = .accent
    }
    
    private func setupViewControllers() {
        let chats = UIViewController()
        chats.tabBarItem = Tab.chats.tabBarItem
        
        let contacts = UIViewController()
        contacts.tabBarItem = Tab.contacts.tabBarItem
        
        let calls = UIViewController()
        calls.tabBarItem = Tab.calls.tabBarItem
        
        let settings = SettingsViewController()
        let settingsNavContr = UINavigationController(rootViewController: settings)
        settings.tabBarItem = Tab.settings.tabBarItem
        settings.title = Tab.settings.tabBarItem.title
        
        viewControllers = [
            contacts,
            calls,
            chats,
            settingsNavContr]
        
        selectedViewController = settingsNavContr
    }
    
}
