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
        let attributes =  [NSFontAttributeName: UIFont(name: "Avenir Next", size: 30.0)!]
        //let attributes =  [NSFontAttributeName: UIFont(name: "Helvetica-Bold", size: 30.0)!]
        let mutableString = NSMutableAttributedString(string: mode, attributes: attributes)
        return mutableString
    }
    
    class func formatPickerTime(time: String) -> NSMutableAttributedString {
        let attribute = [NSFontAttributeName: UIFont(name: "Avenir Next", size: 36.0)!]
        let mutableString = NSMutableAttributedString(string: time, attributes: attribute)
        let myRange = NSRange(location: mutableString.length-3, length: 3)
       // mutableString.addAttribute(NSFontAttributeName, value: UIFont(name: "Helvetica-Bold", size: 24.0)!, range: myRange)
        mutableString.addAttribute(NSFontAttributeName, value: UIFont(name: "Avenir Next", size: 24.0)!, range: myRange)
        mutableString.addAttribute(NSUnderlineStyleAttributeName, value: NSUnderlineStyle.styleSingle.rawValue, range: myRange)
        mutableString.addAttribute(NSBaselineOffsetAttributeName , value: 6, range: myRange)
        return mutableString
    }


}
