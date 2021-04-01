import Foundation

public enum RequestAssemblyError: Error {
    case components(URL)
    case composeUrl(URLComponents)
}
