//
//  BaseModel.swift
//  AjmoDashboardDemo
//
//  Created by Nhan Nguyen on 10/3/20.
//  Copyright © 2020 BaBen. All rights reserved.
//

import Foundation
import Mantle

public class BaseModel: MTLModel, MTLJSONSerializing {
    @objc var id : NSNumber = 0
    @objc var name : String?
    @objc var sharedLink : String = ""
    
    public class func jsonKeyPathsByPropertyKey() -> [AnyHashable : Any]! {
        //MODEL field_name, JSON field_name
        return [
            "id":"id",
            "name":"name",
            "sharedLink": "share_link"
        ]
    }
}
