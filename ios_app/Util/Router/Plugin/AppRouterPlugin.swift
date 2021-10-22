//
//  AppRouterPluginable.swift
//  ios_app
//
//  Created by cyd on 2021/10/20.
//

import Foundation
/// 插件
protocol AppRouterPluginable {
    
    associatedtype T
    
    /// 是否可以打开
    ///
    /// - Parameter url: 类型
    /// - Returns: true or false
    func should(open type: T) -> Bool
    
    /// 准备打开
    ///
    /// - Parameters:
    ///   - url: 类型
    ///   - completion: 准备完成回调 (无论结果如何必须回调)
    func prepare(open type: T, completion: @escaping (Bool) -> Void)
    
    /// 即将打开
    ///
    /// - Parameters:
    ///   - type: 类型
    ///   - controller: 视图控制器
    func will(open type: T, controller: AppRouterable)
    
    /// 已经打开
    ///
    /// - Parameters:
    ///   - type: 类型
    ///   - controller: 视图控制器
    func did(open type: T, controller: AppRouterable)
}

class AppRouterPlugin<T: AppRouterTypeable>: AppRouterPluginable {
    
    public init() {}
    
    open func should(open type: T) -> Bool {
        return true
    }
    
    open func prepare(open type: T, completion: @escaping (Bool) -> Void) {
        completion(true)
    }
    
    open func will(open type: T, controller: AppRouterable) {
    }
    
    open func did(open type: T, controller: AppRouterable) {
    }
}
