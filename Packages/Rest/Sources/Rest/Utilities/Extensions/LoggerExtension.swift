import os.log
import Foundation

extension Logger {
    public static let request = Logger(
        subsystem: "me.tmbr.trade.rest",
        category: "request"
    )
}
