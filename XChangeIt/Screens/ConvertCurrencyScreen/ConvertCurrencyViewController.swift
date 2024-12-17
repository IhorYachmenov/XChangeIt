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
        static let screenTitle = "Currency Conversion"
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initUI()
        initBL()
    }
    
    private func initUI() {
        detailsScreenNavigationHeader(backButtonImage: Styles.Image.backButtonIcon, action: #selector(backButtonAction), title: Styles.Text.screenTitle)
        view.backgroundColor = Styles.Color.backgroundColor
        
        view.addSubview(convertAmountView)
        view.addSubview(receivedAmountCardView)
        view.addSubview(convertCurrenciesTypeCardView)
        view.addSubview(inputPanel)
        
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
    }
    
    private func initBL() {
        handleUpdateNewCurrencies(source: defaultSourceCurrency, target: defaultTargetCurrency)
        viewModel?.observeKeyboardInputChanges = { [weak self] amount in
            self?.convertAmountView.updateCurrencyAmount(amount: amount)
        }
        
        viewModel?.observeDataState = { [weak self] state in
            switch state {
            case .successState(amount: let amount):
                self?.receivedAmountCardView.updateTargetCurrencySum(amount)
            case .failureState(error: let error):
                self?.receivedAmountCardView.showErrorTargetCurrencyState(error)
            case .loadingState:
                self?.receivedAmountCardView.showLoadingTargetCurrencyState()
            case .defaultState:
                self?.receivedAmountCardView.showEmptyTargetCurrencyState()
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
        
        presentSheetController(currenciesVC)
    }
    
    @objc
    private func backButtonAction() {
        navigationDelegate?.closeScreen()
    }
    
    private func handleUpdateNewCurrencies(source: CurrencyType, target: CurrencyType) {
        viewModel?.updateCurrenciesTypes(source: source, target: target)
    }
}
