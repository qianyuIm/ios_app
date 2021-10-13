//
//  AppThemeManager.swift
//  ios_app
//
//  Created by cyd on 2021/10/11.
//

import Foundation
import UIKit
import RxTheme
import SwifterSwift
import RxSwift
import RxCocoa
import SwiftyUserDefaults
/// 主题配置
let appThemeProvider = AppThemeProvider.service(initial: AppThemeProvider.currentTheme())

private func _value() -> UIStatusBarStyle {
    var value: UIStatusBarStyle
    if #available(iOS 13.0, *) {
        value = .darkContent
    } else {
        value = .default
    }
    let isDark = Defaults[\.themeDarkKey]
    if (isDark) {
        value = .lightContent
    }
    return value
}
let globalStatusBarStyle = BehaviorRelay<UIStatusBarStyle>(value: _value())

protocol AppThemeProtocol {
    /// tabbar 主题
    var tabbarTheme: TabbarTheme { get }
    /// navigationBar 主题
    var navigationBarTheme: NavigationBarTheme { get }
    /// 背景色
    var backgroundColor: UIColor { get }
    /// statusBar
    var statusBarStyle: UIStatusBarStyle { get }
    
    init(colorSwatch: AppColorSwatch)
}

struct AppLightTheme: AppThemeProtocol {
    var tabbarTheme: TabbarTheme
    var navigationBarTheme: NavigationBarTheme
    let backgroundColor = UIColor(hexString: "#F2F2F7")!
    var statusBarStyle: UIStatusBarStyle

    init(colorSwatch: AppColorSwatch) {

        if #available(iOS 13.0, *) {
            statusBarStyle = .darkContent
        } else {
            statusBarStyle = .default
        }
        
        tabbarTheme = TabbarTheme(
            textColor: UIColor(hexString: "#929292")!,
            highlightTextColor: UIColor(hexString: "#F83245")!,
            iconColor: UIColor(hexString: "#929292")!,
            highlightIconColor: UIColor(hexString: "#F83245")!,
            backgroundColor: UIColor.white)
        navigationBarTheme = NavigationBarTheme(
            barTintColor: UIColor.white,
            tintColor: UIColor(hexString: "#3C3C3C")!,
            foregroundColor: UIColor(hexString: "#3C3C3C")!,
            barStyle: UIBarStyle.default)
    }
}

struct AppDarkTheme: AppThemeProtocol {
    var tabbarTheme: TabbarTheme
    var navigationBarTheme: NavigationBarTheme
    let backgroundColor = UIColor(hexString: "#323232")!
    let statusBarStyle: UIStatusBarStyle = .lightContent

    init(colorSwatch: AppColorSwatch) {
        
        tabbarTheme = TabbarTheme(
            textColor: UIColor(hexString: "#929292")!,
            highlightTextColor: UIColor(hexString: "#929292")!,
            iconColor: UIColor(hexString: "#929292")!,
            highlightIconColor: UIColor(hexString: "#929292")!,
            backgroundColor: UIColor(hexString: "#252528")!)
        navigationBarTheme = NavigationBarTheme(
            barTintColor: UIColor(hexString: "#252528")!,
            tintColor: UIColor.white,
            foregroundColor: UIColor.white,
            barStyle: UIBarStyle.black
        )
    }
}

enum AppColorSwatch: Int {
    case netease, didi, weChat, fish, quark

    static let allValues = [netease, didi, weChat, fish, quark]

    var color: UIColor {
        switch self {
        case .netease: return UIColor.Material.red
        case .didi: return UIColor.Material.pink
        case .weChat: return UIColor.Material.purple
        case .fish: return UIColor.Material.deepPurple
        case .quark: return UIColor.Material.indigo
        
        }
    }

    var colorDark: UIColor {
        switch self {
        case .netease: return UIColor.Material.red
        case .didi: return UIColor.Material.pink
        case .weChat: return UIColor.Material.purple
        case .fish: return UIColor.Material.deepPurple
        case .quark: return UIColor.Material.indigo
        }
    }

    var title: String {
        switch self {
        case .netease: return "网易红"
        case .didi: return "滴滴橙"
        case .weChat: return "微信绿"
        case .fish: return "闲鱼黄"
        case .quark: return "夸克紫"
        }
    }
}
enum AppThemeProvider: ThemeProvider {
    
    
    case light(colorSwatch: AppColorSwatch)
    case dark(colorSwatch: AppColorSwatch)
    var associatedObject: AppThemeProtocol {
        switch self {
        case .light(let colorSwatch): return AppLightTheme(colorSwatch: colorSwatch)
        case .dark(let colorSwatch): return AppDarkTheme(colorSwatch: colorSwatch)
        }
    }
    var isDark: Bool {
        switch self {
        case .dark: return true
        default: return false
        }
    }

    func toggled() -> AppThemeProvider {
        var theme: AppThemeProvider
        switch self {
        case .light(let colorSwatch): theme = AppThemeProvider.dark(colorSwatch: colorSwatch)
        case .dark(let colorSwatch): theme = AppThemeProvider.light(colorSwatch: colorSwatch)
        }
        theme.save()
        return theme
    }

    func withColor(colorSwatch: AppColorSwatch) -> AppThemeProvider {
        var themeProvider: AppThemeProvider
        switch self {
        case .light: themeProvider = AppThemeProvider.light(colorSwatch: colorSwatch)
        case .dark: themeProvider = AppThemeProvider.dark(colorSwatch: colorSwatch)
        }
        themeProvider.save()
        return themeProvider
    }
    
}
extension AppThemeProvider {
    static func currentTheme() -> AppThemeProvider {
        let isDark = Defaults[\.themeDarkKey]
        let themeKey = Defaults[\.themeIndexKey]
        let colorSwatch = AppColorSwatch(rawValue: themeKey) ?? AppColorSwatch.netease
        let theme = isDark ? AppThemeProvider.dark(colorSwatch: colorSwatch) : AppThemeProvider.light(colorSwatch: colorSwatch)
        theme.save()
        return theme
    }

    func save() {
        Defaults[\.themeDarkKey] = self.isDark
        switch self {
        case .light(let colorSwatch): Defaults[\.themeIndexKey] = colorSwatch.rawValue
        case .dark(let colorSwatch): Defaults[\.themeIndexKey] = colorSwatch.rawValue
        }
    }
}
