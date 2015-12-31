//
//  NSObject+Debug.swift
//  Project4
//
//  Created by Oh Sang Young on 2015. 12. 13..
//  Copyright © 2015년 Oh Sang Young. All rights reserved.
//

import UIKit

extension UIApplication {
    class func topViewController(base: UIViewController? = UIApplication.sharedApplication().keyWindow?.rootViewController) -> UIViewController? {

        return base

//        if let nav = base as? UINavigationController {
//            return topViewController(nav.visibleViewController)
//        }
//
//        if let tab = base as? UITabBarController {
//            if let selected = tab.selectedViewController {
//                return topViewController(selected)
//            }
//        }
//
//        if let presented = base?.presentedViewController {
//            return topViewController(presented)
//        }
//        return base
    }
}

extension NSObject {
    func logTrace(funcname:String = __FUNCTION__) {
        print("\(self.dynamicType)::\(funcname) called")
    }
    func logDebug(msg:String, funcname:String = __FUNCTION__) {
        print("\(self.dynamicType)::\(funcname) \(msg)")
    }
    func logViewHierarchy(funcname:String = __FUNCTION__) {
        if let view = UIApplication.topViewController()?.view {
            print("\n>>> View hierarcy at \(funcname)")
            print(view.performSelector("recursiveDescription"))
            print("<<< View hierarcy at \(funcname)\n")
        }
        else {
            print("no top view")
        }
    }
}

