//
//  AppDelegate+Internal.swift
//  ios_app
//
//  Created by cyd on 2021/10/9.
//

import UIKit

extension AppDelegate {
    static var shared: AppDelegate {
        return UIApplication.shared.delegate as! AppDelegate
    }
    /// 内部配置
    func _configurationInterna(_ launchOptions: [UIApplication.LaunchOptionsKey: Any]?) {
        _setupShortcutItems()
        _setupRouter()
        _setupReachability()
        _configNavigationBar()
        _initializeRoot()
        _displayAd()
        _alertLaunchPrivacy()
    }
    /// 3D touch
    func handleShortcutItem(_ shortcutItem: UIApplicationShortcutItem) -> Bool {
        return AppShortcutItemHelper.handleShortcutItem(shortcutItem)
    }
    
    
}

private extension AppDelegate {
    func _setupShortcutItems() {
        var myShortcutItems: [UIApplicationShortcutItem] = []
        for item in [AppShortcutItem.play, AppShortcutItem.search, AppShortcutItem.read,AppShortcutItem.upload] {
            myShortcutItems.append(UIApplicationShortcutItem(type: item.type, localizedTitle: item.localizedTitle, localizedSubtitle: item.localizedSubtitle, icon: item.icon))
        }
        UIApplication.shared.shortcutItems = myShortcutItems
    }
    /// 路由
    func _setupRouter() {
        AppRouter.shared.initRouter()
    }
    /// 网络监控
    func _setupReachability() {
        QYReachability.shared.startNotifier()
    }
    /// 导航
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
    /// root
    func _initializeRoot() {
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.backgroundColor = UIColor.white
        let tabbar = QYTabBarController()
        window?.rootViewController = tabbar
        window?.makeKeyAndVisible()
    }
    /// launch
    func _displayAd() {
        launchAd = QYLaunchAd()
        launchAd?.start()
    }
    
    /// 启动隐私协议
    func _alertLaunchPrivacy() {
        
    }
}
