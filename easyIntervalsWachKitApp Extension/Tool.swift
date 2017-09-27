//
//  Tool.swift
//  easyIntervalsWachKitApp Extension
//
//  Created by Michael Schaffner on 9/11/17.
//  Copyright © 2017 Michael Schaffner. All rights reserved.
//

import Foundation


class Tool: NSObject
{
    func formatTime(secs: Int, withHours: Bool) -> String {
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
    
    func numberToString(value : Int) -> String {
        if value < 10 {
            return "0\(value)"
        }
        return "\(value)"
    }
    
    func formatInterval(secs: Int) -> String {
        var seconds = secs
        var minutes = seconds / 60
        seconds -= minutes * 60
        let hours = minutes / 60
        minutes -= hours * 60
        let minuteString = "\(minutes):"
        let secondString = numberToString(value: seconds)
        
        return minuteString + secondString
    }
}






