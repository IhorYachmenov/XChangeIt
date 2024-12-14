//
//  ExchangeView.swift
//  CurrencyConverter
//
//  Created by Ice on 13.12.2024.
//

import UIKit

fileprivate struct Styles {
    struct Color {
        static let cardColor = UIColor.AppColor.whiteColor
        static let textColor = UIColor.AppColor.midnightExpressColor
        static let commonGrayColor = UIColor.AppColor.waikawaGreyColor
        static let swapButtonBorderColor = UIColor.AppColor.hawkesBlue
    }
    
    struct Text {
        static let viewTitle = "Exchange"
    }
    
    struct Image {
        static let swapIcon = UIImage(named: "HorizontalSwapGrayColor")
    }
}

fileprivate final class SwapCurrencyTypesView: UIButton {
    private var isSwapped = false
    
    lazy var swapImage: UIImageView = {
        let view = UIImageView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .clear
        view.image = Styles.Image.swapIcon
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        buttonScaleAnimation()
        rotateSwapImage()
        super.touchesBegan(touches, with: event)
    }
    
    private func initUI() {
        translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(swapImage)
        
        layer.cornerRadius = 4
        layer.borderColor = Styles.Color.swapButtonBorderColor?.cgColor
        layer.borderWidth = 1
        backgroundColor = .clear
        
        heightAnchor.constraint(equalToConstant: 40).isActive = true
        widthAnchor.constraint(equalToConstant: 40).isActive = true
        
        swapImage.heightAnchor.constraint(equalToConstant: 24).isActive = true
        swapImage.widthAnchor.constraint(equalToConstant: 24).isActive = true
        
        swapImage.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        swapImage.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        
        var configuration = UIButton.Configuration.filled()
        configuration.imagePlacement = .leading
        configuration.imagePadding = 15
        configuration.baseForegroundColor = .clear
        configuration.cornerStyle = .large
        configuration.background.backgroundColor = .clear
        configuration.contentInsets = NSDirectionalEdgeInsets(top: 15, leading: 15, bottom: 15, trailing: 15)
        
        self.configuration = configuration
    }
    
    private func rotateSwapImage() {
        UIView.animate(withDuration: 0.5) {
            self.swapImage.transform = CGAffineTransform(rotationAngle: self.isSwapped ? -(.pi * 2) : .pi)
        }
        isSwapped = !isSwapped
    }
}

final class CurrencyCardView: UIView {
    let defaultSourceCurrency: CurrencyType
    let defaultTargetCurrency: CurrencyType
    
    var showListOfCurrencies: ((_ isSourceTarget: Bool, _ currentCurrency: CurrencyType) -> ())?
    var newTargetCurrency: ((_ targetCurrency: CurrencyType, _ sourceCurrency: CurrencyType) -> ())?
    
    lazy var sourceCurrency: CurrencyTypeView = {
        let view = CurrencyTypeView(frame: .zero, sourceTarget: true, currentCurrency: defaultSourceCurrency)
        view.showCurrencyList = { [weak self] identifier, currency in
            self?.showListOfCurrencies?(identifier, currency)
        }
        return view
    }()
    
    lazy var targetCurrency: CurrencyTypeView = {
        let view = CurrencyTypeView(frame: .zero, sourceTarget: false, currentCurrency: defaultTargetCurrency)
        view.showCurrencyList = { [weak self] identifier, currency in
            self?.showListOfCurrencies?(identifier, currency)
        }
        return view
    }()
    
    private lazy var swapCurrencyView: SwapCurrencyTypesView = {
        let view = SwapCurrencyTypesView()
        view.addAction(UIAction(handler: { [weak self] _ in
            self?.swapCurrencySources()
        }), for: .touchUpInside)
        return view
    }()
    
    private lazy var viewTitle: UILabel = {
        let view = UILabel()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.textAlignment = .left
        view.textColor = Styles.Color.textColor
        view.text = Styles.Text.viewTitle
        view.font = UIFont.appFont(type: .medium, size: 16)
        return view
    }()
    
    let cardViewCornerRadius: CGFloat = 12
    private lazy var cardView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = Styles.Color.cardColor
        view.layer.cornerRadius = cardViewCornerRadius
        return view
    }()
    
    
    init(frame: CGRect, defaultSourceCurrency: CurrencyType, defaultTargetCurrency: CurrencyType) {
        self.defaultSourceCurrency = defaultSourceCurrency
        self.defaultTargetCurrency = defaultTargetCurrency
        super.init(frame: frame)
        initView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func initView() {
        translatesAutoresizingMaskIntoConstraints = false
        backgroundColor = .clear
        
        addSubview(viewTitle)
        addSubview(cardView)

        cardView.addSubview(swapCurrencyView)
        cardView.addSubview(sourceCurrency)
        cardView.addSubview(targetCurrency)
        
        viewTitle.topAnchor.constraint(equalTo: topAnchor).isActive = true
        viewTitle.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16).isActive = true
        viewTitle.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16).isActive = true
        
        cardView.topAnchor.constraint(equalTo: viewTitle.bottomAnchor, constant: 8).isActive = true
        cardView.leadingAnchor.constraint(equalTo: leadingAnchor, constant:  16).isActive = true
        cardView.trailingAnchor.constraint(equalTo: trailingAnchor, constant:  -16).isActive = true
        cardView.bottomAnchor.constraint(equalTo: bottomAnchor, constant:  0).isActive = true
        cardView.heightAnchor.constraint(equalToConstant: 68).isActive = true
        
        cardView.makeShadow(color: Styles.Color.commonGrayColor?.cgColor ?? UIColor.black.cgColor, opacity: 0.2, offset: CGSize(width: 0, height: 3), radius: 1.5, viewCornerRadius: cardViewCornerRadius)
        
        swapCurrencyView.centerXAnchor.constraint(equalTo: cardView.centerXAnchor).isActive = true
        swapCurrencyView.centerYAnchor.constraint(equalTo: cardView.centerYAnchor).isActive = true
        
        sourceCurrency.centerYAnchor.constraint(equalTo: cardView.centerYAnchor).isActive = true
        sourceCurrency.leadingAnchor.constraint(equalTo: cardView.leadingAnchor, constant: 14).isActive = true
        sourceCurrency.trailingAnchor.constraint(equalTo: swapCurrencyView.leadingAnchor, constant: -35).isActive = true
        
        targetCurrency.centerYAnchor.constraint(equalTo: cardView.centerYAnchor).isActive = true
        targetCurrency.trailingAnchor.constraint(equalTo: cardView.trailingAnchor, constant: -14).isActive = true
        targetCurrency.leadingAnchor.constraint(equalTo: swapCurrencyView.trailingAnchor, constant: 35).isActive = true
    }
    
    @objc
    private func swapCurrencySources() {
        let source = sourceCurrency.currentCurrency
        let target = targetCurrency.currentCurrency
        sourceCurrency.updateCurrency(target)
        targetCurrency.updateCurrency(source)
        newTargetCurrency?(source, target)
    }
}
