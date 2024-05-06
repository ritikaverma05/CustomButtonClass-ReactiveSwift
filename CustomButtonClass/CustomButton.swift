//
//  CustomButton.swift
//  CustomButtonClass
//
//  Created by Ritika Verma on 06/12/23.
//

import UIKit
import ReactiveSwift

class CustomButton: UIButton {
    
    let disposable = CompositeDisposable()
    let actionSignal = Signal<Void,Never>.pipe()
    var buttonConfiguration = CustomButtonConfiguration() {
        didSet {
            applyConfiguration()
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
    }
    
    private func setup() {
        applyConfiguration()
    }
    
    private func applyConfiguration() {
        var customConfiguration = UIButton.Configuration.plain()
        customConfiguration.cornerStyle = .capsule
        customConfiguration.background.backgroundColor = buttonConfiguration.backgroundColor
        customConfiguration.showsActivityIndicator = buttonConfiguration.showsActivityIndicator
        self.configuration = customConfiguration
        
        let titleAttributes: [NSAttributedString.Key: Any] = [
            .font: buttonConfiguration.titleFont,
            .foregroundColor: buttonConfiguration.titleColor
        ]
        let attributedTitle = NSAttributedString(string: buttonConfiguration.title, attributes: titleAttributes)
        self.setAttributedTitle(attributedTitle, for: .normal)
        setImageBeforeTitle(buttonConfiguration.imageBeforeTitle)
        setImageAfterTitle(buttonConfiguration.imageAfterTitle)
        isEnabled = buttonConfiguration.isEnabled
        addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
        if buttonConfiguration.showShadow { setupShadow() }
    }
    
    @objc private func buttonTapped() {
        self.actionSignal.input.send(value: ())
    }
    
    func closeActivityIndicator() {
        self.configuration?.showsActivityIndicator = false
    }
    
    func showActivityIndicator() {
        self.configuration?.showsActivityIndicator = true
    }
    
    private func setImageBeforeTitle(_ image: UIImage?) {
        guard let image = image else { return }
        setImage(image.withRenderingMode(.alwaysOriginal), for: .normal)
        self.semanticContentAttribute = .forceLeftToRight
        self.configuration?.imagePadding = 10
        self.contentHorizontalAlignment = .center
    }
    
    private func setImageAfterTitle(_ image: UIImage?, spacing: CGFloat = 0) {
        guard let image = image else { return }
        setImage(image.withRenderingMode(.alwaysOriginal), for: .normal)
        self.semanticContentAttribute = .forceRightToLeft
        self.configuration?.imagePadding = 10
        self.contentHorizontalAlignment = .center
    }
    
    func setupShadow(color: CGColor = UIColor(red: 0.738, green: 0.738, blue: 0.738, alpha: 0.2).cgColor, size: CGSize = CGSize(width: 4.0, height: 4.0), radius: CGFloat = 1, opacity: Float = 0.2) {
        layer.shadowColor = color
        layer.shadowOffset = size
        layer.shadowRadius = radius
        layer.shadowOpacity = opacity
    }
    
    deinit {
        self.disposable.dispose()
    }
    
}

struct CustomButtonConfiguration {
    var title: String = ""
    var titleFont: UIFont = UIFont.boldSystemFont(ofSize: 18)
    var titleColor: UIColor = .black
    var backgroundColor: UIColor = .white
    var imageBeforeTitle: UIImage?
    var imageAfterTitle: UIImage?
    var isEnabled: Bool = true
    var showsActivityIndicator: Bool = false
    var showShadow: Bool = false
}
