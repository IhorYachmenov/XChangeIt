//
//  ViewController.swift
//  CurrencyConverter
//
//  Created by Ice on 13.12.2024.
//

import UIKit
import XChangeItCore

fileprivate struct Styles {
    struct Color {
        static let backgroundColor = UIColor.AppColor.ghostWhiteColor
        static let whiteColor = UIColor.AppColor.whiteColor
    }
    
    struct Text {
        static let convertCurrencyButtonTitle = AppLocalization.HomeScreen.nextScreenButton
    }
}

public protocol HomeVCNavigationDelegate: AnyObject {
    func openCurrencyConverveterScreen()
}

public final class HomeViewController: UIViewController {
    public var navigationDelegate: HomeVCNavigationDelegate?
    
    private lazy var santaHatView: UIImageView = {
        let view = UIImageView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.image = UIImage(named:"Santa Hat")
        return view
    }()
    
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
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        initUI()
    }
    
    private func initUI() {
        view.backgroundColor = Styles.Color.backgroundColor
        view.addSubview(getStartedButton)
        getStartedButton.addSubview(santaHatView)
        
        let santaHatSize: CGFloat = 75
        let hatOffset: CGFloat = -(santaHatSize / 2)
        santaHatView.heightAnchor.constraint(equalToConstant: santaHatSize).isActive = true
        santaHatView.widthAnchor.constraint(equalToConstant: santaHatSize).isActive = true
        santaHatView.topAnchor.constraint(equalTo: getStartedButton.topAnchor, constant: hatOffset).isActive = true
        santaHatView.leadingAnchor.constraint(equalTo: getStartedButton.leadingAnchor, constant: hatOffset).isActive = true
        
        getStartedButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        getStartedButton.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        view.addShowEffect()
    }
}

