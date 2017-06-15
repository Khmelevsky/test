//
//  LocationTransform.swift
//  test
//
//  Created by Alexander Khmelevsky on 20.01.17.
//  Copyright © 2017 Almet Systems. All rights reserved.
//

import Foundation
import GoogleMaps
import ObjectMapper

class LocationTransform: TransformType {
    
    typealias JSON = String
    typealias Object = CLLocationCoordinate2D
    
    public func transformToJSON(_ value: CLLocationCoordinate2D?) -> String? {
        guard let value = value else {
            return nil
        }
        return "\(value.latitude),\(value.longitude)"
    }
    
    public func transformFromJSON(_ value: Any?) -> CLLocationCoordinate2D? {
        guard let value = value as? NSDictionary,
            let lat = value["lat"] as? Double,
            let lng = value["lng"] as? Double else {
            return nil
        }
        return CLLocationCoordinate2D(latitude: lat, longitude: lng)
    }
    
}
