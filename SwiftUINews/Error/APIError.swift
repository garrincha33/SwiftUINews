//
//  APIError.swift
//  SwiftUINews
//
//  Created by Richard Price on 14/04/2021.
//

import Foundation

//step 4 create custom errors using an enum
enum APIError: Error {
    case decodingError
    case errorCode(Int)
    case unknown
}

//step 5 use an extension to acutally define the cases
extension APIError: LocalizedError {
    var errorDescription: String? {
        switch self {
        case .decodingError:
            return "failed to decode the object from the service"
        case .errorCode(let code):
            return "\(code) - something went wrong"
        case .unknown:
            return "The error is unknown"
        }
    }
}
