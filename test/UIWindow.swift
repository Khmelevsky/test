import UIKit

// MARK: - currentViewController
extension UIWindow {
    //@return Returns the current Top Most ViewController in hierarchy.
    func topMostController() -> UIViewController? {
        var topController = rootViewController
        while let presentedController = topController?.presentedViewController {
            topController = presentedController
        }
        return topController
    }
    
    //@return Returns the topViewController in stack of topMostController.
    func currentViewController() -> UIViewController? {
        var currentViewController = topMostController()
        while currentViewController != nil && currentViewController is UINavigationController && (currentViewController as! UINavigationController).topViewController != nil {
            currentViewController = (currentViewController as! UINavigationController).topViewController
        }
        return currentViewController
    }
}
