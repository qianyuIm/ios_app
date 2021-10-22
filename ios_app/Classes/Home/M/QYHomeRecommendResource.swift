//
//  QYHomeRecommendResource.swift
//  ios_app
//
//  Created by cyd on 2021/10/22.
//

import HandyJSON
/// 首页 -> 推荐歌单
class QYHomeRecommendResourceWrap: MusicBaseModel {
    var featureFirst: Bool = false
    var haveRcmdSongs: Bool = false
    var recommend: [MusicPlaylist]?
    required init() {}
}
