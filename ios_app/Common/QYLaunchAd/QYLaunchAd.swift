//
//  QYLaunchAd.swift
//  QianyuIm
//
//  Created by cyd on 2020/7/8.
//  Copyright © 2020 qianyuIm. All rights reserved.
//  广告

import UIKit
import XHLaunchAd

class QYLaunchAd: NSObject {
    let scale2Url = "http://s.servingcdn.com/f/4e/f4ef738b0507d626eae0fe84f786590e.jpg"
    let scale3Url = "https://fdfs.xmcdn.com/group83/M07/5C/02/wKg5I179wIOTk59EAAOJzPWuqDw575.jpg"
    func start() {
         NotificationCenter.default.addObserver(self, selector: #selector(setupLaunchAd), name: UIApplication.didFinishLaunchingNotification, object: nil)
    }
    
    @objc fileprivate func setupLaunchAd() {
        XHLaunchAd.setLaunch(.launchScreen)
        XHLaunchAd.setWaitDataDuration(1)
        if QYInch.scale == 2.0 {
            self.launchImageAdConfig(url: self.scale2Url, scale: 2)
        } else {
            self.launchImageAdConfig(url: self.scale3Url,scale: 3)
        }
    }
    fileprivate func launchImageAdConfig(url: String?,scale: Int) {
        guard let url = url else { return  }
        let adConfig = XHLaunchImageAdConfiguration()
        adConfig.duration = 5
        if scale == 2 {
            adConfig.frame = UIScreen.main.bounds
        } else {
//            let width: CGFloat = 375
//            let height: CGFloat = 528
//            adConfig.frame = CGRect(x: 0, y: 0, width: QYInch.screenWidth, height: ceil(QYInch.screenWidth * height / width))
        }
        adConfig.imageNameOrURLString = url
        adConfig.imageOption = .cacheInBackground
        adConfig.contentMode = .scaleAspectFill
        adConfig.showFinishAnimate = .none
        adConfig.skipButtonType = .timeText
        XHLaunchAd.imageAd(with: adConfig, delegate: self)
    }
}

extension QYLaunchAd: XHLaunchAdDelegate {
    
}
