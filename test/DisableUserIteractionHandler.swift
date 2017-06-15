//
//  DisableUserIteractionHandler.swift
//
//  Created by Alexander Khmelevsky on 20.01.17.
//  Copyright © 2016 Almet-Systems. All rights reserved.
//

import Foundation
import AFBuilder

extension APIManager.Handlers {
    
    static var disableUserIteraction: AFBuilderHandlersProtocol {
        get {
            return DisableUserIteractionHandler.default
        }
    }
    
    private class DisableUserIteractionHandler: AFBuilderHandlersProtocol {
        
        static let `default` = DisableUserIteractionHandler()
        
        func requestWillStart(builder: AFBuilder) {
            (UIApplication.shared.delegate as! AppDelegate).window?.isUserInteractionEnabled = false
        }
        
        func requestDidFinish(builder: AFBuilder) {
            (UIApplication.shared.delegate as! AppDelegate).window?.isUserInteractionEnabled = true
        }
    }
    
    
}

