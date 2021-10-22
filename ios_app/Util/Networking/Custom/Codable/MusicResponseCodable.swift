//
//  MusicResponseCodable.swift
//  ios_app
//
//  Created by cyd on 2021/10/22.
//

import Moya
import HandyJSON
import SwiftyUserDefaults
import RxSwift
import RxCocoa

extension Response {
    func mapMusicObject<T: HandyJSON>(_ type: T.Type,
                                      atKeyPath keyPath: String? = nil) throws -> T {
        guard let json = try mapJSON() as? [String: Any] else {
            throw MoyaError.jsonMapping(self)
        }
        if let result = T.deserialize(from: json, designatedPath: keyPath) {
            return result
        }
        throw MoyaError.jsonMapping(self)
    }
    func mapMusicArray<T: HandyJSON>(_ type: [T].Type, atKeyPath keyPath: String? = nil) throws -> [T] {
        let json = try mapString(atKeyPath: keyPath)
        if let result = [T].deserialize(from: json, designatedPath: keyPath) {
            return result.compactMap { $0 }
        }
        throw MoyaError.jsonMapping(self)
    }
}
extension PrimitiveSequence where Trait == SingleTrait, Element == Response {

    func mapMusicObject<T: HandyJSON>(_ type: T.Type, atKeyPath keyPath: String? = nil) -> Single<T> {
        return flatMap { response -> Single<T> in
            return Single.just(try response.mapMusicObject(type, atKeyPath: keyPath))
        }
    }
    
    func mapMusicArray<T: HandyJSON>(_ type: [T].Type, atKeyPath keyPath: String? = nil) -> Single<[T]> {

        return flatMap { response -> Single<[T]> in
            return Single.just(try response.mapMusicArray(type, atKeyPath: keyPath))
        }
    }
}
extension ObservableType where Element == Response {
    
   func mapMusicObject<T: HandyJSON>(_ type: T.Type, atKeyPath keyPath: String? = nil) -> Observable<T> {
        return flatMap { response -> Observable<T> in
            return Observable.just(try response.mapMusicObject(type, atKeyPath: keyPath))
        }
    }
    func mapMusicArray<T: HandyJSON>(_ type: [T].Type, atKeyPath keyPath: String? = nil) -> Observable<[T]> {
        return flatMap { response -> Observable<[T]> in
            return Observable.just(try response.mapMusicArray(type, atKeyPath: keyPath))
        }
    }
}
