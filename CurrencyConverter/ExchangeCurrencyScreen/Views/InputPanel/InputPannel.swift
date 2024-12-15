//
//  InputPannel.swift
//  CurrencyConverter
//
//  Created by Ice on 14.12.2024.
//

import UIKit

fileprivate typealias DKS = DigitalKeyboardSymbols
final class InputPannel: UIView {
    var handleButtonClickAction: ((_ type: KeyboardButtonType) -> ())?
    
    private var keyboardButtons: [[KeyboardButtonType]] = [
        [KeyboardButtonType.symbol(symbol: DKS.one), KeyboardButtonType.symbol(symbol: DKS.two), KeyboardButtonType.symbol(symbol: DKS.three)],
        [KeyboardButtonType.symbol(symbol: DKS.four), KeyboardButtonType.symbol(symbol: DKS.five), KeyboardButtonType.symbol(symbol: DKS.six)],
        [KeyboardButtonType.symbol(symbol: DKS.seven), KeyboardButtonType.symbol(symbol: DKS.eight), KeyboardButtonType.symbol(symbol: DKS.nine)],
        [KeyboardButtonType.dot, KeyboardButtonType.symbol(symbol: DKS.zero), KeyboardButtonType.delete]
    ]
    
    private lazy var keyboardStackContainer: UIStackView = {
        let view = UIStackView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.axis = .vertical
        view.spacing = 7
        view.distribution = .fillEqually
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
        backgroundColor = .clear
        addSubview(keyboardStackContainer)

        keyboardStackContainer.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16).isActive = true
        keyboardStackContainer.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16).isActive = true
        keyboardStackContainer.topAnchor.constraint(equalTo: topAnchor, constant: 11).isActive = true
        keyboardStackContainer.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -11).isActive = true
        
        keyboardButtons.forEach({ keyboardStackContainer.addArrangedSubview(createHorizontalButtonStack(buttons: $0)) })
    }
    
    private func createHorizontalButtonStack(buttons: [KeyboardButtonType]) -> UIStackView {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.spacing = 5
        stackView.distribution = .fillEqually
        stackView.heightAnchor.constraint(equalToConstant: 44).isActive = true
        
        buttons.forEach { button in
            let button = KeyboardButton(frame: .zero, buttonType: button)
            button.handleButtonClickAction = { [weak self] symbol in
                self?.handleButtonClickAction?(symbol)
            }
            stackView.addArrangedSubview(button)
        }
        
        return stackView
    }
}

