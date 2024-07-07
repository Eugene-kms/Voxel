import UIKit
import SnapKit
import DesignSystem

enum PhoneNumberStrings: String {
    case title = "Enter your phone number"
    case subtitle = "What a phone number can people use to reach you?"
}

public class PhoneNumberViewController: UIViewController {
    
    private weak var stackView: UIStackView!
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
    }
    
    private func setupUI() {
        
        view.backgroundColor = UIColor(resource: .background)
        
        setupStackView()
        setupIcon()
        setupTitle()
        setupSubtitle()
    }
    
    private func setupStackView() {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.alignment = .center
        stackView.spacing = 24
        view.addSubview(stackView)
        
        stackView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(52)
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
            attributes: [.kern: 0.37])
        
        title.attributedText = attributedString
        title.font = .title
        title.numberOfLines = 0
        title.textAlignment = .center
        
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
        
        stackView.addArrangedSubview(subtitle)
    }
    
}
