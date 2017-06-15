//
//  APIManager
//
//  Created by Alexander Khmelevsky on 20.01.17.
//  Copyright © 2016 Almet-Systems. All rights reserved.
//

import Foundation
import AFNetworking
import AFBuilder

// Settings
private let API_URL = "https://maps.googleapis.com/maps/api/"


// Manager
final class APIManager {
    
    static let instance = APIManager()
    private init() {}
    
    private let manager = AFHTTPSessionManager(baseURL: URL(string: API_URL)) // API base URL
    
    
    func defaultBuilder(url:String, clouser:(AFBuildConfigurator) -> Swift.Void) -> AFBuilder {
        return manager.builder(withUrlString: url, clouser: clouser)
            .addHandler(APIManager.Handlers.networkActivityIndicator)
    }
    
    final class Handlers{}
}

// Abstaract
final class API {}
