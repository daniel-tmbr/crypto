import Foundation

public protocol ConsumerKeyReader {
    func read() throws -> String?
}

public protocol ConsumerKeyWriter {
    func store(string: String?) throws
}

public protocol ConsumerKeyStore: ConsumerKeyReader, ConsumerKeyWriter {
    var type: ConsumerKeyType { get }
}
