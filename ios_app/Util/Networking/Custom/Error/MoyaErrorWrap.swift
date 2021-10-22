//
//  MoyaErrorWrap.swift
//  ios_app
//
//  Created by cyd on 2021/10/22.
//

import Foundation

struct MoyaErrorWrap: Error {
    let code: Int
    let message: String

    init(code: Int = 0, message: String) {
        self.code = code
        self.message = message
    }
}
