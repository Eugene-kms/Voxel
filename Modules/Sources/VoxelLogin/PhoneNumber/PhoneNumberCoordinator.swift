import UIKit
import VoxelCore
import Swinject

public class PhoneNumberCoordinator: Coordinator {
    
    private let navigationController: UINavigationController
    private let container: Container
    
    public init(navigationController: UINavigationController, container: Container) {
        self.navigationController = navigationController
        self.container = container
    }
    
    public func start() {
        
        let viewModel = PhoneNumberViewModel(
            container: container,
            coordinator: self
        )
        let controller = PhoneNumberViewController()
        controller.viewModel = viewModel
        navigationController.setViewControllers([controller], animated: true)
    }
    
    func presentOTP(with phoneNumber: String) {
        
        let coordintor = OTPCoordinator(
            navigationController: navigationController,
            container: container,
            phoneNumber: phoneNumber
        )
        
        coordintor.start()
    }
}
