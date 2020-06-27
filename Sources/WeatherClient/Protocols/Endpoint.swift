//
//  Endpoint.swift
//  WeatherClient
//
//  Created by Arsha Hassas on 6/25/20.
//

import Foundation
import Alamofire

protocol Endpoint: URLRequestConvertible {
    var url: URL { get }
    var headers: HTTPHeaders { get }
    var method: HTTPMethod { get }
    var parameters: [String:String] { get }
}

extension Endpoint {
    func asURLRequest() throws -> URLRequest {
        let request = try URLRequest(url: url, method: method, headers: headers)
        return try URLEncodedFormParameterEncoder.default.encode(parameters, into: request)
    }
}
