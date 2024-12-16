//
//  ViewModel.swift
//  CurrencyConverter
//
//  Created by Ice on 15.12.2024.
//

import Foundation

final class ConvertCurrencyViewModel: ConvertCurrencyViewModelInterface {
    private var convertCurrencyTask: Task<(), Never>?
    private var timer: Timer?
    private let autoUpdateTime: TimeInterval = 10
    
    // Default Setting
    private let characterLimit: Int = 10
    private let symbolsAfterDot: Int = 2
    
    private var actualCurrencies: (source: CurrencyType?, target: CurrencyType?) = (nil, nil) {
        didSet {
            detectIfInputCurrencyDidChanged(currencyDidUpdated: true)
        }
    }
    
    private var enteredValueDigital: Double = 0 {
        didSet {
            handleNewCurrency()
        }
    }
    
    private var enteredValue: String = DigitalKeyboardSymbols.zero.string {
        didSet {
            observeKeyboardInputChanges?(enteredValue)
            detectIfInputCurrencyDidChanged()
        }
    }
    
    private let service: ConvertCurrencyServiceInterface
    
    private var dataState: ConvertCurrencyVMDataState = .defaultState {
        didSet {
            observeDataState?(dataState)
        }
    }
    // MARK: Public API
    var observeKeyboardInputChanges: ((_ amount: String) -> ())?
    var observeDataState: ((_ state: ConvertCurrencyVMDataState) -> ())?
    
    init(service: ConvertCurrencyServiceInterface) {
        self.service = service
    }
    
    func handleKeyboardInput(symbol: KeyboardButtonType) {
        parseKeyboardInputToStringCurrency(symbol: symbol)
    }
    
    func updateCurrenciesTypes(source: CurrencyType, target: CurrencyType) {
        actualCurrencies = (source, target)
    }
}

// MARK: Logic of handling keyboard input
fileprivate extension ConvertCurrencyViewModel {
     func allowKeyoardInput(symbol: KeyboardButtonType) -> Bool {
        let checkCharCount = { [weak self]  () -> Bool in
            guard let self = self else { return false }
            return self.enteredValue.count < characterLimit ? true : false
        }
        
        switch symbol {
        case .symbol(_):
            return checkCharCount()
        case .dot:
            return checkCharCount()
        case .delete:
            return true
        }
    }
    
    func parseKeyboardInputToStringCurrency(symbol: KeyboardButtonType) {
        guard allowKeyoardInput(symbol: symbol) else { return }
        switch symbol {
        case .symbol(let symbol):
            guard enteredValue.charactersAfterDot < symbolsAfterDot else { return }
            if enteredValue.firstZero && !enteredValue.containsDot {
                enteredValue = symbol.string
            } else {
                enteredValue.append(symbol.rawValue)
            }
        case .dot:
            guard !enteredValue.containsDot else { return }
            enteredValue.append(symbol.symbol)
        case .delete:
            guard !enteredValue.isEmpty && enteredValue.count != 1 else {
                enteredValue = DigitalKeyboardSymbols.zero.string
                return
            }
            enteredValue.removeLast()
        }
    }
}

// MARK: Detecting new type of currency value
fileprivate extension ConvertCurrencyViewModel {
    func detectIfInputCurrencyDidChanged(currencyDidUpdated: Bool = false) {
        guard actualCurrencies.source != nil && actualCurrencies.target != nil else { return }
        guard let convertedToDigit = Double(enteredValue) else { return }
        
        let updateValue = { [weak self ] () -> () in
            self?.enteredValueDigital = convertedToDigit
        }
        
        /// <lastCharIsDot> is the extra check for predicting user changes, may be omitted, but it helps prevent sending converting request faster than it needs if the user only wants to change the value after the dot
        guard !enteredValue.lastCharIsDot else { return }
        if enteredValueDigital != convertedToDigit {
            updateValue()
        } else {
            guard currencyDidUpdated && !enteredValueDigital.isZero else { return }
            updateValue()
        }
    }
}

// MARK: Handling of the new currency value
fileprivate extension ConvertCurrencyViewModel {
    func handleNewCurrency() {
        guard let sourceCurrency = actualCurrencies.source?.description.code,
              let targetCurrency = actualCurrencies.target?.description.code else { return }
        
        if enteredValueDigital.isZero {
            cancelTask()
            dataState = .defaultState
        } else {
            dataState = .loadingState
            cancelTask()
            runCurrencyConvertingTask(amount: String(enteredValueDigital),
                                      sourceCurrency: sourceCurrency, 
                                      targetCurrency: targetCurrency)
            
        }
    }
    
    private func runCurrencyConvertingTask(amount: String, sourceCurrency: String, targetCurrency: String) {
        convertCurrencyTask = Task { @MainActor in
            do {
                let result = try await service.convertCurrency(amount: amount,
                                                               sourceCurrency: sourceCurrency,
                                                               targetCurrency: targetCurrency)
                guard !Task.isCancelled else { return }
                dataState = .successState(amount: result.amount)
                enableAutoUpdate()
            } catch {
                guard !Task.isCancelled else { return }
                let errorDescription = (error as? NetworkingError)?.description ?? error.localizedDescription
                dataState = .failureState(error: errorDescription)
                enableAutoUpdate()
            }
        }
    }
    
    private func cancelTask() {
        convertCurrencyTask?.cancel()
        convertCurrencyTask = nil
        disableAutoUpdate()
    }
    
    private func enableAutoUpdate() {
        timer = Timer.scheduledTimer(withTimeInterval: autoUpdateTime, repeats: true) { [weak self] timer in
            self?.handleNewCurrency()
        }
    }
    
    private func disableAutoUpdate() {
        timer?.invalidate()
        timer = nil
    }
}
