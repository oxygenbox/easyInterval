//
//  Tool.swift
//  easyIntervals
//
//  Created by Michael Schaffner on 1/11/17.
//  Copyright © 2017 Michael Schaffner. All rights reserved.
//

import Foundation
import  UIKit

//let tool = Tool()

class Tool {
    class  func intervalTimeFormatted(seconds:Int) -> NSMutableAttributedString {
        let timeString = formatTime(secs: seconds, withHours: false)
        let charCount = timeString.characters.count
        let font = UIFont(name: "AvenirNext-Bold", size: 120)
        let attributedString = NSMutableAttributedString(string: timeString)
        attributedString.addAttribute(NSKernAttributeName, value: -4, range: NSMakeRange(0, charCount))
        attributedString.addAttribute(NSForegroundColorAttributeName, value: UIColor.Theme.text, range: NSMakeRange(0, charCount))
        attributedString.addAttribute(NSFontAttributeName, value: font!, range: NSMakeRange(0, charCount))
        return attributedString
    }
    
    class func elapsedTimeFormatted(seconds: Int) -> NSMutableAttributedString {
        let timeString = formatTime(secs: seconds, withHours: true)
        let attributedString = NSMutableAttributedString(string: timeString)
        let charCount = timeString.characters.count
        let font = UIFont(name: "AvenirNext-DemiBold", size: 48)!
        attributedString.addAttribute(NSKernAttributeName, value: -4, range: NSMakeRange(0, charCount))
        attributedString.addAttribute(NSForegroundColorAttributeName, value: UIColor.Theme.text, range: NSMakeRange(0, charCount))
        attributedString.addAttribute(NSFontAttributeName, value: font, range: NSMakeRange(0, charCount))
        return attributedString
    }
    
    class func formatTime(secs: Int, withHours: Bool) -> String {
        var seconds = secs
        var minutes = seconds / 60
        seconds -= minutes * 60
        let hours = minutes / 60
        minutes -= hours * 60
        let hourString = numberToString(value: hours)
        let minuteString = numberToString(value: minutes)
        let secondString = numberToString(value: seconds)
        
        if withHours {
            return "\(hourString):\(minuteString):\(secondString)"
        }
        
        return "\(minuteString):\(secondString)"
    }
    
    class func numberToString(value : Int) -> String {
        if value < 10 {
            return "0\(value)"
        }
        return "\(value)"
    }
    
    class func formatPickerMode(mode: String) -> NSMutableAttributedString {
        let attributes =  [NSFontAttributeName: UIFont(name: "AvenirNext-DemiBold", size: 24.0)!]
        let mutableString = NSMutableAttributedString(string: mode, attributes: attributes)
        if mode == "Run/Walk" {
             let runRange =  NSRange(location:0,length:3)
            mutableString.addAttribute(NSForegroundColorAttributeName, value: UIColor.run, range: runRange)
             let walkRange =  NSRange(location:4,length:4)
            mutableString.addAttribute(NSForegroundColorAttributeName, value: UIColor.walk, range: walkRange)
        } else {
            let walkRange =  NSRange(location:0,length:4)
            mutableString.addAttribute(NSForegroundColorAttributeName, value: UIColor.walk, range: walkRange)
            let runRange =  NSRange(location:5,length:3)
            mutableString.addAttribute(NSForegroundColorAttributeName, value: UIColor.run, range: runRange)
        }
        
        
        
        
        return mutableString
    }
    
    class func formatPickerTime(time: String) -> NSMutableAttributedString {
        let attribute = [NSFontAttributeName: UIFont(name: "AvenirNextCondensed-Bold", size: 45.0)!]
        let attributedString = NSMutableAttributedString(string: time, attributes: attribute)
        let myRange = NSRange(location: attributedString.length-3, length: 3)
        attributedString.addAttribute(NSFontAttributeName, value: UIFont(name: "AvenirNextCondensed-DemiBold", size: 36.0)!, range: myRange)
        attributedString.addAttribute(NSUnderlineStyleAttributeName, value: NSUnderlineStyle.styleSingle.rawValue, range: myRange)
        attributedString.addAttribute(NSBaselineOffsetAttributeName , value: 6, range: myRange)
        attributedString.addAttribute(NSForegroundColorAttributeName, value: UIColor.primary, range: NSMakeRange(0, time.characters.count))
        return attributedString
    }
    
    
}



