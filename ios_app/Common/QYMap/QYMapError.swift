//
//  QYLocationError.swift
//  ios_app
//
//  Created by cyd on 2021/10/15.
//

import Foundation

enum QYLocationError: Swift.Error {
    ///  未知错误
    case unknown
    /// 定位错误未开启权限
    case locateFailed
    /// 逆地理编码错误
    case reGeocodeFailed
    /// 取消定位请求
    case canceled
    /// 地理围栏错误
    case regionMonitoringFailure
    ///  存在虚拟定位风险
    case riskOfFakeLocation
}

extension QYLocationError: LocalizedError {
    public var errorDescription: String? {
        switch self {
        case .unknown:
            return "未知错误"
        case .locateFailed:
            return "定位错误"
        case .reGeocodeFailed:
            return "逆地理编码错误"
        case .canceled:
            return "取消定位请求"
        case .regionMonitoringFailure:
            return "地理围栏错误"
        case .riskOfFakeLocation:
            return "存在虚拟定位风险"
        }
    }
}

// MARK: - Error User Info

extension QYLocationError: CustomNSError {
    public var errorUserInfo: [String: Any] {
        var userInfo: [String: Any] = [:]
        userInfo[NSLocalizedDescriptionKey] = errorDescription
        return userInfo
    }
}
