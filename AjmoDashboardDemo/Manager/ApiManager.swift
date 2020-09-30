//
//  APIManager.swift
//  Alamofire
//
//  Created by Nhan iOS on 4/22/19.
//

import Foundation
import Alamofire

public typealias FailureHandler = ((_ error: String)->Void)

struct APIError {
    static let UNKNOWN_ERROR_MESSAGE = "Unexpected error! Response with wrong format."
    static let NO_INTERNET_ERROR_MESSAGE = "This device does not connect to internet."
}

public class ApiManager {
    var jsonHTTPHeaders : HTTPHeaders {
        let httpHeaders: HTTPHeaders = [
            "Accept": "application/json",
            "Content-Type": "application/json"
        ]
        
        return httpHeaders
    }
}



