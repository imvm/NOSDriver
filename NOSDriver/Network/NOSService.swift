//
//  NOSService.swift
//  NOSDriver
//
//  Created by Ian Manor on 14/04/19.
//  Copyright © 2019 Ian Manor. All rights reserved.
//

import Foundation
import Moya

enum NOSService {
    case login(email: String, password: String)
    //case resetPassword
    //case createUser
    case getTransportationRequests
    case getTransportationRequestDetails(transportationRequestId: Int)
    case acceptTransportationRequest(transportationRequestId: Int)
    case cancelTransportationRequest(transportationRequestId: Int)
    //case updateBasePrice
    //case updateKilometerPrice
    //case updatePickupHours
    //case updateCNPJ
    //case updateName
    //case getDestinations
    //case getDestinationDetails
}

extension NOSService: TargetType {
    var baseURL: URL {
        return URL(string: "10.98.1.23/8080")!
    }
    
    var path: String {
        switch self {
        case .login:
            return "/login"
        case .getTransportationRequests:
            return "/transportRequests"
        case let .getTransportationRequestDetails(transportationRequestId):
            return "/transportRequests/\(transportationRequestId)"
        case let .acceptTransportationRequest(transportationRequestId):
            return "/transportRequests/\(transportationRequestId)/accept"
        case let .cancelTransportationRequest(transportationRequestId):
            return "/transportRequests/\(transportationRequestId)/cancel"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .login, .acceptTransportationRequest, .cancelTransportationRequest:
            return .post
        case .getTransportationRequests, .getTransportationRequestDetails:
            return .get
        }
    }
    
    var sampleData: Data {
        return "".utf8Encoded
    }
    
    var task: Task {
        switch self {
        case let .login(email, password):
            return .requestParameters(parameters: ["email": email, "password": password], encoding: JSONEncoding.default)
        case .getTransportationRequests:
            return .requestPlain
        case let .getTransportationRequestDetails(transportationRequestId):
            return .requestParameters(parameters: ["requestId": transportationRequestId], encoding: JSONEncoding.default)
        case let .acceptTransportationRequest(transportationRequestId):
            return .requestParameters(parameters: ["requestId": transportationRequestId], encoding: JSONEncoding.default)
        case let .cancelTransportationRequest(transportationRequestId):
            return .requestParameters(parameters: ["requestId": transportationRequestId], encoding: JSONEncoding.default)
        }
    }
    
    var headers: [String : String]? {
        return ["Content-type": "application/json"]
    }
    
    
}

// MARK: - Helpers
private extension String {
    var urlEscaped: String {
        return addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)!
    }
    
    var utf8Encoded: Data {
        return data(using: .utf8)!
    }
}
