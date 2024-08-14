import XCTest
import Swinject
@testable import VoxelSettings

class SettingsCoordinatorMock: SettingsCoordinator {
    
    func start() {}
    
    var didPresentProfileEdit: Int = 0
    func presentProfileEdit() {
        didPresentProfileEdit += 1
    }
    
}

class SettingsViewModelTests: XCTestCase {
    
    private var viewModel: SettingsViewModel!
    private var container: Container!
    private var coordinator: SettingsCoordinatorMock!
    private var repository: UserProfileRepositoryMock!
    
    override func setUp() {
        
        container = Container()
        coordinator = SettingsCoordinatorMock()
        repository = UserProfileRepositoryMock()
        
        container.register(UserProfileRepository.self) { _ in
            self.repository
        }
        
        viewModel = SettingsViewModel(
            container: container,
            coordinator: coordinator
        )
    }
    
    func test_whenInit_thenShouldSetupHeader() {
        XCTAssertEqual(viewModel.header.name, "~")
        XCTAssertEqual(viewModel.header.description, "No description")
    }
    
    func test_whenFetchUserProfile_thenFetchFromRepository() async throws {
        //when
        try await viewModel.fetchUserProfile()
        
        //then
        XCTAssertEqual(repository.didFetchUserProfile, 1)
    }
    
    func test_whenFetchUserProfileSucceeds_thenShouldUpdateHeader() async throws {
        //when
        try await viewModel.fetchUserProfile()
        
        //then
        XCTAssertEqual(viewModel.header.name, "ALex")
        XCTAssertEqual(viewModel.header.description, "Developer")
    }
    
    func test_whenFetchUserProfileSucceeds_thenShuoldCallDidUpdateHeader() async throws {
        //given
        let expectation = expectation(description: "didCallCallback")
        viewModel.didUpdateHeader = {
            expectation.fulfill()
        }
        
        //when
        try await viewModel.fetchUserProfile()
        
        //then
        await fulfillment(of: [expectation])
    }
}
