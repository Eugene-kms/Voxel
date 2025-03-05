import XCTest
import Swinject
import VoxelAuthentication
import VoxelMocks
@testable import VoxelLogin

class OTPViewModelTests: XCTestCase {
    
    private var viewModel: OTPViewModel!
    private var container: Container!
    private var authService: AuthServiceMock!
    private let phoneNumber: String = "+380988888888"
    
    override func setUp() {
        
        container = Container()
        authService = AuthServiceMock()
        
        container.register(AuthService.self) { _ in
            self.authService
        }
        
        viewModel = OTPViewModel(
            container: container,
            phoneNumber: phoneNumber
        )
    }
    
    func test_whenVerifyOTPWithWrongInput_thenItShouldFail() async throws {
        //given
        let wrongInput = ["a", "abc"]
        
        //when
        do {
            try await viewModel.verifyOTP(with: wrongInput)
            XCTFail("Should throw an error")
        } catch {
            //then
            switch error {
            case OTPViewModelError.otpNoValid:
                break
            default:
                XCTFail("It should throws OTPViewModelError")
            }
        }
    }
    
    func test_whenVerifyOTPWithShortInput_thenShouldFail() async {
        //given
        let invalidInput = ["8", "8", "8", "8", "8"]
        
        //when
        do {
            try await viewModel.verifyOTP(with: invalidInput)
            XCTFail("Should throw an error")
        } catch {
            //then
            switch error {
            case OTPViewModelError.otpNoValid:
                break
            default:
                XCTFail("It should throws OTPViewModelError")
            }
        }
    }
    
    func test_whenVerifyOTPWithVaildInput_thenAuthenticateWithAuthService() async throws {
        //given
        let validInput = ["8", "8", "8", "8", "8", "8"]
        
        //when
        try await viewModel.verifyOTP(with: validInput)
        
        //then
        XCTAssertEqual(authService.didAuthenticate.count, 1)
        XCTAssertEqual(authService.didAuthenticate.first, "888888")
    }
}
