//
//  AppDelegate+Internal.swift
//  ios_app
//
//  Created by cyd on 2021/10/9.
//

import UIKit

extension AppDelegate {
    
    /// 内部配置
    func _configurationInterna(_ launchOptions: [UIApplication.LaunchOptionsKey: Any]?) {
        _setupReachability()
        _configNavigationBar()
        _initializeRoot()
        _displayAd()
        _alertLaunchPrivacy()
    }
}

private extension AppDelegate {
    
    func _setupReachability() {
        QYReachability.shared.startNotifier()
    }
    
    func _configNavigationBar() {
        let navigationBar = UINavigationBar.appearance()
        navigationBar.shadowImage = UIImage()
        appThemeProvider.rx
            .bind({ $0.navigationBarTheme.tintColor}, to: navigationBar.rx.tintColor)
            .bind({ $0.navigationBarTheme.barTintColor }, to: navigationBar.rx.barTintColor)
            .bind({ $0.navigationBarTheme.barStyle}, to: navigationBar.rx.barStyle)
            .bind({ [NSAttributedString.Key.foregroundColor: $0.navigationBarTheme.foregroundColor,NSAttributedString.Key.font: QYFont.fontSemibold(18),] }, to: navigationBar.rx.titleTextAttributes)
            .disposed(by: rx.disposeBag)
    }
    
    func _initializeRoot() {
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.backgroundColor = UIColor.white
        let tabbar = QYTabBarController()
        window?.rootViewController = tabbar
        window?.makeKeyAndVisible()
    }
    func _displayAd() {
        launchAd = QYLaunchAd()
        launchAd?.start()
    }
    /// 启动隐私协议
    func _alertLaunchPrivacy() {
        
    }
}
