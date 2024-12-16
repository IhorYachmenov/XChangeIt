//
//  UIViewController+Header.swift
//  CurrencyConverter
//
//  Created by Ice on 13.12.2024.
//

import UIKit

extension UIViewController {
    func detailsScreenNavigationHeader(backButtonImage: UIImage?, action: Selector, title: String) {
        let backButton = UIButton(type: .custom)
        backButton.setImage(backButtonImage, for: .normal)
        backButton.addTarget(self, action: action, for: .touchUpInside)
        let navigationItem = UIBarButtonItem(customView: backButton)
        navigationItem.style = .done
        self.navigationItem.leftBarButtonItem = navigationItem
        self.navigationItem.title = title
    }
}
