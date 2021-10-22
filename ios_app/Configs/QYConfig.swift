//
//  QYConfig.swift
//  ios_app
//
//  Created by cyd on 2021/10/14.
//

import Foundation

struct QYConfig {
    /// 启动页面展示 前后台时间间隔  默认: 60 * 3 s
    static let showEnterForegroundAdTimeInterval: Double = 10 * 3
    static let channel = "pgy"
    static let alias = "ios_app"
    static let appVersion = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String ?? "Unknown"
    static let scheme = "iosApp://"
    static let userAgent = "ios_app/\(appVersion)"
    struct Notification {
        /// 只有 category 匹配才会使用 NotificationContentExtension
        static let contentExtensionCategory = "contentExtensionCategory"
        static let serviceExtensionCategory = "serviceExtensionCategory"
        static let notInterestedActionIdentifier = "notInterestedAction"
        static let openActionIdentifier = "openAction"
        static let mediaType = "mediaType"
        static let mediaUrl = "mediaUrl"
        static let mediaHeight = "mediaHeight"
        static let amount = "amount"
        /// 原生目标路径 与 targetUrl 互斥
        static let targetPage = "targetPage"
        /// H5目标路径 与 targetPage 互斥
        static let targetUrl = "targetUrl"
    }
    
}
