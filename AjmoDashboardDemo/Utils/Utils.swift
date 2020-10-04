//
//  Utils.swift
//  SwiftAppTemplate
//
//  Created by Nhan Nguyen on 12/29/16.
//  Copyright © 2016 BaBen. All rights reserved.
//

import Foundation
import UIKit
import MBProgressHUD



class Utils {
    
    static var appName : String {
        if let info = Bundle.main.infoDictionary,
            let name = info["CFBundleDisplayName"] as? String {
            return name
        }
        
        return "AjmoDashboardDemo"
    }
    
    static var appVersion : String {
        if let info = Bundle.main.infoDictionary,
            let currentVersion = info["CFBundleShortVersionString"] as? String,
            let buildNumber = info["CFBundleVersion"] as? String {
            
            return "Version \(currentVersion) build \(buildNumber)"
        }
        
        return "Verion 1.0 build 0"
    }
    
    
    static let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.timeZone = TimeZone(abbreviation: "GMT")
        formatter.dateFormat = Constants.DATE_FORMAT
        return formatter
    }()
    
    static let appDelegate = UIApplication.shared.delegate as! AppDelegate
    
    static var isIphoneXOrLater: Bool {
        // 812.0 on iPhone X, XS.
        // 896.0 on iPhone XS Max, XR.
        return UIScreen.main.bounds.height >= 812
    }
    
    static func hideKeyboard() {
        if let topcontroller = UIApplication.topViewController() {
            topcontroller.view.endEditing(true)
        }
    }
    
    static func controllerFromStoryboard(_ storyboardName: String, id: String) -> UIViewController {
        return UIStoryboard(name: storyboardName, bundle: nil).instantiateViewController(withIdentifier: id)
    }
    
    static func customizeStatusBarColor(_ color : UIColor = ColorManager.darkGreen) {
        let sharedApplication = UIApplication.shared
        sharedApplication.delegate?.window??.tintColor = color
        if #available(iOS 13.0, *) {
              let statusBar = UIView(frame: (sharedApplication.delegate?.window??.windowScene?.statusBarManager?.statusBarFrame)!)
              statusBar.backgroundColor = color
              sharedApplication.delegate?.window??.addSubview(statusBar)
          } else {
              // Fallback on earlier versions
            if let view = sharedApplication.value(forKey: "statusBar") as? UIView {
                view.backgroundColor = color
            }
        }
    }
    
    static func customizeNavigationBarAppearance() {
        UINavigationBar.appearance().isTranslucent = false
        UINavigationBar.appearance().tintColor = .white
        UINavigationBar.appearance().barTintColor = ColorManager.darkGreen
        UINavigationBar.appearance().titleTextAttributes = [.foregroundColor: UIColor.white]
    }
    
    
    static func showFontNames(){
        for family: String in UIFont.familyNames
        {
            print("\(family)")
            for names: String in UIFont.fontNames(forFamilyName: family)
            {
                print("== \(names)")
            }
        }
    }
    
    
    static func makeAttributedString(withImage image: UIImage, size: CGSize, font: UIFont) -> NSAttributedString {
        let attachment = NSTextAttachment()
        attachment.image = image
        
        let offsetY = font.capHeight/2 - image.size.height/2
        attachment.bounds = CGRect(x: 0, y: offsetY, width: image.size.width, height: image.size.height)
        let attachmentStr = NSAttributedString(attachment: attachment)
        
        return  attachmentStr
    }
    
    
    
    // ALERT UTILS
    static func showAlert(in vc: UIViewController? = nil, title: String? = nil, message: String, cancelButton: String, otherButton: [String]? = nil, buttonClickedHandler: ((Int) -> Void)? = nil) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        
        if let arrayButton = otherButton {
            for i in 1...arrayButton.count {
                alert.addAction(UIAlertAction(title: arrayButton[i-1], style: UIAlertAction.Style.default, handler: { _ in
                    if let handlerClosure = buttonClickedHandler {
                        handlerClosure(i)
                    }
                }))
            }
        }
        alert.addAction(UIAlertAction(title: cancelButton, style: UIAlertAction.Style.destructive, handler: { _ in
            if let handlerClosure = buttonClickedHandler {
                handlerClosure(0)
            }
        }))
        
        if let vc = vc {
            vc.present(alert, animated: true, completion: nil)
        }
        else {
            if let topVC = UIApplication.topViewController() {
                topVC.present(alert, animated: true, completion: nil)
            }
        }
    }
    
    
    
    static func showHUDIn(vc: UIViewController, text: String? = nil){
        if let t = text{
           let hud = MBProgressHUD.showAdded(to: vc.view, animated: true)
            hud.label.text = t
        }
        else{
            MBProgressHUD.showAdded(to: vc.view, animated: true)
        }
        
    }
    
    static func hideHUDIn(vc: UIViewController){
        MBProgressHUD.hide(for: vc.view, animated: true)
    }
    
    static func isValidUrl(_ urlString: String) -> Bool{
        if let url = URL(string: urlString) {
            return UIApplication.shared.canOpenURL(url)
        }
        
        return false
    }
}
