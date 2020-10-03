//
//  Utils.swift
//  SwiftAppTemplate
//
//  Created by Nhan Nguyen on 12/29/16.
//  Copyright © 2016 Opiyn. All rights reserved.
//

import Foundation
import UIKit
import Photos
import MBProgressHUD
import MessageUI

struct ScreenSize
{
    static let SCREEN_WIDTH         = UIScreen.main.bounds.size.width
    static let SCREEN_HEIGHT        = UIScreen.main.bounds.size.height
    static let SCREEN_MAX_LENGTH    = max(ScreenSize.SCREEN_WIDTH, ScreenSize.SCREEN_HEIGHT)
    static let SCREEN_MIN_LENGTH    = min(ScreenSize.SCREEN_WIDTH, ScreenSize.SCREEN_HEIGHT)
}

struct DeviceType
{
    static let IS_IPHONE_4_OR_LESS  = UIDevice.current.userInterfaceIdiom == .phone && ScreenSize.SCREEN_MAX_LENGTH < 568.0
    static let IS_IPHONE_5          = UIDevice.current.userInterfaceIdiom == .phone && ScreenSize.SCREEN_MAX_LENGTH == 568.0
    static let IS_IPHONE_5_OR_LESS  = UIDevice.current.userInterfaceIdiom == .phone && ScreenSize.SCREEN_MAX_LENGTH < 667
    static let IS_IPHONE_6          = UIDevice.current.userInterfaceIdiom == .phone && ScreenSize.SCREEN_MAX_LENGTH == 667.0
    static let IS_IPHONE_6P         = UIDevice.current.userInterfaceIdiom == .phone && ScreenSize.SCREEN_MAX_LENGTH == 736.0
    static let IS_IPAD              = UIDevice.current.userInterfaceIdiom == .pad && ScreenSize.SCREEN_MAX_LENGTH == 1024.0
    
    static let IS_IPHONE = UIDevice.current.userInterfaceIdiom == .phone
    
    
}

