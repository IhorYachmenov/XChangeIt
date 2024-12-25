//
//  UIViewController+Sheet.swift
//  XChangeIt
//
//  Created by Ice on 18.12.2024.
//

import UIKit

extension UIViewController {
    func presentSheetController(_ viewController: UIViewController) {
        let navigationVC = UINavigationController(rootViewController: viewController)
        
        if let sheet = navigationVC.sheetPresentationController {
            sheet.detents = [.medium(), .large()]
            sheet.preferredCornerRadius = 24
            sheet.prefersScrollingExpandsWhenScrolledToEdge = false
            sheet.prefersGrabberVisible = true
            sheet.prefersEdgeAttachedInCompactHeight = true
            
            sheet.widthFollowsPreferredContentSizeWhenEdgeAttached = true
        }
        present(navigationVC, animated: true, completion: nil)
    }
}
