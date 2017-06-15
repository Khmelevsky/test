//
//  Places.swift
//  test
//
//  Created by Alexander Khmelevsky on 20.01.17.
//  Copyright © 2017 Almet Systems. All rights reserved.
//

import Foundation
import AFBuilder
import ObjectMapper


extension API {
    
    static func places(latitude:Double, longitude:Double, complete: @escaping (_ result:PlacesResponse?)->()) {
        APIManager.instance.defaultBuilder(url: "place/nearbysearch/json") { configurator in
            configurator.params = [
                "location":"\(latitude),\(longitude)",
                "radius":2000,
                "key":R.google.mapApiKey,
                "keyword":"Bar",
                "rankBy":"distance",
            ]
        }
        .addHandler(APIManager.Handlers.networkActivityIndicator)
        .addHandler(AFBuilderSuccessHandler(success: { (_, _, result) in
            complete(Mapper<PlacesResponse>().map(JSONObject: result))
        }))
        .execute()
    }
    
    
    // MARK: - Response object
    class PlacesResponse: Mappable {
        
        var places = [Place]()
        
        /// This function can be used to validate JSON prior to mapping. Return nil to cancel mapping at this point
        public required init?(map: Map) {}
        
        
        /// This function is where all variable mappings should occur. It is executed by Mapper during the mapping (serialization and deserialization) process.
        public func mapping(map: Map) {
            places <- map["results"]
        }

        
    }
    
}
