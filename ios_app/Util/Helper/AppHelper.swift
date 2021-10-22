//
//  AppHelper.swift
//  ios_app
//
//  Created by cyd on 2021/10/19.
//

import UIKit

class AppHelper {
    
    class func tabbarController() -> QYTabBarController? {
        guard let tabbarController = AppDelegate.shared.window?.rootViewController as? QYTabBarController else {
            return nil
        }
        return tabbarController
    }
    /// 顶层视图
    class var topMost: UIViewController? {
        return topMost(of: tabbarController())
    }
    /// Returns the top most view controller from given view controller's stack.
    class func topMost(of viewController: UIViewController?) -> UIViewController? {
        // presented view controller
        if let presentedViewController = viewController?.presentedViewController {
            return self.topMost(of: presentedViewController)
        }
        
        // UITabBarController
        if let tabBarController = viewController as? UITabBarController,
           let selectedViewController = tabBarController.selectedViewController {
            return self.topMost(of: selectedViewController)
        }
        
        // UINavigationController
        if let navigationController = viewController as? UINavigationController,
           let visibleViewController = navigationController.visibleViewController {
            return self.topMost(of: visibleViewController)
        }
        
        // UIPageController
        if let pageViewController = viewController as? UIPageViewController,
           pageViewController.viewControllers?.count == 1 {
            return self.topMost(of: pageViewController.viewControllers?.first)
        }
        
        // child view controller
        for subview in viewController?.view?.subviews ?? [] {
            if let childViewController = subview.next as? UIViewController {
                return self.topMost(of: childViewController)
            }
        }
        
        return viewController
    }
    /// 返回到根控制器
    class func toRootController(
        _ animated: Bool = true,
        _ selectedType: QYTabBarSelectedType? = nil) {
            guard let tabbarController = tabbarController() else {
                return
            }
            guard let topMost = topMost(of: tabbarController) else { return }
            guard let navigation = tabbarController.selectedViewController as? UINavigationController else { return }
            var controller: UIViewController? = topMost
            while controller?.presentingViewController != nil {
                controller = controller?.presentingViewController
            }
            if let selectedType = selectedType {
                tabbarController.selectedType = selectedType
            }
            controller?.dismiss(animated: animated, completion: {
                navigation.popToRootViewController(animated: false)
            })
        }
    
    /// 返回本地数据
    /// - Parameter file: 本地文件名
    /// - Returns:
    class func localJsonData(for file: String) -> Data {
        let jsonPath = Bundle.main.path(forResource: file, ofType: "json")
        let jsonUrl = URL(fileURLWithPath: jsonPath!)
        let data = try? Data(contentsOf: jsonUrl)
        return data ?? "".data(using: String.Encoding.utf8)!
    }
}
