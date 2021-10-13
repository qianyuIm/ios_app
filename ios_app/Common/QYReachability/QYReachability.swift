//
//  QYReachability.swift
//  ios_app
//
//  Created by cyd on 2021/10/11.
//

import Foundation
import Reachability
import RxReachability
import RxSwift
import RxCocoa
import NSObject_Rx
class QYReachability: NSObject {
    
    static let shared = QYReachability()
    let reachabilityConnection = BehaviorRelay(value: Reachability.Connection.unavailable)
    var connectionValue: Reachability.Connection {
        return reachabilityConnection.value
    }
    var reachability:Reachability?
    private override init() {
        super.init()
        reachability = try? Reachability()
        reachability?.rx.reachabilityChanged
            .map{ $0.connection }
            .bind(to: reachabilityConnection)
            .disposed(by: rx.disposeBag)
    }
    func startNotifier() {
        try? reachability?.startNotifier()
    }
}
