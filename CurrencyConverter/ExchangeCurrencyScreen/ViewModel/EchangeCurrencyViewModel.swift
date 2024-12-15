//
//  ViewModel.swift
//  CurrencyConverter
//
//  Created by Ice on 15.12.2024.
//

import Foundation

final class EchangeCurrencyViewModel: EchangeCurrencyViewModelInterface {
    private let characterLimit: Int = 10
    private let symbolsAfterDot: Int = 2
    
    private var targetCurrency: CurrencyType? {
        didSet {
            handleNewUserCurrency()
        }
    }
    
    private var enteredValueDigital: Float = 0
    
    private var enteredValue: String = DigitalKeyboardSymbols.zero.string {
        didSet {
            observeInputData?(.success(enteredValue))
            handleNewUserCurrency()
        }
    }
    
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
extension EchangeCurrencyViewModel {
    fileprivate func allowKeyoardInput(symbol: KeyboardButtonType) -> Bool {
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
    
    fileprivate func parseKeyboardInputToStringCurrency(symbol: KeyboardButtonType) {
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
extension EchangeCurrencyViewModel {
    fileprivate func handleNewUserCurrency() {
        guard let targetCurrency = targetCurrency else { return }
        
        if let lastCharacter = enteredValue.last, lastCharacter == "." {
            return
        } else {
            let newCurrency: Float = Float(enteredValue) ?? 0
            if enteredValueDigital != newCurrency {
                if newCurrency.isZero {
                    print(#function, targetCurrency.description.sign, newCurrency)
                    
                } else {
                    print(#function, targetCurrency.description.sign, newCurrency)
                    enteredValueDigital = newCurrency
                    
                }
            }
            
            if newCurrency.isZero && !enteredValue.isEmpty {
                print("Cancel Request")
            }
        }
    }
    
    // TODO: - ...
    private func handleReceiveState(data: String) {
        observeReceivedData?(.success(data))
    }
}
