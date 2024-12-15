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

protocol ConvertCurrencyVCNavigationDelegate: AnyObject {
    func closeScreen()
}

final class ConvertCurrencyViewController: UIViewController {
    var navigationDelegate: ConvertCurrencyVCNavigationDelegate?
    var viewModel: ConvertCurrencyViewModelInterface?
    
    let defaultSourceCurrency: CurrencyType = .unitedStatesDollar
    let defaultTargetCurrency: CurrencyType = .euro
    
    private lazy var convertAmountView: ConvertAmountView = {
        let view = ConvertAmountView(frame: .zero, defaultSourceCurrency: defaultSourceCurrency)
        return view
    }()
    
    private lazy var receivedAmountCardView: ReceivedAmountCardView = {
        let view = ReceivedAmountCardView()
        view.updateTargetCurrency(defaultTargetCurrency)
        return view
    }()
    
    private lazy var convertCurrenciesTypeCardView: ConvertCurrenciesTypeCardView = {
        let view = ConvertCurrenciesTypeCardView(frame: .zero, defaultSourceCurrency: defaultSourceCurrency, defaultTargetCurrency: defaultTargetCurrency)
        view.showListOfCurrencies = { [weak self] identifier, currency, oppositeCurrency in
            self?.showListOfCurrencies(isSourceCurrency: identifier, currentCurrency: currency, oppositeCurrency: oppositeCurrency)
        }
        view.newTargetCurrency = { [weak self] targetCurrency, sourceCurrency in
            self?.receivedAmountCardView.updateTargetCurrency(targetCurrency)
            self?.convertAmountView.updateCurrencySymbol(currency: sourceCurrency)
            self?.handleUpdateNewCurrencies(source: sourceCurrency, target: targetCurrency)
        }
        return view
    }()
    
    private lazy var inputPanel: InputPannel = {
        let view = InputPannel()
        view.handleButtonClickAction = { [weak self] symbol in
            self?.viewModel?.handleKeyboardInput(symbol: symbol)
        }
        return view
    }()
    
    // TODO: remove later if it wouldn't required by BL
//    private lazy var footerPanel: ConvertCurrencyView = {
//        let view = ConvertCurrencyView()
//        view.handleButtonClickAction = { [weak self] in
//            
//        }
//        return view
//    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initUI()
        initBL()
    }
    
    deinit {
        print(#function, "ConvertCurrencyViewController")
    }
    
    private func initUI() {
        detailsScreenNavigationHeader(backButtonImage: Styles.Image.backButtonIcon, action: #selector(backButtonAction), title: Styles.Text.screenTitle)
        view.backgroundColor = Styles.Color.backgroundColor
        
        view.addSubview(convertAmountView)
        view.addSubview(receivedAmountCardView)
        view.addSubview(convertCurrenciesTypeCardView)
        view.addSubview(inputPanel)
        // TODO: remove later if it wouldn't required by BL
//        view.addSubview(footerPanel)
        
        let topSafeArea: CGFloat = UIApplication.windowInset.top + (navigationController?.view.safeAreaInsets.top ?? 0)
        let viewDefaultTopInset: CGFloat = 25 + topSafeArea
        let smallerTopInset: CGFloat = 10 + topSafeArea
        
        // Resizing For Small Screen
        let topConstraintConvertAmountView: NSLayoutConstraint = convertAmountView.topAnchor.constraint(equalTo: view.topAnchor, constant: smallerTopInset)
        topConstraintConvertAmountView.priority = .defaultHigh
        topConstraintConvertAmountView.isActive = true
        
        convertAmountView.topAnchor.constraint(equalTo: view.topAnchor, constant: viewDefaultTopInset).isActive = true
        convertAmountView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        convertAmountView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        
        // Resizing For Small Screen
        let topConstraintReceivedAmountCardView: NSLayoutConstraint = receivedAmountCardView.topAnchor.constraint(equalTo: convertAmountView.bottomAnchor)
        topConstraintReceivedAmountCardView.priority = .defaultHigh
        topConstraintReceivedAmountCardView.isActive = true
        receivedAmountCardView.topAnchor.constraint(lessThanOrEqualTo: convertAmountView.bottomAnchor, constant: 25).isActive = true
        receivedAmountCardView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        receivedAmountCardView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true

        convertCurrenciesTypeCardView.topAnchor.constraint(equalTo: receivedAmountCardView.bottomAnchor, constant: 16).isActive = true
        convertCurrenciesTypeCardView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        convertCurrenciesTypeCardView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        
        inputPanel.topAnchor.constraint(equalTo: convertCurrenciesTypeCardView.bottomAnchor, constant: 11).isActive = true
        inputPanel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0).isActive = true
        inputPanel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0).isActive = true
        inputPanel.bottomAnchor.constraint(lessThanOrEqualTo: view.bottomAnchor).isActive = true
        
        // TODO: remove later if it wouldn't required by BL
//        footerPanel.topAnchor.constraint(greaterThanOrEqualTo: inputPanel.bottomAnchor).isActive = true
//        footerPanel.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
//        footerPanel.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
//        footerPanel.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
    }
    
    private func initBL() {
        handleUpdateNewCurrencies(source: defaultSourceCurrency, target: defaultTargetCurrency)
        viewModel?.observeKeyboardInputChanges = { [weak self] result in
            switch result {
            case .success(let amount):
                self?.convertAmountView.updateCurrencyAmount(amount: amount)
            case .failure(_):
                break
            }
        }
        
        viewModel?.observeConvertedData = { [weak self] result in
            switch result {
            case .success(let data):
                self?.receivedAmountCardView.updateTargetCurrencySum(data)
            case .failure(_):
                break
            }
        }
    }
    
    private func showListOfCurrencies(isSourceCurrency: Bool, currentCurrency: CurrencyType, oppositeCurrency: CurrencyType) {
        let currenciesVC = CurrenciesListViewController(currentCurrency: currentCurrency, oppositeCurrency: oppositeCurrency)
        currenciesVC.selectedValue = { [weak self] currency in
            guard let self = self else { return }
            if isSourceCurrency {
                convertCurrenciesTypeCardView.sourceCurrency.updateCurrency(currency)
                convertAmountView.updateCurrencySymbol(currency: currency)
                
                let targetCurrency = convertCurrenciesTypeCardView.targetCurrency.currentCurrency
                handleUpdateNewCurrencies(source: currency, target: targetCurrency)
            } else {
                convertCurrenciesTypeCardView.targetCurrency.updateCurrency(currency)
                receivedAmountCardView.updateTargetCurrency(currency)
                
                let sourceCurrency = convertCurrenciesTypeCardView.sourceCurrency.currentCurrency
                handleUpdateNewCurrencies(source: sourceCurrency, target: currency)
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
    
    @objc
    private func backButtonAction() {
        navigationDelegate?.closeScreen()
    }
    
    private func handleUpdateNewCurrencies(source: CurrencyType, target: CurrencyType) {
        viewModel?.updateCurrenciesTypes(source: source, target: target)
    }
}
