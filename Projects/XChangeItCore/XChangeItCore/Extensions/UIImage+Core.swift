//
//  UIImage+Core.swift
//  XChangeItCore
//
//  Created by Ice on 29.01.2025.
//

import UIKit

extension UIImage {
    fileprivate class CoreMedia {}
    
    public convenience init?(namedInCore: String) {
        self.init(named: namedInCore, in: Bundle(for: CoreMedia.self), compatibleWith: nil)
    }
}
