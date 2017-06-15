//
//  Place.swift
//  test
//
//  Created by Alexander Khmelevsky on 20.01.17.
//  Copyright © 2017 Almet Systems. All rights reserved.
//

import Foundation
import ObjectMapper
import GoogleMaps

class Place: Mappable {
    
    var name: String = ""
    var vicinity: String = ""
    var iconURL: String?
    var photos = [Photo]()
    var location: CLLocationCoordinate2D?
    
    
    /// This function can be used to validate JSON prior to mapping. Return nil to cancel mapping at this point
    public required init?(map: Map) {
        
    }
    
    /// This function is where all variable mappings should occur. It is executed by Mapper during the mapping (serialization and deserialization) process.
    public func mapping(map: Map) {
        name <- map["name"]
        vicinity <- map["vicinity"]
        iconURL <- map["icon"]
        photos <- map["photos"]
        location <- (map["geometry.location"], LocationTransform())
    }
    
}

extension Place {
    
    // Photos
    class Photo: Mappable {
        
        private var _photo_reference: String?
        
        func url(size: Int = 50) -> String? {
            guard let reference = _photo_reference else {
                return nil
            }
            return String(format: "https://maps.googleapis.com/maps/api/place/photo?maxwidth=%d&photoreference=%@&key=%@", size, reference, R.google.mapApiKey)
        }
        
        /// This function can be used to validate JSON prior to mapping. Return nil to cancel mapping at this point
        public required init?(map: Map) {
            _photo_reference <- map["photo_reference"]
        }
        
        /// This function is where all variable mappings should occur. It is executed by Mapper during the mapping (serialization and deserialization) process.
        public func mapping(map: Map) {
            
        }
        
    }
    
}



