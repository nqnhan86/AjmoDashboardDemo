//
//  UIViewExt.swift
//  SwiftAppTemplate
//
//  Created by Nhan Nguyen on 12/29/16.
//  Copyright © 2016 Opiyn. All rights reserved.
//

import UIKit

extension UITableView {
    
    func resizeTableHeaderView(toSize size: CGSize) {
        guard let headerView = tableHeaderView else { return }
        headerView.frame.size = headerView.systemLayoutSizeFitting(size)
        tableHeaderView? = headerView
    }
}


extension UIView {
    
    func addsubviews(_ views: UIView...) {
        
        for subview in views {
            
            addSubview(subview)
        }
    }
    
    func createBorder(_ width: CGFloat, color: UIColor) {
        layer.borderColor = color.cgColor
        layer.borderWidth = width
    }
    
    func createRoundCorner(_ radius: CGFloat) {
        layer.cornerRadius = radius
        clipsToBounds = true
    }
    
    func createShadow(with radius: CGFloat = 5, offset: CGSize = .zero) {
        layer.shadowPath = UIBezierPath(rect: self.bounds).cgPath
        layer.shadowRadius = radius
        layer.shadowOffset = offset
        layer.shadowOpacity = 1
    }
    
    func createCircleShape() {
        createRoundCorner(frame.size.width / 2)
    }
    
    func createImageFromView() -> UIImage {        
        UIGraphicsBeginImageContext(bounds.size)
        layer.render(in: UIGraphicsGetCurrentContext()!)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image!
    }
    
    func addHorizontalConstraint(toView view: UIView) {
        
        addConstraints(withFormat: "H:|[v0]|", views: view)
    }
    
    func addVerticalConstraint(toView view: UIView) {
        addConstraints(withFormat: "V:|[v0]|", views: view)
    }
    
    func addConstraints(withFormat format: String, views: UIView...) {
        
        var viewsDictionary = [String: UIView]()
        
        for i in 0 ..< views.count {
            let key = "v\(i)"
            views[i].translatesAutoresizingMaskIntoConstraints = false
            viewsDictionary[key] = views[i]
        }
        
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: format, options: NSLayoutConstraint.FormatOptions(), metrics: nil, views: viewsDictionary))
    }
    
    func addConstraintsWith(withFormat format: String, views: UIView...) ->  [NSLayoutConstraint]{
        
        var viewsDictionary = [String: UIView]()
        
        for i in 0 ..< views.count {
            let key = "v\(i)"
            views[i].translatesAutoresizingMaskIntoConstraints = false
            viewsDictionary[key] = views[i]
        }
        
        let thisConstraint = NSLayoutConstraint.constraints(withVisualFormat: format, options: NSLayoutConstraint.FormatOptions(), metrics: nil, views: viewsDictionary)
        addConstraints(thisConstraint)
        return thisConstraint
    }
    
    func removeAllSubviews() {
        for view in subviews {
            view.removeFromSuperview()
        }
    }
    
    func addGradientLayer(with color: UIColor) {
        let mask = CAGradientLayer()
        mask.startPoint = CGPoint(x: 1.0, y: 1.0)
        mask.endPoint = CGPoint(x: 1.0, y: 0.0)
        mask.colors = [color.withAlphaComponent(1.0).cgColor, color.withAlphaComponent(0.0).cgColor]
        mask.locations = [0.0,1.0]
        mask.frame = self.bounds
        mask.masksToBounds = true
        self.layer.addSublayer(mask)
    }
}




