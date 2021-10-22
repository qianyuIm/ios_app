//
//  AppNotification.swift
//  ios_app
//
//  Created by cyd on 2021/10/21.
//

import Foundation

protocol AppNotificationable {
    associatedtype defaultKeys: RawRepresentable
}

extension NotificationCenter {
    enum AppDelegate: AppNotificationable {
        enum defaultKeys: String {
            case launched
        }
    }
}

extension AppNotificationable where defaultKeys.RawValue == String {
    static func post(_ name: defaultKeys, object: Any? = nil, userInfo: [AnyHashable: Any]? = nil)  {
        
        NotificationCenter.default.post(
            name: conversion(name),
            object: object,
            userInfo: userInfo
        )
    }
    
    static func add(_ name: defaultKeys, observer: Any, selector: Selector, object: Any? = nil)  {
        NotificationCenter.default.addObserver(
            observer,
            selector: selector,
            name: conversion(name),
            object: object
        )
    }
    
    static func add(_ name: defaultKeys,
                    _ object: Any? = nil,
                    queue: OperationQueue = .main,
                    using block: @escaping (Notification) -> Void)  {
        NotificationCenter.default.addObserver(
            forName: conversion(name),
            object: object,
            queue: .main,
            using: block
        )
    }
    
    static func remove(_ name: defaultKeys, observer: Any, object: Any? = nil)  {
        NotificationCenter.default.removeObserver(
            observer,
            name: conversion(name),
            object: object
        )
    }
    
    static private func conversion(_ key: defaultKeys) -> NSNotification.Name {
        return NSNotification.Name("\(self).\(key.rawValue)")
    }
}

