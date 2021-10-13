//
//  AppTheme.swift
//  ios_app
//
//  Created by cyd on 2021/10/11.
//

import UIKit
import Lottie

/// tabbar主题配置
class TabbarTheme {
    let textColor: UIColor
    let highlightTextColor: UIColor
    let iconColor: UIColor
    let highlightIconColor: UIColor
    let backgroundColor: UIColor
    init(textColor: UIColor,
         highlightTextColor: UIColor,
         iconColor: UIColor,
         highlightIconColor: UIColor,
         backgroundColor: UIColor) {
        self.textColor = textColor
        self.highlightTextColor = highlightTextColor
        self.iconColor = iconColor
        self.highlightIconColor = highlightIconColor
        self.backgroundColor = backgroundColor
    }
}
class NavigationBarTheme {
    let barTintColor: UIColor
    let tintColor: UIColor
    let foregroundColor: UIColor
    let barStyle: UIBarStyle
    init(barTintColor: UIColor,
         tintColor: UIColor,
         foregroundColor: UIColor,
         barStyle: UIBarStyle) {
        self.barTintColor = barTintColor
        self.tintColor = tintColor
        self.foregroundColor = foregroundColor
        self.barStyle = barStyle

    }
}
