//
//  QYNotification.swift
//  QianyuIm
//
//  Created by cyd on 2020/7/14.
//  Copyright © 2020 qianyuIm. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

enum QYNotification: String {
    /// 书架变动
    case bookShelf
    
    var stringValue: String {
        return "QY" + rawValue
    }
    var name: NSNotification.Name {
        return NSNotification.Name(stringValue)
    }
}
extension NotificationCenter {
    func post(customeNotification name: QYNotification, object: Any? = nil,
                     userInfo: [AnyHashable: Any]? = nil) {
        post(name: name.name, object: object, userInfo: userInfo)
    }
}
extension Reactive where Base: NotificationCenter {
    func notification(custom name: QYNotification, object: AnyObject? = nil) -> Observable<Notification> {
        return notification(name.name, object: object)
    }
}
