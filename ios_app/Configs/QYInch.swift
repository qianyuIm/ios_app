//
//  QYInch.swift
//  ios_app
//
//  Created by cyd on 2021/10/12.
//

import Foundation
import AutoInch

struct QYInch {
    static private var _isAdapter: Bool = false
    static func _adapter() {
        if (!_isAdapter) {
            _isAdapter = true
            Auto.set { origin in
                guard UIDevice.current.userInterfaceIdiom == .phone else {
                    return origin
                }
                let base = 375.0
                let screenWidth = Double(UIScreen.main.bounds.width)
                let screenHeight = Double(UIScreen.main.bounds.height)
                let width = min(screenWidth, screenHeight)
                let result = origin * (width / base)
                let scale = Double(UIScreen.main.scale)
                return (result * scale).rounded(.up) / scale
            }
        }
        
    }
    /// 是否为刘海屏  x 系列
    static let isFull: Bool = (AutoInch.Screen.isFull)
    /// 屏幕宽度
    static let screenWidth = UIScreen.main.bounds.width
    /// 屏幕高度
    static let screenHeight = UIScreen.main.bounds.height
    /// 比例
    static let scale = UIScreen.main.scale
    /// 适配
    static func value(_ value: CGFloat) -> CGFloat {
//        _adapter()
        return value.auto()
    }
}
