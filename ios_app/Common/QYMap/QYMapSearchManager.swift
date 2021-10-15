//
//  QYMapSearchManager.swift
//  ios_app
//
//  Created by cyd on 2021/10/15.
//

import Foundation
import AMapSearchKit
/// 地图搜索管理者
class QYMapSearchManager {
    /// 单例
    class var shared: QYMapSearchManager {
        struct Static {
            static let kbPhotoManager = QYMapSearchManager()
        }
        return Static.kbPhotoManager
    }
    private override init() {
        super.init()
    }
}
