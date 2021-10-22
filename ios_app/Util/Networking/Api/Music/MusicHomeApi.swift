//
//  QYMusicHomeApi.swift
//  ios_app
//
//  Created by cyd on 2021/10/20.
//

import Foundation
import Moya

extension MusicHomeApi: MusicResponseHandle {}


enum MusicHomeApi {
    /// 首页菜单列表
    case banner
    /// 每日推荐歌单(需要登录)
    case recommendResource
    /// 每日推荐歌曲(需要登录)
    case recommendSongs
}

extension MusicHomeApi: TargetType {
    var baseURL: URL {
        return URL(string: AppApi.NeteaseCloud.baseUrl)!
    }
    
    var path: String {
        switch self {
        case .banner:
            return "/banner"
        case .recommendResource:
            return "/recommend/resource"
        case .recommendSongs:
            return "/recommend/songs"
        }
    }
    
    var method: Moya.Method {
        return .get
    }
    
    var sampleData: Data {
        switch self {
        case .banner:
            return AppHelper.localJsonData(for: "music_home_banner")
            
        default:
            return Data()
        }
        
    }
    
    var task: Task {
        switch self {
        case .banner:
            let parameters = ["type":2]
            return .requestParameters(parameters: parameters, encoding: URLEncoding.default)
        default:
            return .requestPlain
        }
    }
     
    var headers: [String : String]? {
        return nil
    }
    
    
}

