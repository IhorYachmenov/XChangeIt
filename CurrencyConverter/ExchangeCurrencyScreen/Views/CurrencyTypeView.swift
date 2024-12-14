//
//  SourceCurrencyView.swift
//  CurrencyConverter
//
//  Created by Ice on 14.12.2024.
//

import UIKit

fileprivate struct Styles {
    struct Color {
        static let currencyColor = UIColor.AppColor.midnightExpressColor
        static let titleColor = UIColor.AppColor.waikawaGreyColor
    }
    
    struct Text {
        static let from = "From"
        static let to = "To"
    }
}

class CurrencyTypeView: UIView {
    let sourceCurrency: Bool
    
    lazy var currencyImage: UIImageView = {
        let view = UIImageView()
        view.translatesAutoresizingMaskIntoConstraints = false
        // TODO: -
        view.image = UIImage(named: "AustraliaFlagCircle")
        return view
    }()
    
    lazy var titleView: UILabel = {
        let view = UILabel()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.textColor = Styles.Color.titleColor
        view.textAlignment = sourceCurrency ? .left : .right
        view.font = UIFont.appFont(type: .regular, size: 14)
        view.text = sourceCurrency ? Styles.Text.from : Styles.Text.to
        return view
    }()
    
    lazy var currencyType: UILabel = {
        let view = UILabel()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.textColor = Styles.Color.currencyColor
        view.textAlignment = sourceCurrency ? .left : .right
        view.font = UIFont.appFont(type: .regular, size: 16)
        view.text = "USD"
        return view
    }()
    
    init(frame: CGRect, sourceTarget: Bool) {
        self.sourceCurrency = sourceTarget
        super.init(frame: frame)
        initUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func initUI() {
        translatesAutoresizingMaskIntoConstraints = false
        backgroundColor = .clear
        
        addSubview(currencyImage)
        addSubview(titleView)
        addSubview(currencyType)
        
        currencyImage.heightAnchor.constraint(equalToConstant: 40).isActive = true
        currencyImage.widthAnchor.constraint(equalToConstant: 40).isActive = true
        currencyImage.topAnchor.constraint(equalTo: topAnchor).isActive = true
        currencyImage.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        
        titleView.topAnchor.constraint(equalTo: currencyImage.topAnchor).isActive = true
        
        currencyType.bottomAnchor.constraint(equalTo: currencyImage.bottomAnchor).isActive = true
        
        if sourceCurrency {
            currencyImage.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
            
            titleView.leadingAnchor.constraint(equalTo: currencyImage.trailingAnchor, constant: 8).isActive = true
            titleView.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
            
            currencyType.leadingAnchor.constraint(equalTo: currencyImage.trailingAnchor, constant: 8).isActive = true
            currencyType.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        } else {
            currencyImage.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
            
            titleView.trailingAnchor.constraint(equalTo: currencyImage.leadingAnchor, constant: -8).isActive = true
            titleView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
            
            currencyType.trailingAnchor.constraint(equalTo: currencyImage.leadingAnchor, constant: -8).isActive = true
            currencyType.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        }
    }
}
