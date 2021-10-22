//
//  QYHomeBanner.swift
//  ios_app
//
//  Created by cyd on 2021/10/22.
//

import HandyJSON
/// 首页banner
class QYHomeBannerWrap: MusicBaseModel {
    var banners: [QYHomeBanner]?
    required init() {}
}

class QYHomeBanner: HandyJSON {
    var adDispatchJson: String?
    var adid: String?
    var adLocation: String?
    var adSource: String?
    var adurlV2: String?
    var alg: String?
    var bannerId: String?
    var dynamicVideoData: String?
    var encodeId: String?
    var event: String?
    var exclusive: Bool = false
    var extMonitor: String?
    var extMonitorInfo: String?
    var monitorBlackList: String?
    var monitorClick: String?
    var monitorImpress: String?
    var monitorType: String?
    var pic: String?
    var pid: String?
    var program: String?
    var requestId: String?
    var scm: String?
    var showAdTag: Bool = false
    var showContext: String?
    var song: String?
    var targetId: Int = 0
    var targetType: Int = 0
    var titleColor: String?
    var typeTitle: String?
    var url: String?
    var video: String?
    
    required init() {}
}
