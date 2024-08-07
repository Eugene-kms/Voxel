import UIKit
import PhoneNumberKit
import SnapKit
import DesignSystem

enum PhoneNumberStrings: String {
    case title = "Enter your phone number"
    case subtitle = "What a phone number can people use to reach you?"
    case continueButton = "Continue"
}

public class PhoneNumberViewController: UIViewController {
    
    private weak var stackView: UIStackView!
    private weak var textField: PhoneNumberTextField!
    private weak var continueButton: UIButton!
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        subscribeToTextChange()
        textFieldDidChange()
        
        textField.becomeFirstResponder()
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    private func subscribeToTextChange() {
        
        NotificationCenter.default.addObserver(self, selector: #selector(textFieldDidChange), name: UITextField.textDidChangeNotification, object: self)
    }
    
    private func setupUI() {
        
        view.backgroundColor = UIColor(resource: .background)
        
        setupStackView()
        setupIcon()
        setupTitle()
        setupSubtitle()
        setupTextField()
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
        icon.image = UIImage(resource: .mobileEditPen)
        
        stackView.addArrangedSubview(icon)
        
        icon.snp.makeConstraints { make in
            make.size.equalTo(80)
        }
    }
    
    private func setupTitle() {
        let title = UILabel()
        
        let attributedString = NSAttributedString(
            string: PhoneNumberStrings.title.rawValue,
            attributes: [
                .kern: 0.37,
                .paragraphStyle: UIFont.title.paragraphStyle(forLineHight: 41)])
        
        title.attributedText = attributedString
        title.font = .title
        title.numberOfLines = 0
        title.textAlignment = .center
        title.textColor = UIColor(resource: .text)
        
        stackView.addArrangedSubview(title)
    }
    
    private func setupSubtitle() {
        let subtitle = UILabel()
        let attributedString = NSAttributedString(
            string: PhoneNumberStrings.subtitle.rawValue,
            attributes: [.kern: -0.41])
        
        subtitle.attributedText = attributedString
        subtitle.font = .subtitle
        subtitle.numberOfLines = 0
        subtitle.textAlignment = .center
        subtitle.textColor = UIColor(resource: .text)
        
        stackView.addArrangedSubview(subtitle)
    }
    
    private func setupTextField() {
        
        let textFieldBackground = UIView()
        textFieldBackground.layer.cornerRadius = 8
        textFieldBackground.layer.masksToBounds = true
        textFieldBackground.backgroundColor = .white
        
        stackView.addArrangedSubview(textFieldBackground)
        
        textFieldBackground.snp.makeConstraints { make in
            make.width.equalToSuperview()
            make.height.equalTo(44)
        }
        
        let textField = PhoneNumberTextField(
            insets: UIEdgeInsets(top: 10, left: 8, bottom: 10, right: 8), clearButtonPadding: 0)
            
        textField.addTarget(self, action: #selector(textFieldDidChange), for: .editingChanged)
        textField.withFlag = true
        textField.font = .textField
        textField.textColor = UIColor(resource: .text)
        textField.withExamplePlaceholder = true
        textField.attributedPlaceholder = NSAttributedString(string: "Enter phone number")
        
        textFieldBackground.addSubview(textField)
        
        textField.snp.makeConstraints { make in
            make.left.equalTo(16)
            make.right.equalTo(-16)
            make.centerY.equalToSuperview()
        }
        
        self.textField = textField
    }
    
    private func setupContinueButton() {
        let button = UIButton()
        button.backgroundColor = UIColor(resource: .accent)
        button.titleLabel?.font = .button
        button.setTitle(PhoneNumberStrings.continueButton.rawValue, for: .normal)
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

extension PhoneNumberViewController {
    
    @objc func textFieldDidChange() {
        continueButton.isEnabled = textField.isValidNumber
        continueButton.alpha = textField.isValidNumber ? 1.0 : 0.25
    }
}

extension PhoneNumberViewController {
    
    @objc func didTapContinue() {
        print("Did tap continue!")
    }
}


