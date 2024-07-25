import UIKit
import SnapKit
import DesignSystem

class SettingsHeaderCell: UITableViewCell {
    
    private weak var containerView: UIView!
    private weak var stackView: UIStackView!
    private weak var profileImageView: UIImageView!
    private weak var nameLable: UILabel!
    private weak var descriptionLable: UILabel!
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        commonInit()
    }
    
    func configure(with viewModel: SettingsViewModel.Header) {
        profileImageView.image = viewModel.image
        nameLable.text = viewModel.name
        descriptionLable.text = viewModel.description
    }
    
    private func commonInit() {
        setupUI()
    }
}

extension SettingsHeaderCell {
    
    private func setupUI() {
        backgroundColor = .clear
        selectionStyle = .none
        
        setupContainer()
        setupStackView()
        setupImageView()
        setupLables()
        setupIndicator()
    }
    
    private func setupContainer() {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 8
        view.layer.masksToBounds = true
        
        contentView.addSubview(view) //contentView = self
        
        self.containerView = view
        
        view.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(16)
            make.bottom.equalToSuperview()
            make.left.equalToSuperview()
            make.right.equalToSuperview()
        }
    }
    
    private func setupStackView() {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.alignment = .center
        stackView.spacing = 12
        
        containerView.addSubview(stackView)
        
        self.stackView = stackView
        
        stackView.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(16)
            make.right.equalToSuperview().offset(-8)
            make.top.equalToSuperview().offset(12)
            make.bottom.equalToSuperview().offset(-12)
        }
    }
    
    private func setupImageView() {
        let imageView = UIImageView()
        stackView.addArrangedSubview(imageView)
        
        imageView.snp.makeConstraints { make in
            make.size.equalTo(56)
        }
        
        self.profileImageView = imageView
    }
    
    private func setupLables() {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 2
        
        let nameLbl = setupNameLbl()
        stackView.addArrangedSubview(nameLbl)
        self.nameLable = nameLbl
        
        let descriptionLbl = setupDescriptionLbl()
        stackView.addArrangedSubview(descriptionLbl)
        self.descriptionLable = descriptionLbl
        
        self.stackView.addArrangedSubview(stackView)
    }
    
    private func setupNameLbl() -> UILabel {
        let nameLbl = UILabel()
        nameLbl.font = .title2
        nameLbl.textColor = .black
        return nameLbl
    }
    
    private func setupDescriptionLbl() -> UILabel {
        let descriptionLbl = UILabel()
        descriptionLbl.font = .subtitle2
        descriptionLbl.textColor = .textGray
        return descriptionLbl
    }
    
    private func setupIndicator() {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.image = .indicator
        
        stackView.addArrangedSubview(imageView)
        
        imageView.snp.makeConstraints { make in
            make.size.equalTo(24)
        }
    }
}