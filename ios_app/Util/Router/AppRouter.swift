//
//  AppRouter.swift
//  ios_app
//
//  Created by cyd on 2021/10/18.
//

import Foundation
import URLNavigator


/// 可以作为参数回调
typealias AppRouterContextCompletionHandler = ((_ any: Any?) -> Void)

class AppRouterContext {
    var completionHandler: AppRouterContextCompletionHandler?
}

class AppRouter {
    /// 单例
    class var shared: AppRouter {
        struct Static {
            static let kbRouter = AppRouter()
        }
        return Static.kbRouter
    }
    private var navigator: Navigator
    private var routerProvider: AppRouterProvider<AppRouterType>
    private init() {
        navigator = Navigator()
        routerProvider = AppRouterProvider(navigator: navigator, [
            AppRouterLaunchPlugin(),
            AppRouterAccountPlugin()
        ])
        
    }
    /// 初始化 空实现
    func initRouter() {}
    
}

extension AppRouter {
    @discardableResult
    func open(_ url: URLConvertible, context: AppRouterContext? = nil) -> Bool {
        
        return routerProvider.open(url, context: context)
    }
}


