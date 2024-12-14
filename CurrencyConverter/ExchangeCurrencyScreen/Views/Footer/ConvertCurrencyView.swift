//
//  ConvertCurrencyView.swift
//  CurrencyConverter
//
//  Created by Ice on 14.12.2024.
//

import UIKit

fileprivate struct Styles {
    struct Color {
        static let backgroundColor = UIColor.AppColor.whiteColor
        static let dividerColor = UIColor.AppColor.hawkesBlue
        static let convertButtonColor = UIColor.AppColor.royalBlueColor
    }
    
    struct Text {
        static let viewTitle = "Convert"
    }
}

fileprivate final class ConvertButton: UIButton {
    var handleButtonClickAction: (() -> ())?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        buttonScaleAnimation()
        handleButtonClickAction?()
        super.touchesBegan(touches, with: event)
    }
    
    private func initUI() {
        translatesAutoresizingMaskIntoConstraints = false
        backgroundColor = Styles.Color.convertButtonColor
        layer.cornerRadius = 12
    
        var configuration = UIButton.Configuration.filled()
        configuration.title = Styles.Text.viewTitle.uppercased()
        configuration.baseForegroundColor = Styles.Color.backgroundColor
        
        configuration.titleTextAttributesTransformer = UIConfigurationTextAttributesTransformer { incoming in
            var outgoing = incoming
            outgoing.font = UIFont.appFont(type: .medium, size: 16)
            
            return outgoing
        }
        self.configuration = configuration
    }
}

final class ConvertCurrencyView: UIView {
    var handleButtonClickAction: (() -> ())?
    
    private lazy var divider: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = Styles.Color.dividerColor
        return view
    }()
    
    private lazy var convertButton: ConvertButton = {
        let view = ConvertButton()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.handleButtonClickAction = { [weak self] in
            self?.handleButtonClickAction?()
        }
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func initUI() {
        translatesAutoresizingMaskIntoConstraints = false
        backgroundColor = Styles.Color.backgroundColor

        addSubview(divider)
        addSubview(convertButton)
        
        divider.heightAnchor.constraint(equalToConstant: 1).isActive = true
        divider.topAnchor.constraint(equalTo: topAnchor).isActive = true
        divider.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        divider.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        
        convertButton.heightAnchor.constraint(equalToConstant: 48).isActive = true
        convertButton.topAnchor.constraint(equalTo: topAnchor, constant: 16).isActive = true
        convertButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16).isActive = true
        convertButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16).isActive = true
        convertButton.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -16).isActive = true
    }
}
