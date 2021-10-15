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

extension AppDelegate {
    /// 配置第三方
    func _configurationVenders(_ launchOptions: [UIApplication.LaunchOptionsKey: Any]?) {
        _setupSwiftyBeaver()
        _setupAMap()
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
