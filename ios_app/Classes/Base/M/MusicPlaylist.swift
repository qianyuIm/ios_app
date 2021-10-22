//
//  MusicPlaylist.swift
//  ios_app
//
//  Created by cyd on 2021/10/22.
//

import Foundation
import HandyJSON
/// 歌单 -> 公共
class MusicPlaylist: HandyJSON {
    var alg: String?
    var copywriter: String?
    var createTime: Int = 0
    var creator: MusicCreator?
    var id: Int = 0
    var name: String?
    var picUrl: String?
    var playcount: Int = 0
    var trackCount: Int = 0
    var type: Int = 0
    var userId: Int = 0
    required init() {}
}
