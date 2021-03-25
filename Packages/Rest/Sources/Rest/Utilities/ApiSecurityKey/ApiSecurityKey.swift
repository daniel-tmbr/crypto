import Foundation

public protocol ApiSecurityKeyReader {
    func read() throws -> String?
}

public protocol ApiSecurityKeyWriter {
    func store(string: String?) throws
}

public typealias ApiSecurityKey = ApiSecurityKeyReader & ApiSecurityKeyWriter

