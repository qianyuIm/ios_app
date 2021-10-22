//
//  AppShortcutItemHelper.swift
//  ios_app
//
//  Created by cyd on 2021/10/18.
//

import UIKit
enum AppShortcutItem: String {
    ///继续播放
    case play
    /// 查找
    case search
    /// 继续阅读
    case read
    /// wifi 传书
    case upload
    
    var type: String {
        switch self {
        case .play:
            return "com.qianyuIm.Shortcut.play"
        case .search:
            return "com.qianyuIm.Shortcut.search"
        case .read:
            return "com.qianyuIm.Shortcut.read"
        case .upload:
            return "com.qianyuIm.Shortcut.upload"
        }
    }
    var localizedTitle: String {
        switch self {
        case .play:
            return "继续播放"
        case .search:
            return "搜索"
        case .read:
            return "继续阅读"
        case .upload:
            return "wifi 传书"
        }
    }
    var localizedSubtitle: String? {
        return nil
    }
    var icon: UIApplicationShortcutIcon {
        switch self {
        case .play:
            return UIApplicationShortcutIcon(type: .play)
        case .search:
            return UIApplicationShortcutIcon(type: .search)
        case .read:
            return UIApplicationShortcutIcon(type: .bookmark)
        case .upload:
            return UIApplicationShortcutIcon(type: .cloud)
        }
    }
}
class AppShortcutItemHelper {
    
    class func handleShortcutItem(_ shortcutItem: UIApplicationShortcutItem) -> Bool{
        switch shortcutItem.type {
        case AppShortcutItem.play.type:
            QYLogger.debug(AppShortcutItem.play.localizedTitle)
            break
        case AppShortcutItem.search.type:
            QYLogger.debug(AppShortcutItem.search.localizedTitle)
            break
        case AppShortcutItem.read.type:
            QYLogger.debug(AppShortcutItem.read.localizedTitle)
            break
        case AppShortcutItem.upload.type:
            QYLogger.debug(AppShortcutItem.upload.localizedTitle)
            break
        default:
            break
        }
        
        return true
    }
}
