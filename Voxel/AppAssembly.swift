import Foundation
import Swinject
import VoxelSettings
import VoxelAuthentication
import VoxelLogin

class AppAssembly {
    
    let container: Container
    
    init(container: Container) {
        self.container = container
    }
    
    func asemble() {
        let authService = AuthServiceLive()
        let userRepository = UserProfileRepositoryLive(authService: authService)
        let profilePictureRepository = ProfilePictureRepositoryLive(
            authService: authService,
            userProfileRepository: userRepository
        )
        container.register(AuthService.self) { container in
            return authService
        }
        
        container.register(UserProfileRepository.self) { container in
            return userRepository
        }
        
        container.register(ProfilePictureRepository.self) { container in
            return profilePictureRepository
        }
    }
}
