//
//  QYLocationManager.swift
//  ios_app
//
//  Created by cyd on 2021/10/15.
//

import Foundation
import AMapLocationKit
import AMapFoundationKit

typealias QYMapLocationCompletionBlock = ((_ location: CLLocation?,_ regeocode:AMapLocationReGeocode?, _ error: QYLocationError?) -> Void)

/// 定位管理者
class QYMapLocationManager: NSObject {
    /// 定位精度
    var desiredAccuracy: CLLocationAccuracy = kCLLocationAccuracyHundredMeters {
        didSet {
            locationManager.desiredAccuracy = desiredAccuracy
        }
        
    }
    /// 指定定位是否会被系统自动暂停。默认为false。
    var pausesLocationUpdatesAutomatically: Bool = false {
        didSet {
            locationManager.pausesLocationUpdatesAutomatically = pausesLocationUpdatesAutomatically
        }
    }
    /// 是否允许后台定位
    var allowsBackgroundLocationUpdates: Bool = true {
        didSet {
            locationManager.stopUpdatingLocation()
            locationManager.allowsBackgroundLocationUpdates = allowsBackgroundLocationUpdates
        }
    }
    lazy var locationManager: AMapLocationManager = {
        let locationManager = AMapLocationManager()
        locationManager.delegate = self
        locationManager.desiredAccuracy = desiredAccuracy
        locationManager.allowsBackgroundLocationUpdates = allowsBackgroundLocationUpdates
        locationManager.locationTimeout = 5
        locationManager.reGeocodeTimeout = 3
        return locationManager
    }()
    /// 单例
    class var shared: QYMapLocationManager {
        struct Static {
            static let kbPhotoManager = QYMapLocationManager()
        }
        return Static.kbPhotoManager
    }
    
    
    private override init() {
        super.init()
    }
}
extension QYMapLocationManager {
    /// 配置
    func configureAMap() {
        AMapServices.shared().apiKey = QYKeys.AMap.key
    }
    /// 单次定位。如果当前正在连续定位，调用此方法将会失败，返回false
    /// - Parameters:
    ///   - reGeocode: 是否带有逆地理信息(获取逆地理信息需要联网)
    ///   - completionBlock: 单次定位完成后的Block
    /// - Returns: 是否成功添加单次定位Request
    @discardableResult
    func singleLocation(withReGeocode reGeocode: Bool, completionBlock: @escaping QYMapLocationCompletionBlock) -> Bool {
        return locationManager.requestLocation(withReGeocode: reGeocode) { location, regeocode, error in
            if let error = error {
                let error = error as NSError
                if error.code == AMapLocationErrorCode.locateFailed.rawValue {
                    completionBlock(location, regeocode, QYLocationError.locateFailed)
                } else if error.code == AMapLocationErrorCode.reGeocodeFailed.rawValue
                            || error.code == AMapLocationErrorCode.timeOut.rawValue
                            || error.code == AMapLocationErrorCode.cannotFindHost.rawValue
                            || error.code == AMapLocationErrorCode.badURL.rawValue
                            || error.code == AMapLocationErrorCode.notConnectedToInternet.rawValue
                            || error.code == AMapLocationErrorCode.cannotConnectToHost.rawValue {
                    completionBlock(location, regeocode, QYLocationError.reGeocodeFailed)
                } else if error.code == AMapLocationErrorCode.canceled.rawValue {
                    completionBlock(location, regeocode, QYLocationError.canceled)
                } else if error.code == AMapLocationErrorCode.regionMonitoringFailure.rawValue {
                    completionBlock(location, regeocode, QYLocationError.regionMonitoringFailure)
                } else if error.code == AMapLocationErrorCode.riskOfFakeLocation.rawValue {
                    completionBlock(location, regeocode, QYLocationError.riskOfFakeLocation)
                } else {
                    completionBlock(location, regeocode, QYLocationError.unknown)
                }
                return
            }
            completionBlock(location, regeocode, nil)
        }
    }
    
}
extension QYMapLocationManager: AMapLocationManagerDelegate {
    
    /// 需要后台定位才会用到的
    func amapLocationManager(_ manager: AMapLocationManager!, doRequireLocationAuth locationManager: CLLocationManager!) {
        locationManager.requestAlwaysAuthorization()
    }
}
