//
//  AppRouterAccountPlugin.swift
//  ios_app
//
//  Created by cyd on 2021/10/20.
//

import Foundation
/// 授权插件 是否登录
class AppRouterAccountPlugin: AppRouterPlugin<AppRouterType> {
    override func prepare(open type: AppRouterType, completion: @escaping (Bool) -> Void) {
        guard type == .universal_needlogin else {
            QYLogger.debug("直接通过")
            completion(true)
            return
        }
        guard let root = AppDelegate.shared.window?.rootViewController else {
            completion(false)
            return
        }
        let login = QYLoginController.init { result in
            completion(result)
        }
        QYLogger.debug("需要登录才行")
        root.present(login, animated: true)
    }
    
}
