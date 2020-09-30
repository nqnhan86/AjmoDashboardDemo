//
//  StringExt.swift
//  SwiftAppTemplate
//
//  Created by Nhan Nguyen on 12/29/16.
//  Copyright © 2016 Opiyn. All rights reserved.
//

import UIKit

extension Float {
    var beautyValueString : String {
        return self.truncatingRemainder(dividingBy: 1) == 0 ? String(format: "%.0f", self) : String(format:"%.1f", self)
    }
}

extension String {
    var isBackSpace : Bool {
        let char = self.cString(using: .utf8)
        return strcmp(char, "\\b") == -92
    }
    
    var floatValue : Float {
        if let value = Float(self) {
            return value
        }
        
        return 0
    }
    
    func intValue(separator: String? = " - ") -> Int {
        let arr = self.components(separatedBy: separator!)
        if arr.count > 0 {
            return (Int(arr[0]) ?? 0)
        }
        
        return (Int(self) ?? 0)
    }
    
    
    
    func strikethrough(withColor color: UIColor = ColorManager.darkGreen) -> NSMutableAttributedString {
        let attributeString: NSMutableAttributedString =  NSMutableAttributedString(string: self)
        attributeString.addAttribute(NSAttributedString.Key.strikethroughStyle,
                                     value: NSUnderlineStyle.single.rawValue,
                                     range: NSMakeRange(0, attributeString.length))
        attributeString.addAttributes([NSAttributedString.Key.strikethroughColor: color], range: NSMakeRange(0, attributeString.length))
        return attributeString
    }
    
    func trim() -> String {

        return trimmingCharacters(in: CharacterSet.whitespaces)
    }
    
    func formatString(_ font: UIFont, color: UIColor) -> NSMutableAttributedString {
        return NSMutableAttributedString(string: self, attributes: [ NSAttributedString.Key.font: font, NSAttributedString.Key.foregroundColor: color])
    }
    
    /**
     format some string in normal string.
     */
    func formatStringInString(font: UIFont = UIFont.systemFont(ofSize: 14),
                              color: UIColor = UIColor.black,
                              boldStrings: [String],
                              boldFonts: [UIFont],
                              boldColors: [UIColor]) -> NSMutableAttributedString {
        
        let attributedString =
            NSMutableAttributedString(string: self,attributes: [NSAttributedString.Key.font: font, NSAttributedString.Key.foregroundColor: color])
        
        for i in 0 ..< boldStrings.count {
            
            let boldColor = boldColors[boldColors.count == 1 ? 0 : i]
            let boldFont = boldFonts[boldFonts.count == 1 ? 0 : i]
            let boldFontAttribute = [
                NSAttributedString.Key.font: boldFont,
                NSAttributedString.Key.foregroundColor: boldColor
            ]
            attributedString.addAttributes(boldFontAttribute, range: (self as NSString).range(of: boldStrings[i]))
        }

        return attributedString
    }
    
    func formatStringInString(font: UIFont = UIFont.systemFont(ofSize: 14),
                              color: UIColor = UIColor.black,
                              boldStrings: [String],
                              boldFont: UIFont,
                              boldColor: UIColor) -> NSMutableAttributedString {
        
        let attributedString =
            NSMutableAttributedString(string: self,attributes: [NSAttributedString.Key.font: font, NSAttributedString.Key.foregroundColor: color])
        
        for i in 0 ..< boldStrings.count {
            let boldFontAttribute = [NSAttributedString.Key.font: boldFont, NSAttributedString.Key.foregroundColor: boldColor]
            attributedString.addAttributes(boldFontAttribute, range: (self as NSString).range(of: boldStrings[i]))
        }
        
        return attributedString
    }

    func formatStringInString(font: UIFont = UIFont.systemFont(ofSize: 14),
                              color: UIColor = UIColor.black,
                              boldStrings: [String],
                              boldFont: UIFont,
                              boldColor: UIColor,
                              lineHeight: CGFloat) -> NSMutableAttributedString {
        
        let style = NSMutableParagraphStyle()
        style.lineSpacing = lineHeight
        
        let attributedString =
            NSMutableAttributedString(string: self,attributes: [NSAttributedString.Key.font: font, NSAttributedString.Key.foregroundColor: color, NSAttributedString.Key.paragraphStyle : style])
        
        for i in 0 ..< boldStrings.count {
            let boldFontAttribute = [NSAttributedString.Key.font: boldFont, NSAttributedString.Key.foregroundColor: boldColor]
            attributedString.addAttributes(boldFontAttribute, range: (self as NSString).range(of: boldStrings[i]))
        }
        
        return attributedString
    }
    
