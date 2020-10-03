//
//  APIManager.swift
//  Alamofire
//
//  Created by Nhan iOS on 4/22/19.
//

import Foundation
import Alamofire
import Mantle

public typealias FailureHandler = ((_ error: String)->Void)
public typealias SuccessHandler<T:BaseModel> = ((_ item: [T])->Void)

struct APIError {
    static let UNKNOWN_ERROR_MESSAGE = "Unexpected error! Response with wrong JSON format."
    static let NO_INTERNET_ERROR_MESSAGE = "This device does not connect to internet."
}

public class ApiManager {
    static var shared = ApiManager()
    
    fileprivate static var jsonHTTPHeaders : HTTPHeaders {
        let httpHeaders: HTTPHeaders = [
            "Accept": "application/json",
            "Content-Type": "application/json"
        ]
        
        return httpHeaders
    }
    
    func fetchTodayData(success:@escaping SuccessHandler<AjmoTodayModel>,
                        failure: @escaping FailureHandler){
        
        if !NetworkManager.shared.isConnected {
            failure(APIError.NO_INTERNET_ERROR_MESSAGE)
            return
        }
        
        AF.request(Configuration.GET_TODAY_EVENTS_URL,
                   headers: ApiManager.jsonHTTPHeaders)
            .responseJSON { (response) in
                if let dict = response.value as? [String: Any],
                    let json = dict["data"] as? [String: Any],
                    let arr = json["today"] as? [Any] {
                   
                    var isSuccess = true
                    var result = [AjmoTodayModel]()
                    
                    for item in arr {
                        print(item)
                        if let data = item as? [String: Any]{
                            do {
                                let model = try MTLJSONAdapter.model(of: AjmoTodayModel.self, fromJSONDictionary: data) as! AjmoTodayModel
                                result.append(model)
                            }
                            catch {
                                isSuccess = false
                                print(error)
                                break
                            }
                        }
                        else {
                            isSuccess = false
                            break
                        }
                    }
                    
                    if isSuccess {
                        success(result)
                        return
                    }
                }
                
                failure(APIError.UNKNOWN_ERROR_MESSAGE)
        }
        
    }
    
}