struct UISetting {
    static let trendingFontSize: CGFloat = 15
    static let topOpiyneerStatementFontSize: CGFloat = DeviceType.IS_IPHONE_5_OR_LESS ? 22 : 24
    static let standardCornerRadius: CGFloat = 8
    static let size14: CGFloat = 15
    static let size18: CGFloat = 18
    static let standardFontSize : CGFloat = DeviceType.IS_IPHONE_5_OR_LESS ? 10 : 12
    static let smallFontSize : CGFloat = DeviceType.IS_IPHONE_5_OR_LESS ? 6 : 8
    static let statementFontSize : CGFloat = DeviceType.IS_IPHONE_5_OR_LESS ? 14: 16
    static let pageFontSize : CGFloat = 14
    static let searchOpiynUsageCount : CGFloat = 2
}




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
    
    static func setTimeout(_ delay: TimeInterval, block: @escaping () -> Void) -> Timer {
        return Timer.scheduledTimer(timeInterval: delay, target: BlockOperation(block: block), selector: #selector(BlockOperation.main), userInfo: nil, repeats: false)
    }
    
    static func setInterval(_ interval: TimeInterval, block: @escaping () -> Void) -> Timer {
        return Timer.scheduledTimer(timeInterval: interval, target: BlockOperation(block: block), selector: #selector(BlockOperation.main), userInfo: nil, repeats: true)
    }
    
    static func getImageFromAsset(_ asset: PHAsset, size: CGSize) -> UIImage {
        let manager = PHImageManager.default()
        let options = PHImageRequestOptions()
        var thumbnail: UIImage?
        options.isSynchronous = true
        options.resizeMode = .exact
        manager.requestImage(for: asset, targetSize: size, contentMode: .aspectFit, options: options, resultHandler: {
            (result, info) -> Void in
            thumbnail = result!
        })
        return thumbnail!
    }
    
    static func getImageDataFromAsset(_ asset: PHAsset, size: CGSize) -> Data {
        let manager = PHImageManager.default()
        let options = PHImageRequestOptions()
        var imageData: Data?
        options.isSynchronous = true
        //        option.resizeMode = .Fast
        manager.requestImage(for: asset, targetSize: size, contentMode: .aspectFit, options: options, resultHandler: {
            (result, info) -> Void in
            
            imageData = result!.pngData()
        })
        return imageData!
    }
    
    static func getPageIdFromUrl(_ url: String) -> String{
        let tokens = url.components(separatedBy: "/")
        return tokens[tokens.count - 1];
    }
    
    static func formatedString(ofNumber number: Int?) -> String{
        guard let number = number else {
            return "0"
        }
        
        if(number >= 1000){
            let i = Int(number/1000)
            
            return "\(i)k"
        }
        
        return "\(number)"
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
    
    static func actionSheetIn(vc: UIViewController, title: String? = nil, cancelButton: String, message: String? = nil, otherButton: [String]? = nil, buttonClickedHandler: ((Int) -> Void)? = nil) {
        let actionSheet = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.actionSheet)
        
        if let arrayButton = otherButton {
            for i in 0..<arrayButton.count {
                actionSheet.addAction(UIAlertAction(title: arrayButton[i], style: UIAlertAction.Style.default, handler: { _ in
                    if let handlerClosure = buttonClickedHandler {
                        handlerClosure(i)
                    }
                }))
            }
        }
        
        actionSheet.addAction(UIAlertAction(title: cancelButton, style: UIAlertAction.Style.destructive))
        
        if let popoverController = actionSheet.popoverPresentationController {
            popoverController.sourceView = vc.view
            popoverController.sourceRect = CGRect(x: vc.view.bounds.midX, y: vc.view.bounds.midY, width: 0, height: 0)
            popoverController.permittedArrowDirections = []
        }
        
        
        vc.present(actionSheet, animated: true, completion: nil)
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
    
    
    
    static func saveImage(imageName: String, image: UIImage) {
        
        guard let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else { return }
        
        let fileName = imageName
        let fileURL = documentsDirectory.appendingPathComponent(fileName)
        guard let data = image.jpegData(compressionQuality: 1) else { return }
        
        //Checks if file exists, removes it if so.
        if FileManager.default.fileExists(atPath: fileURL.path) {
            do {
                try FileManager.default.removeItem(atPath: fileURL.path)
                print("Removed old image")
            } catch let removeError {
                print("couldn't remove file at path", removeError)
            }
            
        }
        
        do {
            try data.write(to: fileURL)
        } catch let error {
            print("error saving file with error", error)
        }
        
    }
    
    static func saveReportFile(fileName: String, data: Data) -> URL?{
        
        guard let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else { return nil}
        
        let fileURL = documentsDirectory.appendingPathComponent(fileName)
        
        //Checks if file exists, removes it if so.
        if FileManager.default.fileExists(atPath: fileURL.path) {
            do {
                try FileManager.default.removeItem(atPath: fileURL.path)
                print("Removed old image")
            } catch let removeError {
                print("couldn't remove file at path", removeError)
                return nil
            }
            
        }
        
        do {
            try data.write(to: fileURL)
        } catch let error {
            print("error saving file with error", error)
            return nil
        }
        
        return fileURL
    }
    
    static func loadImage(fileName: String) -> UIImage? {
        
        let documentDirectory = FileManager.SearchPathDirectory.documentDirectory
        
        let userDomainMask = FileManager.SearchPathDomainMask.userDomainMask
        let paths = NSSearchPathForDirectoriesInDomains(documentDirectory, userDomainMask, true)
        
        if let dirPath = paths.first {
            let imageUrl = URL(fileURLWithPath: dirPath).appendingPathComponent(fileName)
            let image = UIImage(contentsOfFile: imageUrl.path)
            return image
        }
        
        return nil
    }
    
    static func loadReportFileData(fileName: String) -> Data? {
        
        let documentDirectory = FileManager.SearchPathDirectory.documentDirectory
        
        let userDomainMask = FileManager.SearchPathDomainMask.userDomainMask
        let paths = NSSearchPathForDirectoriesInDomains(documentDirectory, userDomainMask, true)
        
        if let dirPath = paths.first {
            let fileUrl = URL(fileURLWithPath: dirPath).appendingPathComponent(fileName)
            let data = try? Data(contentsOf: fileUrl)
            return data
        }
        
        return nil
    }
    
    static func deleteImage(fileName: String){
        DispatchQueue.main.async {
            let documentDirectory = FileManager.SearchPathDirectory.documentDirectory
            
            let userDomainMask = FileManager.SearchPathDomainMask.userDomainMask
            let paths = NSSearchPathForDirectoriesInDomains(documentDirectory, userDomainMask, true)
            
            if let dirPath = paths.first {
                let imageUrl = URL(fileURLWithPath: dirPath).appendingPathComponent(fileName)
                if FileManager.default.fileExists(atPath: imageUrl.path){
                    try? FileManager.default.removeItem(at: imageUrl)
                }
            }
        }
    }
    
    static func generateUniqueNumberId() -> String{
        let str = NSUUID().uuidString
        let str2 = str + "-" + NSUUID().uuidString
        
        var count : UInt32 = 0
        for c in str2{
            if let cc = c.unicodeScalars.first{
                count += cc.value
            }
            else{
                count += 0
            }
        }
        
        return "\(count)"
    }
    
    
    static func isValidUrl(_ urlString: String) -> Bool{
        if let url = URL(string: urlString) {
            return UIApplication.shared.canOpenURL(url)
        }
        
        return false
    }
}
