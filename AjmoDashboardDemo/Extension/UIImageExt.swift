//
//  UIImageExt.swift
//  SwiftAppTemplate
//
//  Created by Nhan Nguyen on 12/29/16.
//  Copyright © 2016 Opiyn. All rights reserved.
//

import UIKit

extension UIImageView {
    var placeholderImage : UIImage {
        if let img = UIImage(named: "no_image"){
            return img
        }
        
        return UIImage()
    }
    
    func blurBackground() {
        let darkBlur = UIBlurEffect(style: UIBlurEffect.Style.dark)
        let blurView = UIVisualEffectView(effect: darkBlur)
        blurView.frame = frame
        blurView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        addSubview(blurView)
    }
    
//    func downloadImageFromUrl(_ url: String?, placeholder: UIImage? = nil) {
//        guard let url = url, let nsurl = URL(string: url) else { return }
//        kf.setImage(with: ImageResource(downloadURL: nsurl), placeholder: placeholder)
//    }
}


extension UITextView {
    
    func wrapText(aroundRect rect: CGRect) {
        let path = UIBezierPath(rect: rect)
        textContainer.exclusionPaths = [path]
    }

}
