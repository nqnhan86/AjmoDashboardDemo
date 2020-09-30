//
//  NetworkManager.swift
//  EasyTickUserSDK
//
//  Created by Nhan iOS on 6/25/19.
//

import UIKit
import Alamofire

public class NetworkManager {
    //shared instance
    static let shared = NetworkManager()
    
    var isConnected : Bool {
        return NetworkReachabilityManager(host: "www.google.com")!.isReachable
    }
}

