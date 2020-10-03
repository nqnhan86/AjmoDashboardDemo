//
//  AjmoTodayModel.swift
//  AjmoDashboardDemo
//
//  Created by Nhan Nguyen on 10/3/20.
//  Copyright © 2020 BaBen. All rights reserved.
//

import Foundation
import Mantle

class AjmoTodayModel : BaseModel {
    @objc var type : String = ""
    @objc var venueName : String?
    @objc var city : String?
    @objc var pictureUrl : URL?
    @objc var startDate : Date?
    @objc var endDate : Date?
    @objc var isActive : Bool = true
    
    override class func jsonKeyPathsByPropertyKey() -> [AnyHashable : Any]! {
        let baseFields = BaseModel.jsonKeyPathsByPropertyKey()!
        
        //MODEL field_name, JSON field_name
        let fields = ["type" : "type",
                "venueName" : "venue.name",
                "city":"venue.city",
                "pictureUrl": "picture_url",
                "startDate": "start_datetime",
                "endDate": "end_datetime",
                "isActive": "active"
        ] as [AnyHashable: Any]
        
        //Take the new value for duplicated keys
        let result = baseFields.merging(fields, uniquingKeysWith: { _, new in
            return new
        })
        
        return result
    }
    
    static func pictureUrlJSONTransformer() -> ValueTransformer {
        return ValueTransformer(forName: NSValueTransformerName(rawValue: MTLURLValueTransformerName))!
    }
    
    static func isActiveJSONTransformer() -> ValueTransformer {
        return MTLValueTransformer(usingForwardBlock: { value, _, _ in
            if let v = value as? NSNumber {
                return v.boolValue
            }
            
            return false
        })
    }
    
    
    @objc static func startDateJSONTransformer() -> ValueTransformer {
        return MTLValueTransformer(usingForwardBlock: { timeStamp, _, _ in
            if let v = timeStamp as? NSNumber {
                return Date(timeIntervalSince1970: v.doubleValue)
            }

            return nil
        })
    }
    
    @objc static func endDateJSONTransformer() -> ValueTransformer {
        return MTLValueTransformer(usingForwardBlock: { timeStamp, _, _ in
            if let v = timeStamp as? NSNumber {
                return Date(timeIntervalSince1970: v.doubleValue)
            }

            return nil
        })
    }
}
