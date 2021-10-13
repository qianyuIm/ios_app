//
//  QYNavigationController.swift
//  ios_app
//
//  Created by cyd on 2021/10/11.
//

import UIKit
import HBDNavigationBar
extension UIViewController {
    /// 导航按钮返回点击
    @objc func navigationPopOnBackItemClick() {
        self.navigationController?.popViewController(animated: true)
    }
}
class QYNavigationController: HBDNavigationController {
    
    override var childForStatusBarStyle: UIViewController? {
        return topViewController
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
    }
    override func pushViewController(_ viewController: UIViewController, animated: Bool) {
        let count = self.viewControllers.count
        if count > 0 {
            viewController.hidesBottomBarWhenPushed = true
            let image = R.image.icon_navigation_back_black()
            viewController.navigationItem.leftBarButtonItem = UIBarButtonItem(image: image, style: .done, target: self, action: #selector(backWardAction))
        }
        super.pushViewController(viewController, animated: animated)
    }
    @objc func backWardAction() {
        let topVc = self.topViewController
        topVc?.navigationPopOnBackItemClick()
    }
    
}
