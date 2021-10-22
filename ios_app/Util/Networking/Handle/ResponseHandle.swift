//
//  ResponseHandle.swift
//  ios_app
//
//  Created by cyd on 2021/10/21.
//

import Moya

typealias CustomTargetType = CustomMoyaResponseable & TargetType

protocol CustomMoyaResponseable {
    /// 当 HTTP Status Code == 'success'，判断服务端返回的数据是否符合成功约定
    /// 默认 true，全都符合，当 false 时，返回结果为 Result.failure 类型
    func isServerSuccess(response: Moya.Response) -> Bool
    /// 默认 nil，不自定义，返回 Result<Moya.Response, MoyaError>.failure(.underlying(response)) 类型数据
    func customMoyaFailureResult(response: Moya.Response) -> Result<Moya.Response, MoyaError>?
    
}
extension CustomMoyaResponseable {

    func isServerSuccess(response: Moya.Response) -> Bool {
        true
    }

    func customMoyaFailureResult(response: Moya.Response) -> Result<Moya.Response, MoyaError>? {
        nil
    }

}
