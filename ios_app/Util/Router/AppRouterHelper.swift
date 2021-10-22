//
//  QYRouterHelper.swift
//  ios_app
//
//  Created by cyd on 2021/10/18.
//

import Foundation
import URLNavigator
import SwifterSwift

extension QYConfig {
    /// 路由配置
    struct Router {
        /// 需要打开的页面对应的key值
        static let pageKey = "openPage"
        /// 是否需要登录对应的key值
        static let loginKey = "needlogin"
        /// 是否需要登录对应的value值
        static let loginValue = "1"
        /// web链接 对应的key值
        static let webUrlKey = "webUrl"
    }
}


class AppRouterHelper {
    /// 参数的话需要H5端配合，所以就固定跳转几个页面好了
    /// 都为 iosApp://universal? 开头
    /// iosApp://universal?page=user&login=1
    class func registerLinkHandler(_ response: JMLinkResponse?) {
        guard let response = response else { return }
        guard let params = response.params as? [String: String] else { return }
        if let needlogin = params[QYConfig.Router.loginKey], needlogin == QYConfig.Router.loginValue{
            guard let schemeUrl = URL(string: AppRouterType.universal_needlogin.pattern) else { return }
            let routerUrl = schemeUrl.appendingQueryParameters(params)
            AppRouter.shared.open(routerUrl)
        } else {
            guard let schemeUrl = URL(string: AppRouterType.universal.pattern) else { return }
            let routerUrl = schemeUrl.appendingQueryParameters(params)
            AppRouter.shared.open(routerUrl)
        }
       
    }
    
}
