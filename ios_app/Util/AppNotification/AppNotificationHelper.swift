//
//  QYNotificationHelper.swift
//  ios_app
//
//  Created by cyd on 2021/10/18.
//

import UIKit



class AppNotificationHelper {
    class func notificationCategories() -> Set<UNNotificationCategory> {
        var categories = Set<UNNotificationCategory>()
        let notInterestedAction = UNNotificationAction(identifier: QYConfig.Notification.notInterestedActionIdentifier, title: "不感兴趣", options: .destructive)
        let openAction = UNNotificationAction(identifier: QYConfig.Notification.openActionIdentifier, title: "点开查看", options: .foreground)
        //给category设置action
        let contentExtensionCategory = UNNotificationCategory(identifier: QYConfig.Notification.contentExtensionCategory, actions: [notInterestedAction, openAction], intentIdentifiers: [], options: [])
        //给category设置action
        let serviceExtensionCategory = UNNotificationCategory(identifier: QYConfig.Notification.serviceExtensionCategory, actions: [notInterestedAction, openAction], intentIdentifiers: [], options: [])
        categories.insert(contentExtensionCategory)
        categories.insert(serviceExtensionCategory)

        return categories
    }
    class func handlerRemoteNotification(_ userInfo: [AnyHashable : Any]) {
        
        UIApplication.shared.applicationIconBadgeNumber = 0
//        QYNavigatorHelp.handlerRemoteNotification(userInfo)
    }
    
}
