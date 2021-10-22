//
//  MusicCreator.swift
//  ios_app
//
//  Created by cyd on 2021/10/22.
//

import Foundation
import HandyJSON
/// 歌单 -> 创建者
class MusicCreator: HandyJSON {
    var accountStatus: Int = 0
    var authority: Int = 0
    var authStatus: Int = 0
    var avatarImgId: Int = 0
    var avatarImgIdStr: String?
    var avatarUrl: String?
    var backgroundImgId: Int = 0
    var backgroundImgIdStr: String?
    var backgroundUrl: String?
    var birthday: Int = 0
    var city: Int = 0
    var defaultAvatar: Bool = false
    var description: String?
    var detailDescription: String?
    var djStatus: Int = 0
    var expertTags = [String]()
    var followed: Bool = false
    var gender: Int = 0
    var mutual: Bool = false
    var nickname: String?
    var province: Int = 0
    var remarkName: String?
    var signature: String?
    var userId: Int = 0
    var userType: Int = 0
    var vipType: Int = 0
    required init() {}
}
