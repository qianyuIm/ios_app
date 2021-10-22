//
//  QYLaunchAd.swift
//  QianyuIm
//
//  Created by cyd on 2020/7/8.
//  Copyright © 2020 qianyuIm. All rights reserved.
//  广告

import UIKit
import XHLaunchAd
import SwiftyUserDefaults

class QYLaunchAd: NSObject {
    let scale3Url = "https://fdfs.xmcdn.com/group83/M07/5C/02/wKg5I179wIOTk59EAAOJzPWuqDw575.jpg"
    var adConfig = XHLaunchImageAdConfiguration()
    
    func start() {
        NotificationCenter.default.addObserver(self, selector: #selector(setupLaunchAd), name: UIApplication.didFinishLaunchingNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(willEnterForeground), name: UIApplication.willEnterForegroundNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(didEnterBackground), name: UIApplication.didEnterBackgroundNotification, object: nil)
    }
    
    @objc fileprivate func didEnterBackground() {
        let time = Date().timeIntervalSince1970
        Defaults[\.enterBackgroundTimeKey] = time
    }
    @objc fileprivate func willEnterForeground() {
        let enterBackgroundTime = Defaults[\.enterBackgroundTimeKey]
        let time = Date().timeIntervalSince1970
        Defaults[\.enterBackgroundTimeKey] = time
        if (time - enterBackgroundTime > QYConfig.showEnterForegroundAdTimeInterval) {
            adConfig.showEnterForeground = true
        } else {
            adConfig.showEnterForeground = false
        }
    }
    @objc fileprivate func setupLaunchAd() {
        XHLaunchAdButton.fixSwizzleMethord()
        
        XHLaunchAd.setLaunch(.launchScreen)
        XHLaunchAd.setWaitDataDuration(2)
        
            self.launchImageAdConfig(url: self.scale3Url,scale: 3)
        
    }
    fileprivate func launchImageAdConfig(url: String?,scale: Int) {
        guard let url = url else { return  }
        
        adConfig.duration = 5
        /*if scale == 2 {
            adConfig.frame = UIScreen.main.bounds
        } else {
            let width: CGFloat = 375
            let height: CGFloat = 528
            adConfig.frame = CGRect(x: 0, y: 0, width: QYInch.screenWidth, height: ceil(QYInch.screenWidth * height / width))
        }*/
        
        adConfig.imageNameOrURLString = url
        adConfig.imageOption = .cacheInBackground
        adConfig.showEnterForeground = true
        adConfig.contentMode = .scaleAspectFill
        adConfig.showFinishAnimate = .fadein
        adConfig.skipButtonType = .timeText
        XHLaunchAd.imageAd(with: adConfig, delegate: self)
        
    }
}

extension XHLaunchAdButton {
    public class func fixSwizzleMethord(){
        let originSelector = #selector(XHLaunchAdButton.init(skipType:))
        let swizzleSelector = #selector(XHLaunchAdButton.fixInit(skipType:))
        swizzleMethod(for: XHLaunchAdButton.self, originalSelector: originSelector, swizzledSelector: swizzleSelector)
    }
    @objc func fixInit(skipType: SkipType) ->  XHLaunchAdButton{
        let adButton = fixInit(skipType: skipType)
        var frame = adButton.frame
        frame.origin.y = QYInch.statusBarHeight
        adButton.frame = frame
        return adButton
    }
}


extension QYLaunchAd: XHLaunchAdDelegate {}
