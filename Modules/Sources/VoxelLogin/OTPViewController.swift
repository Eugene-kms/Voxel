import UIKit
import SnapKit

enum OTPScreenStrings: String {
    case title = "Enter the code"
    case subtitle = "Enter the code we sent to"
    case continueButton = "Continue"
}

//OTP - One Time Password
public final class OTPViewController: UIViewController {
    
    private weak var stackView: UIStackView!
    private weak var continueButton: UIButton!
    private var textFields: [UITextField] = []
    
    var phoneNumber: String = ""
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        
        continueButton.alpha = 0.5
        
        textFields.first?.becomeFirstResponder()
    }
}

extension OTPViewController {
    
    private func setupUI() {
        
        view.backgroundColor = .background
        
        setupStackView()
        setupIcon()
        setupTitle()
        setupSubtitle()
        setupOTPTextField()
        setupContinueButton()
    }
    
    private func setupStackView() {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.alignment = .center
        stackView.spacing = 24
        view.addSubview(stackView)
        
        stackView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(8)
            make.left.equalToSuperview().offset(16)
            make.right.equalToSuperview().offset(-16)
        }
        
        self.stackView = stackView
    }
    
    private func setupIcon() {
        let icon = UIImageView()
        icon.contentMode = .scaleAspectFit
        icon.image = UIImage(resource: .mobileOtp)
        
        stackView.addArrangedSubview(icon)
        
        icon.snp.makeConstraints { make in
            make.size.equalTo(80)
        }
    }
    
    private func setupTitle() {
        let title = UILabel()
        
        let attributedString = NSAttributedString(
            string: OTPScreenStrings.title.rawValue,
            attributes: [
                .kern: 0.37,
                .paragraphStyle: UIFont.title.paragraphStyle(forLineHight: 41)])
        
        title.attributedText = attributedString
        title.font = .title
        title.numberOfLines = 0
        title.textAlignment = .center
        title.textColor = .text
        
        stackView.addArrangedSubview(title)
    }
    
    private func setupSubtitle() {
        let subtitle = UILabel()
        
        let attributedString = NSAttributedString(
            string: OTPScreenStrings.subtitle.rawValue + "\n" + phoneNumber,
            attributes: [.kern: -0.41])
        
        subtitle.attributedText = attributedString
        subtitle.font = .subtitle
        subtitle.numberOfLines = 0
        subtitle.textAlignment = .center
        subtitle.textColor = .text
        
        stackView.addArrangedSubview(subtitle)
    }
    
    private func setupOTPTextField() {
        
        var fields = [UITextField]()
        
        let fieldsStackView = UIStackView()
        fieldsStackView.axis = .horizontal
        fieldsStackView.spacing = 16
        fieldsStackView.alignment = .center
        
        for index in 0...5 {
            let background = UIView()
            background.backgroundColor = .white
            background.layer.cornerRadius = 8
            background.layer.masksToBounds = true
            
            let textField = UITextField()
            textField.textAlignment = .center
            textField.textColor = .textGray
            textField.font = .otp
            textField.keyboardType = .numberPad
            textField.addTarget(self, action: #selector(didChangeText), for: .editingChanged)
            textField.tag = 100 + index
            
            background.addSubview(textField)
            
            background.snp.makeConstraints { make in
                make.height.equalTo(44)
                make.width.equalTo(34)
            }
            
            textField.snp.makeConstraints { make in
                make.edges.equalToSuperview()
            }
            
            fieldsStackView.addArrangedSubview(background)
            fields.append(textField)
        }
        
        stackView.addArrangedSubview(fieldsStackView)
        
        textFields = fields
    }
    
    private func setupContinueButton() {
        let button = UIButton()
        button.backgroundColor = .accent
        button.titleLabel?.font = .button
        button.setTitle(OTPScreenStrings.continueButton.rawValue, for: .normal)
        button.layer.cornerRadius = 8
        button.layer.masksToBounds = true
        button.addTarget(self, action: #selector(didTapContinue), for: .touchUpInside)
        
        stackView.addArrangedSubview(button)
        
        button.snp.makeConstraints { make in
            make.height.equalTo(44)
            make.width.equalToSuperview()
        }
        
        self.continueButton = button
    }
}

extension OTPViewController {
    
    @objc func didChangeText(textField: UITextField) {
        let index = textField.tag - 100
        
        let nextIndex = index + 1
        
        guard nextIndex < textFields.count else {
            print("Execute authentication")
            continueButton.alpha = 1.0
            return
        }
        
        textFields[nextIndex].becomeFirstResponder()
        
    }
}

extension OTPViewController {
    
    @objc func didTapContinue() {
        print("Did tap continue!")
    }
}
