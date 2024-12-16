//
//  ConvertView.swift
//  CurrencyConverter
//
//  Created by Ice on 13.12.2024.
//

import UIKit

fileprivate struct Styles {
    struct Color {
        static let titleColor = UIColor.AppColor.midnightExpressColor
        static let sumColor = UIColor.AppColor.royalBlueColor
    }
    
    struct Text {
        static let screenTitle = "You Convert"
    }
}

final class ConvertAmountView: UIView {
    private var defaultSourceCurrency: CurrencyType
    private var currencySum: String = "0"
    
    private lazy var title: UILabel = {
        let view = UILabel()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.textAlignment = .center
        view.textColor = Styles.Color.titleColor
        view.text = Styles.Text.screenTitle
        view.font = UIFont.appFont(type: .medium, size: 16)
        view.numberOfLines = 1
        return view
    }()
    
    private lazy var sum: UILabel = {
        let view = UILabel()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.textAlignment = .center
        view.textColor = Styles.Color.sumColor
        view.font = UIFont.appFont(type: .semiBold, size: 32)
        view.numberOfLines = 1
        return view
    }()
    
    init(frame: CGRect, defaultSourceCurrency: CurrencyType) {
        self.defaultSourceCurrency = defaultSourceCurrency
        super.init(frame: frame)
        initView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func initView() {
        translatesAutoresizingMaskIntoConstraints = false
        backgroundColor = .clear
        updateCurrencySumUI()
        addSubview(title)
        addSubview(sum)
        
        title.topAnchor.constraint(equalTo: topAnchor).isActive = true
        title.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        title.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        
        sum.setContentHuggingPriority(UILayoutPriority(252), for: .vertical)
        sum.topAnchor.constraint(equalTo: title.bottomAnchor, constant: 8).isActive = true
        sum.leadingAnchor.constraint(equalTo: leadingAnchor, constant:  16).isActive = true
        sum.trailingAnchor.constraint(equalTo: trailingAnchor, constant:  -16).isActive = true
        sum.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
    }
    
    
    private func updateCurrencySumUI(animate: Bool = true) {
        if animate {
            sum.fadeTransition()
        }
        sum.text = "\(defaultSourceCurrency.description.sign)\(currencySum)"
    }
    
    func updateCurrencySymbol(currency: CurrencyType) {
        defaultSourceCurrency = currency
        updateCurrencySumUI()
    }
    
    func updateCurrencyAmount(amount: String) {
        currencySum = amount
        updateCurrencySumUI(animate: false)
    }
}
