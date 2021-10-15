//
//  QYDefaultKeys.swift
//  ios_app
//
//  Created by cyd on 2021/10/12.
//

import Foundation
import SwiftyUserDefaults

extension DefaultsKeys {
    /// 进入后台时间
    var enterBackgroundTimeKey: DefaultsKey<Double> { .init("kEnterBackgroundKey", defaultValue: 0) }
    /// 进入前台时间
    var enterForegroundTimeKey: DefaultsKey<Double> { .init("kEnterForegroundKey", defaultValue: 0) }
    
    /// 是否为夜间模式
    var themeDarkKey: DefaultsKey<Bool> { .init("kThemeDarkKey", defaultValue: false) }
    /// 主题
    var themeIndexKey: DefaultsKey<Int> { .init("kThemeIndexKey", defaultValue: 0) }

}
