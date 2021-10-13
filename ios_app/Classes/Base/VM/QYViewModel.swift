//
//  QYViewModel.swift
//  ios_app
//
//  Created by cyd on 2021/10/11.
//

import Foundation
import RxActivityIndicator
import RxSwift
import RxCocoa
import NSObject_Rx

class QYViewModel {
    let loading = ActivityIndicator()
    let error = ErrorTracker()
    required init() {}
}
extension QYViewModel: HasDisposeBag, ReactiveCompatible {}

