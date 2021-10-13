//
//  AppTheme+App.swift
//  ios_app
//
//  Created by cyd on 2021/10/11.
//

import Foundation
import RxSwift
import RxCocoa
import ESTabBarController_swift

extension Reactive where Base: ESTabBarItemContentView {
    var iconColor: Binder<UIColor> {
        return Binder(self.base) { view, attr in
            view.iconColor = attr
            view.updateDisplay()
        }
    }
    var textColor: Binder<UIColor> {
        return Binder(self.base) { view, attr in
            view.textColor = attr
            view.updateDisplay()
        }
    }
    var highlightTextColor: Binder<UIColor> {
        return Binder(self.base) { view, attr in
            view.highlightTextColor = attr
            view.updateDisplay()
        }
    }
    var highlightIconColor: Binder<UIColor> {
        return Binder(self.base) { view, attr in
            view.highlightIconColor = attr
            view.updateDisplay()
        }
    }
    
}
extension Reactive where Base: UITabBar {

    /// Bindable sink for `backgroundColor` property
    var backgroundColor: Binder<UIColor?> {
        return Binder(self.base) { view, attr in
            view.backgroundColor = attr
        }
    }

}

extension Reactive where Base: UIApplication {

    var statusBarStyle: Binder<UIStatusBarStyle> {
        return Binder(self.base) { view, attr in
            globalStatusBarStyle.accept(attr)
        }
    }
}
extension Reactive where Base: UIView {
    var backgroundColor: Binder<UIColor?> {
        return Binder(self.base) { view, attr in
            view.backgroundColor = attr
        }
    }
}
