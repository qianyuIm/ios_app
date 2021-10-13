//
//  UIScrollView+Rx.swift
//  ios_app
//
//  Created by cyd on 2021/10/13.
//

import Foundation
import RxCocoa
import RxSwift

import EmptyDataSet_Swift

// MARK: - EmptyDataSet
extension Reactive where Base: UIScrollView {
    /// 刷新空白页面
    var reloadEmptyData: Binder<Void> {
        return Binder(base) { (this, _) in
            this.reloadEmptyDataSet()
        }
    }
}

