import Foundation

class KovanInfuraNetwork: Network {
    
    private let origin: Network
    init(apiKey: String) {
        let configuration = URLSessionConfiguration.default
        configuration.requestCachePolicy = .reloadIgnoringLocalCacheData
        origin = SimpleNetwork(
            session: URLSession(configuration: URLSessionConfiguration.default),
            url: URL(string: "https://kovan.infura.io/"+apiKey)!,
            headers: [:]
        )
    }

    func call(method: String, params: Array<GethParameter>) throws -> Data {
        return try origin.call(
            method: method,
            params: params
        )
    }

}
