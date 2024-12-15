//
//  ReceivedAmountCardView.swift
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
        static let errorColor = UIColor.AppColor.freeSpeechRed
    }
    
    struct Text {
        static let viewTitle = "You Receive"
        static let convertedTitle = "Quantity"
    }
}

final class ReceivedAmountCardView: UIView {
    private lazy var viewTitle: UILabel = {
        let view = UILabel()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.textAlignment = .left
        view.textColor = Styles.Color.textColor
        view.text = Styles.Text.viewTitle
        view.font = UIFont.appFont(type: .medium, size: 16)
        return view
    }()
    
    private lazy var cardDivider: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .clear
        return view
    }()
    
    private lazy var currencyType: UILabel = {
        let view = UILabel()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.textAlignment = .right
        view.textColor = Styles.Color.textColor
        view.font = UIFont.appFont(type: .regular, size: 16)
        return view
    }()
    
    private lazy var convertedAmountView: UILabel = {
        let view = UILabel()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.textAlignment = .left
        view.textColor = Styles.Color.textColor
        view.font = UIFont.appFont(type: .regular, size: 16)
        return view
    }()

    private lazy var convertedAmountTitle: UILabel = {
        let view = UILabel()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.textAlignment = .left
        view.textColor = Styles.Color.commonGrayColor
        view.text = Styles.Text.convertedTitle
        view.font = UIFont.appFont(type: .regular, size: 14)
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
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initView()
        showEmptyTargetCurrencyState()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func initView() {
        translatesAutoresizingMaskIntoConstraints = false
        backgroundColor = .clear
        
        addSubview(viewTitle)
        addSubview(cardView)
        
        cardView.addSubview(cardDivider)
        cardView.addSubview(currencyType)
        cardView.addSubview(convertedAmountView)
        cardView.addSubview(convertedAmountTitle)
        
        viewTitle.topAnchor.constraint(equalTo: topAnchor).isActive = true
        viewTitle.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16).isActive = true
        viewTitle.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16).isActive = true
        
        cardView.topAnchor.constraint(equalTo: viewTitle.bottomAnchor, constant: 8).isActive = true
        cardView.leadingAnchor.constraint(equalTo: leadingAnchor, constant:  16).isActive = true
        cardView.trailingAnchor.constraint(equalTo: trailingAnchor, constant:  -16).isActive = true
        cardView.bottomAnchor.constraint(equalTo: bottomAnchor, constant:  0).isActive = true
        cardView.heightAnchor.constraint(equalToConstant: 68).isActive = true
        
        cardView.makeShadow(color: Styles.Color.commonGrayColor?.cgColor ?? UIColor.black.cgColor, opacity: 0.2, offset: CGSize(width: 0, height: 3), radius: 1.5, viewCornerRadius: cardViewCornerRadius)
        
        cardDivider.widthAnchor.constraint(equalToConstant: 1).isActive = true
        cardDivider.centerXAnchor.constraint(equalTo: cardView.centerXAnchor).isActive = true
        cardDivider.topAnchor.constraint(equalTo: cardView.topAnchor).isActive = true
        cardDivider.bottomAnchor.constraint(equalTo: cardView.bottomAnchor).isActive = true
        
        currencyType.centerYAnchor.constraint(equalTo: cardView.centerYAnchor).isActive = true
        currencyType.trailingAnchor.constraint(equalTo: cardView.trailingAnchor, constant: -14).isActive = true
        currencyType.leadingAnchor.constraint(equalTo: cardDivider.trailingAnchor, constant: 0).isActive = true
        
        convertedAmountTitle.topAnchor.constraint(equalTo: cardView.topAnchor, constant: 17).isActive = true
        convertedAmountTitle.leadingAnchor.constraint(equalTo: cardView.leadingAnchor, constant: 14).isActive = true
        convertedAmountTitle.trailingAnchor.constraint(equalTo: cardDivider.leadingAnchor, constant: 0).isActive = true
        convertedAmountTitle.heightAnchor.constraint(equalToConstant: 17).isActive = true
        
        convertedAmountView.topAnchor.constraint(equalTo: convertedAmountTitle.bottomAnchor, constant: 0).isActive = true
        convertedAmountView.leadingAnchor.constraint(equalTo: cardView.leadingAnchor, constant: 14).isActive = true
        convertedAmountView.bottomAnchor.constraint(equalTo: cardView.bottomAnchor, constant: -17).isActive = true
        convertedAmountView.trailingAnchor.constraint(equalTo: cardDivider.leadingAnchor, constant: 0).isActive = true
        convertedAmountView.heightAnchor.constraint(equalToConstant: 17).isActive = true
    }
    
    private func updateReceivedAmountViewText(text: String, errorState: Bool = false) {
        convertedAmountView.fadeTransition()
        convertedAmountView.text = text
        convertedAmountView.textColor = errorState ? Styles.Color.errorColor : Styles.Color.textColor
    }
    
    //MARK: -  PUBLIC API
    
    /// Local actions code
    func updateTargetCurrency(_ currency: CurrencyType) {
        currencyType.fadeTransition()
        currencyType.text = currency.description.code
    }
    
    /// Networking actions code
    func updateTargetCurrencySum(_ sum: String) {
        updateReceivedAmountViewText(text: sum)
    }
    
    func showEmptyTargetCurrencyState() {
        updateReceivedAmountViewText(text: "0")
    }
    
    func showLoadingTargetCurrencyState() {
        // TODO: - update later with loader
        updateReceivedAmountViewText(text: "Loading...")
    }
    
    func showErrorTargetCurrencyState(_ error: String) {
        updateReceivedAmountViewText(text: error, errorState: true)
    }
}
