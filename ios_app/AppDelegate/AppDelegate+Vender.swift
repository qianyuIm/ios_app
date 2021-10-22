//
//  AppDelegate+Vender.swift
//  ios_app
//
//  Created by cyd on 2021/10/9.
//

import UIKit
import SwiftyBeaver

#if DEBUG
import MLeaksFinder
import FLEX
#endif
import SDWebImageWebPCoder
import SnapKit
import UserNotifications

extension AppDelegate {
    /// 配置第三方
    func _configurationVenders(_ launchOptions: [UIApplication.LaunchOptionsKey: Any]?) {
        _setupSwiftyBeaver()
        _setupAMap()
        _setupJiguang(launchOptions)
        _setupLeaksFinder()
        _setupFLEX()
        _setupSDWebImage()
    }
}

private extension AppDelegate {
    /// 需要科学上网 0.0
    func _setupSwiftyBeaver() {
        let console = ConsoleDestination()
        let file = FileDestination()
        let cloud = SBPlatformDestination(appID: "E9QvpZ",
                                          appSecret: "dgk3ia495p8ptyUZadYrf90qKNccusro",
                                          encryptionKey: "n0MdqbYlscczDdFabXUydjelovwqankE")
        console.minLevel = SwiftyBeaver.Level.verbose
        QYLogger.customLogger.addDestination(console)
        QYLogger.customLogger.addDestination(file)
        QYLogger.customLogger.addDestination(cloud)
        let filePath = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first ?? ""
        QYLogger.debug("filePath => \(filePath)")
        
    }
    func _setupAMap() {
        QYMapLocationManager.shared.configureAMap()
    }
    /// 极光
    func _setupJiguang(_ launchOptions: [UIApplication.LaunchOptionsKey: Any]?) {
        let entity = JPUSHRegisterEntity()
        if #available(iOS 12.0, *) {
            entity.types = Int(JPAuthorizationOptions.alert.rawValue) | Int(JPAuthorizationOptions.badge.rawValue) | Int(JPAuthorizationOptions.sound.rawValue) | Int(JPAuthorizationOptions.providesAppNotificationSettings.rawValue)
        } else {
            entity.types = Int(JPAuthorizationOptions.alert.rawValue) | Int(JPAuthorizationOptions.badge.rawValue) | Int(JPAuthorizationOptions.sound.rawValue)
        }
        JPUSHService.register(forRemoteNotificationConfig: entity, delegate: self)
        
        JPUSHService.setup(withOption: launchOptions, appKey: QYKeys.JG.key, channel: QYConfig.channel, apsForProduction: false, advertisingIdentifier: nil)
        JPUSHService.registrationIDCompletionHandler { (resCode, registrationID) in
            QYLogger.debug("registrationID == \(registrationID ?? "")")
        }
#if DEBUG
        JPUSHService.setAlias(QYConfig.alias, completion: nil, seq: 0)
#else
        JPUSHService.setLogOFF()
#endif
        /// linkConfig
        let linkConfig = JMLinkConfig()
        linkConfig.appKey = QYKeys.JG.key
        linkConfig.channel = QYConfig.channel
        JMLinkService.setup(with: linkConfig)
        if #available(iOS 14.0, *) {
            JMLinkService.pasteBoardEnable(false)
        }
        JMLinkService.registerHandler { (respone) in
            DispatchQueue.main.async {
                AppRouterHelper.registerLinkHandler(respone)
            }
        }
    }
    func _setupLeaksFinder() {
#if DEBUG
        NSObject.addClassNames(toWhitelist: ["UITextField",
                                             "FLEXNavigationController",
                                             "FLEXObjectExplorerViewController",
                                             "FLEXTableView",
                                             "FLEXScopeCarousel",
                                             "FLEXHierarchyViewController"])
#endif
    }
    func _setupFLEX() {
#if DEBUG
        FLEXManager.shared.showExplorer()
#endif
    }
    func _setupSDWebImage() {
        let webPCoder = SDImageWebPCoder.shared
        SDImageCodersManager.shared.addCoder(webPCoder)
    }
}

//MARK:推送 -- JPUSHRegisterDelegate
extension AppDelegate: JPUSHRegisterDelegate {
    /// 前台
    func jpushNotificationCenter(_ center: UNUserNotificationCenter!, willPresent notification: UNNotification!, withCompletionHandler completionHandler: ((Int) -> Void)!) {
        let userInfo = notification.request.content.userInfo
        if notification.request.trigger?.isKind(of: UNPushNotificationTrigger.self) == true {
            JPUSHService.handleRemoteNotification(userInfo)
        } else {
            QYLogger.debug("前台本地通知")
            AppNotificationHelper.handlerRemoteNotification(userInfo)
        }
        completionHandler(Int(UNNotificationPresentationOptions.alert.rawValue) | Int(UNNotificationPresentationOptions.sound.rawValue))
    }
    /// 后台
    func jpushNotificationCenter(_ center: UNUserNotificationCenter!, didReceive response: UNNotificationResponse!, withCompletionHandler completionHandler: (() -> Void)!) {
        let userInfo = response.notification.request.content.userInfo
        if response.notification.request.trigger?.isKind(of: UNPushNotificationTrigger.self) == true {
            JPUSHService.handleRemoteNotification(userInfo)
            AppNotificationHelper.handlerRemoteNotification(userInfo)
        } else {
            QYLogger.debug("后台本地通知")
            AppNotificationHelper.handlerRemoteNotification(userInfo)
        }
        completionHandler()
    }
    /// setting
    func jpushNotificationCenter(_ center: UNUserNotificationCenter!, openSettingsFor notification: UNNotification!) {
        QYLogger.debug(notification.request.content.userInfo)
    }
    
    func jpushNotificationAuthorization(_ status: JPAuthorizationStatus, withInfo info: [AnyHashable : Any]!) {
        QYLogger.debug("通知授权状态 => \(status.rawValue) info => \(String(describing: info))")
    }
    
}
