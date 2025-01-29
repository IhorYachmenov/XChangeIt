//
//  KeyboardButton.swift
//  CurrencyConverter
//
//  Created by Ice on 14.12.2024.
//

import UIKit

fileprivate struct Styles {
    struct Color {
        static let buttonColor = UIColor.AppColor.whiteColor
        static let textColor = UIColor.AppColor.midnightExpressColor
        static let commonGrayColor = UIColor.AppColor.waikawaGreyColor
    }

    struct Image {
        static let deleteButtonIcon = UIImage(named: "KeyboardDeleteIconBlack")
    }
}

public enum KeyboardButtonType {
    case symbol(symbol: DigitalKeyboardSymbols)
    case dot
    case delete
    
    var symbol: String {
        return switch self {
        case .symbol(let symbol):
            symbol.string
        case .dot:
            "."
        case .delete:
            "X"
        }
    }
    
    var image: UIImage? {
        return switch self {
        case .symbol(_):
            nil
        case .dot:
            nil
        case .delete:
            Styles.Image.deleteButtonIcon
        }
    }
}

final class KeyboardButton: UIButton {
    var handleButtonClickAction: ((_ type: KeyboardButtonType) -> ())?
    let keyboardButtonType: KeyboardButtonType
    
    private lazy var buttonTitle: UILabel = {
        let view = UILabel()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.textAlignment = .center
        view.textColor = Styles.Color.textColor
        view.font = UIFont.appFont(type: .regular, size: 24)
        return view
    }()
    
    
    init(frame: CGRect, buttonType: KeyboardButtonType) {
        keyboardButtonType = buttonType
        super.init(frame: frame)
        initUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        buttonScaleAnimation()
        handleButtonClickAction?(keyboardButtonType)
        super.touchesBegan(touches, with: event)
    }
    
    private func initUI() {
        translatesAutoresizingMaskIntoConstraints = false
        backgroundColor = Styles.Color.buttonColor
        let viewCornerRadius: CGFloat = 4
        layer.cornerRadius = viewCornerRadius
        
        makeShadow(color: Styles.Color.commonGrayColor?.cgColor ?? UIColor.black.cgColor,
                   opacity: 0.2,
                   offset: CGSize(width: 0, height: 3),
                   radius: 1.5, viewCornerRadius: viewCornerRadius)
    
        switch keyboardButtonType {
        case .symbol(let symbol):
            initButtonViewTitle(symbol: symbol.string)
        case .dot:
            initButtonViewTitle(symbol: keyboardButtonType.symbol)
        case .delete:
            initDeleteButtonTitle()
        }
    }
    
    private func initButtonViewTitle(symbol: String) {
        buttonTitle.text = symbol
        addSubview(buttonTitle)
        buttonTitle.topAnchor.constraint(equalTo: topAnchor).isActive = true
        buttonTitle.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        buttonTitle.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        buttonTitle.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
    }
    
    private func initDeleteButtonTitle() {
        var configuration = UIButton.Configuration.filled()
        configuration.image = Styles.Image.deleteButtonIcon
        configuration.imagePlacement = .all
        configuration.baseForegroundColor = .clear
        configuration.background.backgroundColor = .clear
        
        self.configuration = configuration
    }
}
