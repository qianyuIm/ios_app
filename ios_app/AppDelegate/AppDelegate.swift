//
//  AppDelegate.swift
//  ios_app
//
//  Created by cyd on 2021/10/9.
//

import UIKit
import RxTheme

@main
class AppDelegate: UIResponder, UIApplicationDelegate {


    var window: UIWindow?
    var launchAd: QYLaunchAd?
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        
        _configurationVenders(launchOptions)
        _configurationInterna(launchOptions)
        _initialize()
        return true
    }
    /// 必须保证最先初始化
    func _initialize() {
        let num: CGFloat = 103.3
        QYLogger.debug("num => \(QYInch.value(num))")
        
        
    }

    
}

