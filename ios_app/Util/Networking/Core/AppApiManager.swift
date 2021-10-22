//
//  AppApiManager.swift
//  ios_app
//
//  Created by cyd on 2021/10/21.
//

import Foundation
import Moya
import RxSwift


let timeoutClosure = {(endpoint: Endpoint, closure: MoyaProvider.RequestResultClosure) -> Void in
    do {
        var urlRequest = try endpoint.urlRequest()
        urlRequest.timeoutInterval = 15
        closure(.success(urlRequest))
    } catch MoyaError.requestMapping(let url) {
        closure(.failure(MoyaError.requestMapping(url)))
    } catch MoyaError.parameterEncoding(let error) {
        closure(.failure(MoyaError.parameterEncoding(error)))
    } catch {
        closure(.failure(MoyaError.underlying(error, nil)))
    }
}

let apiProvider = MoyaProvider<MultiTarget>(requestClosure: timeoutClosure,
                                            plugins: [CustomResponsePlugin()])
let apiLocalProvider = MoyaProvider<MultiTarget>(requestClosure: timeoutClosure,
                                                 stubClosure: { (target) -> StubBehavior in
    return StubBehavior.delayed(seconds: 1.5)},
                                                 plugins: [CustomResponsePlugin()])
