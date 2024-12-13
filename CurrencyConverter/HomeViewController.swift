//
//  ViewController.swift
//  CurrencyConverter
//
//  Created by Ice on 13.12.2024.
//

import UIKit

class HomeViewController: UIViewController {
    private lazy var getStartedButton: UIButton = {
        let view = UIButton()
        view.translatesAutoresizingMaskIntoConstraints = false
        
        var configuration = UIButton.Configuration.filled()
        configuration.title = "Get Started"
//        configuration.image = UIImage(systemName: Constants.SingerTrackDetailsScreen.playButtonDefaultImgName)
        configuration.imagePlacement = .leading
        configuration.imagePadding = 15
        configuration.baseForegroundColor = .white
        configuration.cornerStyle = .large
        configuration.background.backgroundColor = UIColor.AppColor.waikawaGreyColor
        configuration.contentInsets = NSDirectionalEdgeInsets(top: 15, leading: 15, bottom: 15, trailing: 15)
        
        configuration.titleTextAttributesTransformer = UIConfigurationTextAttributesTransformer { incoming in
            var outgoing = incoming
            outgoing.backgroundColor = .clear
            outgoing.font = UIFont.boldSystemFont(ofSize: 20)
            return outgoing
        }
        view.configuration = configuration
        
        view.addAction(UIAction(handler: { [weak self] _ in
            self?.openCurrencyConverted()
        }), for: .touchUpInside)
        
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initUI()
        // Do any additional setup after loading the view.
    }
    
    private func initUI() {
        view.backgroundColor = .white
        view.addSubview(getStartedButton)
        
        getStartedButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        getStartedButton.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
    }
    
    private func openCurrencyConverted() {
        let vc = CorrencyConververViewController()
        present(vc, animated: true)
    }
}

