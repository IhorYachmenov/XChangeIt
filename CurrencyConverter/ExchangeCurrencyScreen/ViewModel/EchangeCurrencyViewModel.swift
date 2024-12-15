//
//  ViewModel.swift
//  CurrencyConverter
//
//  Created by Ice on 15.12.2024.
//

import Foundation

final class EchangeCurrencyViewModel: EchangeCurrencyViewModelInterface {
    private var targetCurrency: CurrencyType? {
        didSet {
            handleNewValue()
        }
    }
    
    private var enteredValueDigital: Float = 0
    
    private var enteredValue: String = "" {
        didSet {
            if enteredValue.isEmpty {
                observeInputData?(.success("0"))
            } else {
                observeInputData?(.success(enteredValue))
            }
            handleNewValue()
        }
    }
    
    var observeInputData: ((Result<String, any Error>) -> ())?
    var observeReceivedData: ((Result<String, Error>) -> ())?
    
    init() {}
    
    deinit {
        print(#function, "EchangeCurrencyViewModel")
    }
    
    func handleEnteredUserCurrencyValue(symbol: KeyboardButtonType) {
        switch symbol {
        case .symbol(let symbol):
            if symbol == "0" {
                if !enteredValue.isEmpty && enteredValue.first != "0" {
                    enteredValue.append(symbol)
                } else {
                    if enteredValue.last != "0" {
                        enteredValue.append(symbol)
                    }
                }
            } else {
                enteredValue.append(symbol)
            }
        case .dot:
            guard !enteredValue.contains(symbol.symbol) else { return }
            enteredValue.append(symbol.symbol)
        case .delete:
            guard !enteredValue.isEmpty else { return }
            enteredValue.removeLast()
        }
    }
    
    func updateTargetCurrency(currency: CurrencyType) {
        targetCurrency = currency
    }
    
    private func handleNewValue() {
        guard let targetCurrency = targetCurrency else { return }
        
        if let lastCharacter = enteredValue.last, lastCharacter == "." {
            return
        } else {
            let newCurrency: Float = Float(enteredValue) ?? 0
            if enteredValueDigital != newCurrency {
                if newCurrency.isZero {
                    print(#function, targetCurrency.description.sign, newCurrency)
                    handleReceiveState(data: "0")
                } else {
                    print(#function, targetCurrency.description.sign, newCurrency)
                    enteredValueDigital = newCurrency
                    handleReceiveState(data: String(newCurrency))
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
