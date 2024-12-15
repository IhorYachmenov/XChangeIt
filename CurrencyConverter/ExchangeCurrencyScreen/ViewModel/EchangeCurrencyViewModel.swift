//
//  ViewModel.swift
//  CurrencyConverter
//
//  Created by Ice on 15.12.2024.
//

import Foundation

final class EchangeCurrencyViewModel: EchangeCurrencyViewModelInterface {
    // Default Setting
    private let characterLimit: Int = 10
    private let symbolsAfterDot: Int = 2
    
    private var targetCurrency: CurrencyType? {
        didSet {
            detectIfInputCurrencyDidChanged()
        }
    }
    
    private var enteredValueDigital: Float = 0 {
        didSet {
            handleNewCurrency()
        }
    }
    
    private var enteredValue: String = DigitalKeyboardSymbols.zero.string {
        didSet {
            observeInputData?(.success(enteredValue))
            detectIfInputCurrencyDidChanged()
        }
    }
    
    // MARK: Public API
    var observeInputData: ((Result<String, any Error>) -> ())?
    var observeReceivedData: ((Result<String, any Error>) -> ())?
    
    init() {}
    
    deinit {
        print(#function, "EchangeCurrencyViewModel")
    }
    
    func handleKeyboardInput(symbol: KeyboardButtonType) {
        parseKeyboardInputToStringCurrency(symbol: symbol)
    }
    
    func updateTargetCurrency(currency: CurrencyType) {
        targetCurrency = currency
    }
}

// MARK: Logic of handling keyboard input
fileprivate extension EchangeCurrencyViewModel {
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
fileprivate extension EchangeCurrencyViewModel {
    func detectIfInputCurrencyDidChanged() {
        guard let targetCurrency = targetCurrency else { return }
        guard let convertedToDigit = Float(enteredValue) else { return }
        
        /// <lastCharIsDot> is the extra check for predicting user changes, may be omitted, but it helps prevent sending converting request faster than it needs if the user only wants to change the value after the dot
        guard !enteredValue.lastCharIsDot else { return }
        if enteredValueDigital != convertedToDigit {
            enteredValueDigital = convertedToDigit
        }
    }
    
    
    // TODO: - ...
    private func handleReceiveState(data: String) {
        observeReceivedData?(.success(data))
    }
}

// MARK: Handling of the new value
fileprivate extension EchangeCurrencyViewModel {
    func handleNewCurrency() {
        print(#function, enteredValueDigital)
    }
}
