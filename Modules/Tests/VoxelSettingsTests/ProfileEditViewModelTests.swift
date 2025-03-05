import XCTest
import Swinject
import VoxelAuthentication
import VoxelCore
import VoxelMocks
@testable import VoxelSettings

class ProfileEditCoordinatorMock: ProfileEditCoordinator {
    var didDismiss: Int = 0
    
    func start() {}
    
    func dismiss() {
        didDismiss += 1
    }
}

class ProfilePictureRepositoryMock: ProfilePictureRepository {
    var didUpload: [UIImage] = []
    
    func upload(_ image: UIImage) async throws {
        didUpload.append(image)
    }
}

class ProfileViewModelTests: XCTestCase {
    
    private var viewModel: ProfileEditViewModel!
    private var container: Container!
    private var coordinator: ProfileEditCoordinatorMock!
    private var repository: UserProfileRepositoryMock!
    private var profilePictureRepository: ProfilePictureRepositoryMock!
    private var authService: AuthServiceMock!
    
    override func setUp() {
        
        container = Container()
        coordinator = ProfileEditCoordinatorMock()
        repository = UserProfileRepositoryMock()
        profilePictureRepository = ProfilePictureRepositoryMock()
        authService = AuthServiceMock()
        
        container.register(AuthService.self) { _ in
            self.authService
        }
        
        container.register(ProfilePictureRepository.self) { _ in
            self.profilePictureRepository
        }
        
        container.register(UserProfileRepository.self) { _ in
            self.repository
        }
        
        viewModel = ProfileEditViewModel(
            container: container,
            coordinator: coordinator
        )
    }
    
    func test_whenInitAndProfileAvailable_thenShouldUpdateSelf() {
        //given
        repository.profile = UserProfile(fullName: "Alex", description: "Developer")
        
        //when
        viewModel = ProfileEditViewModel(
            container: container,
            coordinator: coordinator
        )
        
        //then
        XCTAssertEqual(viewModel.fullName, "Alex")
        XCTAssertEqual(viewModel.description, "Developer")
    }
    
    func test_whenSave_thenShouldUseRepository() async throws {
        //given
        viewModel.fullName = "Alex"
        viewModel.description = "Developer"
        
        //when
        try await viewModel.save()
        
        //then
        XCTAssertEqual(repository.didSaveUserProfile.count, 1)
        XCTAssertEqual(repository.didSaveUserProfile[0].fullName, "Alex")
        XCTAssertEqual(repository.didSaveUserProfile[0].description, "Developer")
    }
    
    func test_whenSaveWithSelectedImage_thenShouldUploadProfilePicture() async throws {
        //given
        let selectedImage = UIImage()
        viewModel.selectedImage = selectedImage
        
        //when
        try await viewModel.save()
        
        //then
        XCTAssertEqual(profilePictureRepository.didUpload.count, 1)
        XCTAssertEqual(profilePictureRepository.didUpload[0], selectedImage)
    }
    
    func test_whenSaveSucceeds_thenShouldDismiss() async throws {
        //given
        viewModel.fullName = "Alex"
        viewModel.description = "Developer"
        
        //when
        try await viewModel.save()
        
        //then
        XCTAssertEqual(coordinator.didDismiss, 1)
    }
    
    func test_whenLogout_thenShouldLogoutWuthAuthService() throws {
        //when
        try viewModel.logout()
        
        //then
        XCTAssertEqual(authService.didLogout, 1)
    }
    
    func test_whenLogout_thenShouldPostDidLogoutNotification() async throws {
        //given
        let expectation = expectation(forNotification: Notification.Name(AppNotification.didLogout.rawValue), object: nil)
        
        //when
        try viewModel.logout()
        
        //then
        await fulfillment(of: [expectation])
    }
}
