//
//  NetworkActivityIndicatorHandler.swift
//
//  Created by Alexander Khmelevsky on 20.01.17.
//  Copyright © 2016 Almet-Systems. All rights reserved.
//

import Foundation
import AFBuilder


extension APIManager.Handlers {
    
    static var networkActivityIndicator: AFBuilderHandlersProtocol {
        get {
            return NetworkActivityIndicatorHandler.default
        }
    }
    
    private class NetworkActivityIndicatorHandler: AFBuilderHandlersProtocol {
        
        static let `default`: NetworkActivityIndicatorHandler = NetworkActivityIndicatorHandler()
        
        func requestWillStart(builder: AFBuilder) {
            UIApplication.shared.isNetworkActivityIndicatorVisible = true
        }
        
        func requestDidFinish(builder: AFBuilder) {
            UIApplication.shared.isNetworkActivityIndicatorVisible = false
        }
        
    }
    
}

