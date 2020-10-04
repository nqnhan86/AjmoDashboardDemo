//
//  UIViewControllerExt.swift
//  SwiftAppTemplate
//
//  Created by Nhan iOS on 7/18/17.
//  Copyright © 2017 Nhan Nguyen. All rights reserved.
//

import UIKit

extension UIApplication {
    
    class func topViewController(_ base: UIViewController? = UIApplication.shared.keyWindow?.rootViewController) -> UIViewController? {
        if let nav = base as? UINavigationController {
            return topViewController(nav.visibleViewController)
        }
        if let tab = base as? UITabBarController {
            if let selected = tab.selectedViewController {
                return topViewController(selected)
            }
        }
        if let presented = base?.presentedViewController {
            return topViewController(presented)
        }
        return base
    }
}

extension UINavigationController {
    
    func backToPreviousView() {
        _ = popViewController(animated: true)
    }
}

extension UIViewController{
    func addChildVC(childVC: UIViewController, containerView: UIView){
        self.addChild(childVC)
        
        containerView.addSubview(childVC.view)
        containerView.addHorizontalConstraint(toView: childVC.view)
        containerView.addVerticalConstraint(toView: childVC.view)
        
        childVC.didMove(toParent: self)
    }
    
    func removeChildVC(childVC: UIViewController){
        childVC.willMove(toParent: nil)
        childVC.view.removeAllSubviews()
        childVC.removeFromParent()
    }
}
