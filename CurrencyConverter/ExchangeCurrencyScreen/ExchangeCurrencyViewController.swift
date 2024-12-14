//
//  CorrencyConververViewController.swift
//  CurrencyConverter
//
//  Created by Ice on 13.12.2024.
//

import UIKit

fileprivate struct Styles {
    struct Color {
        static let backgroundColor = UIColor.AppColor.ghostWhiteColor
        static let headerTitleColor = UIColor.AppColor.midnightExpressColor
        static let backButtonColor = UIColor.AppColor.waikawaGreyColor
    }
    
    struct Image {
        static let backButtonIcon = UIImage(named: "BackButtonGreyColor")
    }
    
    struct Text {
        static let screenTitle = "Exchange Currency"
    }
}

final class ExchangeCurrencyViewController: UIViewController {
    let defaultSourceCurrency: CurrencyType = .unitedStatesDollar
    let defaultTargetCurrency: CurrencyType = .euro
    
    private lazy var exchangeAmountView: ExchangeAmountView = {
        let view = ExchangeAmountView(frame: .zero, defaultSourceCurrency: defaultSourceCurrency)
        return view
    }()
    
    private lazy var convertedAmountCardView: ConvertedAmountCardView = {
        let view = ConvertedAmountCardView()
        view.updateTargetCurrency(defaultTargetCurrency)
        return view
    }()
    
    private lazy var currencyCardView: CurrencyCardView = {
        let view = CurrencyCardView(frame: .zero, defaultSourceCurrency: defaultSourceCurrency, defaultTargetCurrency: defaultTargetCurrency)
        view.showListOfCurrencies = { [weak self] identifier, currency in
            self?.showListOfCurrencies(isSourceCurrency: identifier, currentCurrency: currency)
        }
        view.newTargetCurrency = { [weak self] targetCurrency, sourceCurrency in
            self?.convertedAmountCardView.updateTargetCurrency(targetCurrency)
            self?.exchangeAmountView.updateCurrencySymbol(currency: sourceCurrency)
        }
        return view
    }()
    
    private lazy var inputPanel: InputPannel = {
        let view = InputPannel()
        view.handleButtonClickAction = { [weak self] symbol in
            self?.handleKeyboardButtonClick(symbol: symbol)
        }
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initUI()
    }
    
    deinit {
        print(#function, "ExchangeCurrencyViewController")
    }
    
    private func initUI() {
        detailsScreenNavigationHeader(backButtonImage: Styles.Image.backButtonIcon, action: #selector(backButtonAction), title: Styles.Text.screenTitle)
        view.backgroundColor = Styles.Color.backgroundColor
        
        view.addSubview(exchangeAmountView)
        view.addSubview(convertedAmountCardView)
        view.addSubview(currencyCardView)
        view.addSubview(inputPanel)
        
        let viewTopInset: CGFloat = 25 + UIApplication.windowInset.top + (navigationController?.view.safeAreaInsets.top ?? 0)
        
        exchangeAmountView.topAnchor.constraint(equalTo: view.topAnchor, constant: viewTopInset).isActive = true
        exchangeAmountView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        exchangeAmountView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        
        convertedAmountCardView.topAnchor.constraint(equalTo: exchangeAmountView.bottomAnchor, constant: 25).isActive = true
        convertedAmountCardView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        convertedAmountCardView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        
        currencyCardView.topAnchor.constraint(equalTo: convertedAmountCardView.bottomAnchor, constant: 16).isActive = true
        currencyCardView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        currencyCardView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        
        // TODO: botton constaint
        inputPanel.topAnchor.constraint(equalTo: currencyCardView.bottomAnchor, constant: 11).isActive = true
        inputPanel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0).isActive = true
        inputPanel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0).isActive = true
        
        inputPanel.layer.borderColor = UIColor.red.cgColor
        inputPanel.layer.borderWidth = 2
    }
    
    @objc
    private func backButtonAction() {
        navigationController?.popViewController(animated: true)
    }
    
    private func showListOfCurrencies(isSourceCurrency: Bool, currentCurrency: CurrencyType) {
        let currenciesVC = CurrencyListViewController(currentCurrency: currentCurrency)
        currenciesVC.selectedValue = { [weak self] currency in
            if isSourceCurrency {
                self?.currencyCardView.sourceCurrency.updateCurrency(currency)
                self?.exchangeAmountView.updateCurrencySymbol(currency: currency)
            } else {
                self?.currencyCardView.targetCurrency.updateCurrency(currency)
                self?.convertedAmountCardView.updateTargetCurrency(currency)
            }
        }
        
        let navigationVC = UINavigationController(rootViewController: currenciesVC)
        
        if let sheet = navigationVC.sheetPresentationController {
            sheet.detents = [.medium(), .large()]
            sheet.prefersScrollingExpandsWhenScrolledToEdge = false
            sheet.prefersGrabberVisible = true
            sheet.prefersEdgeAttachedInCompactHeight = true
            
            sheet.widthFollowsPreferredContentSizeWhenEdgeAttached = true
        }
        present(navigationVC, animated: true, completion: nil)
    }
    
    private func handleKeyboardButtonClick(symbol: KeyboardButtonType) {
        print(symbol.symbol)
    }
}
