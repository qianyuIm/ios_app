//
//  QYLogger.swift
//  ios_app
//
//  Created by cyd on 2021/10/9.
//

import Foundation
import SwiftyBeaver

class QYLogger {
    static let customLogger = SwiftyBeaver.self
    class func debug(_ message: Any, _ file: String = #file,
                  _ function: String = #function,
                  line: Int = #line,
                  _ context: Any? = nil) {
        customLogger.debug(message, file, function, line: line, context: context)
    }

    class func error(_ message: Any, _ file: String = #file,
                  _ function: String = #function, line: Int = #line,
                  context: Any? = nil) {
        customLogger.error(message, file, function, line: line, context: context)
    }

    class func info(_ message: Any, _ file: String = #file,
                 _ function: String = #function, line: Int = #line,
                 context: Any? = nil) {
        customLogger.info(message, file, function, line: line, context: context)
    }

    class func verbose(_ message: Any, _ file: String = #file,
                    _ function: String = #function, line: Int = #line, context: Any? = nil) {
        customLogger.verbose(message, file, function, line: line, context: context)
    }

    class func warning(_ message: Any, _ file: String = #file,
                    _ function: String = #function, line: Int = #line, context: Any? = nil) {
        customLogger.warning(message, file, function, line: line, context: context)
    }

}
