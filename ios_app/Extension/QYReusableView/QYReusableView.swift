//
//  ReusableView.swift
//  ios_app
//
//  Created by cyd on 2021/10/13.
//

import UIKit

protocol QYReusableView {
    static var defaultReuseIdentifier: String { get }
}

extension QYReusableView where Self: UIView {
  static var defaultReuseIdentifier: String {
    return String(describing: self)
  }
}

extension UITableViewCell: QYReusableView { }
extension UICollectionReusableView: QYReusableView { }
extension UITableViewHeaderFooterView: QYReusableView { }