    func formatParagraph(_ string: String, alignText: NSTextAlignment = NSTextAlignment.left, spacing: CGFloat = 7) -> NSAttributedString {
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = spacing
        paragraphStyle.alignment = alignText
        paragraphStyle.maximumLineHeight = 40
        let attributed = [NSAttributedString.Key.paragraphStyle:paragraphStyle]
        return NSAttributedString(string: string, attributes:attributed)
    }
    
    func estimateFrameForText(withFont font: UIFont, estimateSize: CGSize) -> CGRect {
        let options = NSStringDrawingOptions.usesFontLeading.union(.usesLineFragmentOrigin)
        return NSString(string: self).boundingRect(with: estimateSize, options: options, attributes: [NSAttributedString.Key.font: font], context: nil)
    }
    
    
    
    func underlineText(with font: UIFont, color: UIColor)-> NSMutableAttributedString{
        
        return NSMutableAttributedString(string: self,
                                         attributes: [NSAttributedString.Key.font : font,
                                                      NSAttributedString.Key.foregroundColor : color,
                                                      NSAttributedString.Key.underlineStyle : NSUnderlineStyle.single.rawValue
            ])
    }
    
    func underlineSubstring(substrings: [String], with font: UIFont, color: UIColor) -> NSMutableAttributedString{
        let attributedText = NSMutableAttributedString(string: self)
        for str in substrings{
            if let textRange = self.range(of: str) {
                let nsRange = NSRange(textRange, in: self)
                // Add  attributes
                attributedText.addAttribute(NSAttributedString.Key.underlineStyle , value: NSUnderlineStyle.single.rawValue, range: nsRange)
                attributedText.addAttribute(NSAttributedString.Key.font , value: font, range: nsRange)
                attributedText.addAttribute(NSAttributedString.Key.foregroundColor , value: color, range: nsRange)
            }
            
        }
        
        
       return attributedText
    }
    
    func toDate(withFormat dateFormat: String, locale: Locale? = nil) -> Date {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = dateFormat
        if let l = locale{
            dateFormatter.locale = l
        }
        else{
            dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        }
        dateFormatter.timeZone = TimeZone.current //Current time zone
        
        
        if let date = dateFormatter.date(from: self) {
            return date
        }
        
        return Date()
    }
}

extension String {
    
    func formatThousandSeparator(_ separatorCharacter: String = " ") -> String {
        
        guard let numberFromString = Int32(self) else { return self }
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.groupingSeparator = separatorCharacter
        let formattedString = formatter.string(from: NSNumber(value: numberFromString as Int32 as Int32))
        return formattedString != nil ? formattedString! : self
    }
    
    func isValidEmail() -> Bool {

        let emailRegEx = "^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?(?:\\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?)*$"
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailTest.evaluate(with: self)
    }
    
    func splitString(_ separator: String) -> [String] {
        return components(separatedBy: separator)
    }
    
   
    
    
    func height(withConstrainedWidth width: CGFloat, font: UIFont) -> CGFloat {
        let constraintRect = CGSize(width: width, height: .greatestFiniteMagnitude)
        let boundingBox = self.boundingRect(with: constraintRect, options: .usesLineFragmentOrigin, attributes: [NSAttributedString.Key.font: font], context: nil)
        
        return boundingBox.height
    }
    
    func toDictionary() -> [String: Any]?{
        if let data = self.data(using: .utf8) {
            do {
                return try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any]
            } catch {
                print(error.localizedDescription)
            }
        }
        return nil
    }
}

extension NSAttributedString {
    
    func estimateFrameForText(withSize size: CGSize) -> CGRect {
        
        let options = NSStringDrawingOptions.usesFontLeading.union(.usesLineFragmentOrigin)
        return boundingRect(with: size, options: options, context: nil)

    }
    
    
    func height(withConstrainedWidth width: CGFloat) -> CGFloat {
        let constraintRect = CGSize(width: width, height: .greatestFiniteMagnitude)
        let boundingBox = boundingRect(with: constraintRect, options: .usesLineFragmentOrigin, context: nil)
        
        return boundingBox.height
    }
    
    func width(withConstrainedHeight height: CGFloat) -> CGFloat {
        let constraintRect = CGSize(width: .greatestFiniteMagnitude, height: height)
        let boundingBox = boundingRect(with: constraintRect, options: .usesLineFragmentOrigin, context: nil)
        
        return boundingBox.width
    }
}






