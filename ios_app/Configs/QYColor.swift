//
//  QYColor.swift
//  ios_app
//
//  Created by cyd on 2021/10/12.
//

import UIKit

struct QYColor {
    static func color(_ hexString: String, transparency: CGFloat = 1) -> UIColor {
        return UIColor(hexString: hexString,transparency: transparency) ?? .clear
    }
}
