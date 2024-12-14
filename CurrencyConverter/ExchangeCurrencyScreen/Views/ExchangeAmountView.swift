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

class ExchangeAmountView: UIView {
    lazy var title: UILabel = {
        let view = UILabel()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.textAlignment = .center
        view.textColor = Styles.Color.titleColor
        view.text = Styles.Text.screenTitle
        view.font = UIFont.appFont(type: .medium, size: 16)
        return view
    }()
    
    lazy var sum: UILabel = {
        let view = UILabel()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.textAlignment = .center
        view.textColor = Styles.Color.sumColor
        view.text = "$1.000"
        view.font = UIFont.appFont(type: .semiBold, size: 32)
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func initView() {
        translatesAutoresizingMaskIntoConstraints = false
        backgroundColor = .clear
        
        addSubview(title)
        addSubview(sum)
        
        title.topAnchor.constraint(equalTo: topAnchor).isActive = true
        title.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        title.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        
        sum.topAnchor.constraint(equalTo: title.bottomAnchor, constant: 8).isActive = true
        sum.leadingAnchor.constraint(equalTo: leadingAnchor, constant:  16).isActive = true
        sum.trailingAnchor.constraint(equalTo: trailingAnchor, constant:  -16).isActive = true
        sum.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
    }
}
