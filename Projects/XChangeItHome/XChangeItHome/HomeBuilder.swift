//
//  HomeBuilder.swift
//  XChangeItHome
//
//  Created by Ice on 29.01.2025.
//

public final class HomeBuilder {
    public init() {}
    
    public func build(navigationDelegate: HomeVCNavigationDelegate) -> HomeViewController {
        let vc = HomeViewController()
        vc.navigationDelegate = navigationDelegate
        return vc
    }
}
