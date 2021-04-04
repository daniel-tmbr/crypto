import Foundation

public enum RequestAssemblyError: Error {
    case malformedUrl(URL)
    case invalidComponents(URLComponents)
}
