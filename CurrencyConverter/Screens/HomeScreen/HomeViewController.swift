//
//  ViewController.swift
//  CurrencyConverter
//
//  Created by Ice on 13.12.2024.
//

import UIKit

fileprivate struct Styles {
    struct Color {
        static let backgroundColor = UIColor.AppColor.ghostWhiteColor
        static let whiteColor = UIColor.AppColor.whiteColor
    }
    
    struct Text {
        static let convertCurrencyButtonTitle = "Convert Currency"
    }
}

protocol HomeVCNavigationDelegate: AnyObject {
    func openCurrencyConverveterScreen()
}

final class HomeViewController: UIViewController {
    var navigationDelegate: HomeVCNavigationDelegate?
    
    private lazy var getStartedButton: UIButton = {
        let view = UIButton()
        view.translatesAutoresizingMaskIntoConstraints = false
        
        var configuration = UIButton.Configuration.filled()
        configuration.title = Styles.Text.convertCurrencyButtonTitle
        configuration.baseForegroundColor = Styles.Color.whiteColor
        configuration.cornerStyle = .large
        configuration.background.backgroundColor = UIColor.AppColor.waikawaGreyColor
        configuration.contentInsets = NSDirectionalEdgeInsets(top: 15, leading: 15, bottom: 15, trailing: 15)
        
        configuration.titleTextAttributesTransformer = UIConfigurationTextAttributesTransformer { incoming in
            var outgoing = incoming
            outgoing.backgroundColor = .clear
            outgoing.font = UIFont.appFont(type: .medium, size: 20)
            return outgoing
        }
        view.configuration = configuration
        
        view.addAction(UIAction(handler: { [weak self] _ in
            self?.navigationDelegate?.openCurrencyConverveterScreen()
        }), for: .touchUpInside)
        
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initUI()
    }
    
    private func initUI() {
        view.backgroundColor = Styles.Color.backgroundColor
        view.addSubview(getStartedButton)
        
        getStartedButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        getStartedButton.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
    }
}

