//
//  AppLinks.swift
//  ios_app
//
//  Created by cyd on 2021/10/18.
//

import URLNavigator
import UIKit
import CoreMedia


enum AppRouterOpenPage: String {
    case unknown
    // universal?openPage=web&webUrl=https://www.baidu.com&needlogin=1
    case web
}

enum AppRouterType {
    /// iosApp://universal?
    case universal
    /// iosApp://universalNeedLogin?
    case universal_needlogin
    /// iosApp://user?
    case user
}

extension QYBaseController: AppRouterable {}

extension AppRouterType: AppRouterTypeable {
    var pattern: String {
        switch self {
        case .universal:
            return QYConfig.scheme + "universal"
        case .universal_needlogin:
            return QYConfig.scheme + "universalNeedLogin"
        case .user:
            return QYConfig.scheme + "user"
        }
    }
    func controller(url: URLConvertible, values: [String : Any], context: AppRouterContext?) -> AppRouterable? {
        switch self {
        case .user:
            return QYBaseController()
        default:
            return nil
        }
    }
    
    func handle(url: URLConvertible, values: [String : Any], context: AppRouterContext?) {
        let parameters = url.queryParameters
        guard let openPage = parameters[QYConfig.Router.pageKey] else { return }
        let page = AppRouterOpenPage(rawValue: openPage) ?? .unknown
        _handle(page: page, parameters)
    }
    
}

extension AppRouterType {
    ///
    func _handle(page: AppRouterOpenPage,_ parameters: [String: String]) {
        switch page {
        case .web:
            guard let webUrl = parameters[QYConfig.Router.webUrlKey] else {
                return
            }
            let webVC = QYBaseWebController()
            webVC.webUrl = webUrl
            webVC.routerOpen(with: nil)
            break
        default:
            break
        }
    }
}
