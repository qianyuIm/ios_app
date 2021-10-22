//
//  TargetType+Rx.swift
//  ios_app
//
//  Created by cyd on 2021/10/21.
//

import RxSwift
import Moya

extension Moya.TargetType {
    func request(_ local: Bool = false) -> Single<Moya.Response> {
        var isLocal = false
#if DEBUG
        isLocal = local
#else
        isLocal = false
#endif
        if isLocal {
            return apiLocalProvider.rx.request(.target(self))
        }
        
        return apiProvider.rx.request(.target(self))
    }
    
}
