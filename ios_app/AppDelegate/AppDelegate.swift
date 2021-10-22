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
    /// 是否启动
    var isLaunched: Bool = false
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        _configurationVenders(launchOptions)
        _configurationInterna(launchOptions)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            self.isLaunched = true
            NotificationCenter.AppDelegate.post(.launched)
        }
        
        return true
    }
    
    //MARK: --- 进入后台
    func applicationDidEnterBackground(_ application: UIApplication) {
        application.applicationIconBadgeNumber = 0
    }
    //MARK: --- 将要进入前台
    func applicationWillEnterForeground(_ application: UIApplication) {
        application.applicationIconBadgeNumber = 0
    }
    //MARK: --- 3D touch
    func application(_ application: UIApplication, performActionFor shortcutItem: UIApplicationShortcutItem, completionHandler: @escaping (Bool) -> Void) {
        completionHandler(handleShortcutItem(shortcutItem))
    }
    //MARK: -- 通过url scheme来唤起app
    func application(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey : Any] = [:]) -> Bool {
        QYLogger.debug("url scheme open")
        return JMLinkService.routeMLink(url)
    }
    //MARK: -- 通过universal link 来唤起app
    func application(_ application: UIApplication, continue userActivity: NSUserActivity, restorationHandler: @escaping ([UIUserActivityRestoring]?) -> Void) -> Bool {
        QYLogger.debug("universal link")
        return JMLinkService.continue(userActivity)
    }
    //MARK: -- 推送 deviceToken
    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        JPUSHService.registerDeviceToken(deviceToken)
    }
    func application(_ application: UIApplication, didFailToRegisterForRemoteNotificationsWithError error: Error) {
        QYLogger.error("注册通知失败 error == \(error)")
    }
}


