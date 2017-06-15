//
//  ShowAlertIfErrorHandler.swift
//
//  Created by Alexander Khmelevsky on 20.01.17.
//  Copyright © 2016 Almet-Systems. All rights reserved.
//

import Foundation
import AFBuilder

//TODO: Add localization
extension APIManager.Handlers {
    
    static func showAlertIfError(actions:UIAlertAction...) -> AFBuilderHandlersProtocol {
        return ShowAlertIfErrorHandler(actions: actions)
    }
    
    static var showAlertIfError: AFBuilderHandlersProtocol {
        get {
            return ShowAlertIfErrorHandler.default
        }
    }
    
    private class ShowAlertIfErrorHandler: AFBuilderHandlersProtocol {
        
        static let `default` = ShowAlertIfErrorHandler()
        
        var actions = [UIAlertAction]()
        
        init(actions: [UIAlertAction] = [UIAlertAction(title:"Ok", style:.default, handler: nil)]) {
            self.actions = actions
        }
        
        func failure(builder: AFBuilder, URLSessionDataTask: URLSessionDataTask?, error: Error) {
            if let vc = (UIApplication.shared.delegate as? AppDelegate)?.window?.currentViewController() {
                let alertController = UIAlertController(title: "Error", message: error.localizedDescription, preferredStyle: .alert)
                for action in actions { alertController.addAction(action) }
                vc.present(alertController, animated: true, completion: nil)
            }
        }
    }
    
}

