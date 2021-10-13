//
//  QYTabBarController.swift
//  ios_app
//
//  Created by cyd on 2021/10/11.
//

import UIKit
import ESTabBarController_swift
import Localize_Swift
class QYTabBarController: ESTabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        let homeViewModel = QYHomeViewModel()
        let home = _setController(
            controller: QYHomeController(viewModel: homeViewModel),
            lottieName: "tab_home",
            title: R.string.localizable.tabbarHome.key.localized(),
            normalImage: R.image.icon_tabbar_home_norm(),
            selectImage: R.image.icon_tabbar_home_seleted())
        
        let bookRackViewModel = QYBookRackViewModel()
        let novel = _setController(
            controller: QYBookRackController(viewModel: bookRackViewModel),
            lottieName: "tab_bookRack",
            title: R.string.localizable.tabbarBookRack.key.localized(),
            normalImage: R.image.icon_tabbar_community_norm(),
            selectImage: R.image.icon_tabbar_community_seleted())
        
        let productViewModel = QYProductViewModel()
        let product = _setController(
            controller: QYProductController(viewModel: productViewModel),
            lottieName: "tab_product",
            title: R.string.localizable.tabbarProduct.key.localized(),
            normalImage: R.image.icon_tabbar_buy_norm(),
            selectImage: R.image.icon_tabbar_buy_seleted())
        
        let videoViewModel = QYVideoViewModel()
        let video = _setController(
            controller: QYVideoController(viewModel: videoViewModel),
            lottieName: "tab_video",
            title: R.string.localizable.tabbarVideo.key.localized(),
            colorKeyPath: .combine,
            normalImage: R.image.icon_tabbar_video_norm(),
            selectImage: R.image.icon_tabbar_video_seleted())
        
        let userViewModel = QYUserViewModel()
        let user = _setController(
            controller: QYUserController(viewModel: userViewModel),
            lottieName: "tab_user",
            title: R.string.localizable.tabbarUser.key.localized(),
            colorKeyPath: .fill,
            normalImage:R.image.icon_tabbar_user_norm(),
            selectImage: R.image.icon_tabbar_user_seleted())
        
        self.viewControllers = [home, novel, product, video, user]
        appThemeProvider.rx
            .bind({ $0.tabbarTheme.backgroundColor}, to: tabBar.rx.backgroundColor)
            .disposed(by: rx.disposeBag)
    }
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        guard
            #available(iOS 13.0, *),
            traitCollection.hasDifferentColorAppearance(comparedTo: previousTraitCollection)
            else { return }
        
        _updateTheme()
    }
    
    
    
   

}

private extension QYTabBarController {
     func _updateTheme() {
        guard #available(iOS 12.0, *) else { return }
        
        switch traitCollection.userInterfaceStyle {
        case .light:
            QYLogger.debug("切换到明亮模式")
        case .dark:
            QYLogger.debug("切换到暗黑模式")
        case .unspecified:
            break
        @unknown default:
            break
        }
    }
    func _setController(controller: QYBaseVMController,
                    lottieName:String,
                    title: String,
                    colorKeyPath: LottieColorKeyPath = LottieColorKeyPath.stroke,
                    normalImage: UIImage?,
                    selectImage: UIImage?) -> QYNavigationController {
        
        controller.tabBarItem = ESTabBarItem(QYLottieTabBarItemContentView(lottieName: lottieName, colorKeyPath: colorKeyPath), title: title, image: normalImage, selectedImage: selectImage)
        let na = QYNavigationController(rootViewController: controller)
        return na
    }
    
}
