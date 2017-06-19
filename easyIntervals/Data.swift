//
//  Data.swift
//  easyIntervals
//
//  Created by Michael Schaffner on 1/9/17.
//  Copyright © 2017 Michael Schaffner. All rights reserved.
//
import UIKit

enum Seq: Int {
    case runWalk = 0
    case walkRun = 1
    
    var name: String {
        switch self {
        case .runWalk:
             return "Run/Walk"
        default:
             return "Walk/Run"
        }
    }
}

enum Mode {
    case run
    case walk
    case paused

    var name: String {
        switch self {
        case .run:
            return "Run"
        case .walk:
            return "Walk"
        case .paused:
            return "Paused"
        }
    }
}

class Data: Settings {
    static var modeNameArray = [Seq.runWalk.name, Seq.walkRun.name]
    static var timeArray = ["1:00", "2:00", "3:00", "4:00", "5:00", "6:00", "7:00", "8:00", "9:00", "10:00"]
    
    var sessionIncrement: Int = 30
    
    var settingTitle: String {
        if isRunWalk {
            return "RUN: \(runTimeString)/WALK: \(walkTimeString)"
        } else {
            return "WALK: \(walkTimeString)/RUN: \(runTimeString)"
        }
    }
    
    var formattedTitle: NSMutableAttributedString {
        let font = UIFont(name: "AvenirNextCondensed-Regular", size: 20.0)!
        let charCount = settingTitle.characters.count
        let attributedString = NSMutableAttributedString(string: settingTitle)
        attributedString.addAttribute(NSForegroundColorAttributeName, value: UIColor.Theme.text, range: NSMakeRange(0, charCount))
        attributedString.addAttribute(NSFontAttributeName, value: font, range: NSMakeRange(0, charCount))
        
        return attributedString
    }
    
    var runIntervalInSeconds: Int {
        return (self.runValue + 1) * 60
    }
    
    var walkIntervalInSeconds: Int {
        return (self.walkValue + 1) * 60
    }
    
    var sessionSeconds: Int {
        return runIntervalInSeconds + walkIntervalInSeconds
    }
    
    var runTimeString: String {
        let minute = data.runValue + 1
        return "\(minute):00"
    }
    
    var walkTimeString: String {
        let minute = data.walkValue + 1
        return "\(minute):00"
    }
        
    var sessionArray: [Int] {
        var times = [Int]()
        for target in [30, 45, 60, 75, 90, 120] {
            let remainder = target % (sessionSeconds/60)
            times.append(target+remainder)
        }
        return times
    }
    
    var totalSessionSeconds: Int {
        let minutes = sessionArray[sequenceRepeats]
        return minutes*60
    }
    
    var cadenceDescription: String {
        var freq: String
        switch cadenceFrequency {
        case 0:
            freq = ""
        case 1:
            freq =  "Other "
        case 2:
            freq  = "Third "
        default:
            freq = "Fourth "
        }
        
        return "Play Cadence Check Every \(freq)Run Interval"
    }
    
    
    var workoutDescription: String {
        let minutes = sessionArray[sequenceRepeats]
        return "Set for a \(minutes) minute workout"
    }

    
    /*
     
     let attributeString = NSMutableAttributedString(string: text)
     let style = NSMutableParagraphStyle()
     
     
     style.lineSpacing = lineHeight
     style.lineHeightMultiple = 1
     style.alignment = .center;
     style.lineSpacing = 0.5;
     style.lineBreakMode = .byWordWrapping
     style.alignment = .center
     
     let charRange = NSMakeRange(0, text.characters.count)
     let fontName = UIFont(name: "AvenirNextCondensed-Regular", size: 16)
     
     attributeString.addAttribute(NSParagraphStyleAttributeName,
     value: style,
     range: NSMakeRange(0, text.characters.count))
     attributeString.addAttribute(NSForegroundColorAttributeName, value: UIColor.Theme.borderOn, range: charRange)
     
     attributeString.addAttribute(NSFontAttributeName, value: fontName!, range: charRange)
     
     
     
     
     self.attributedText = attributeString

     */
    
    
    func calcSessionIncrement() {
        var i = 0
        while (sessionSeconds / 60) * i < 30 {
            i += 1
        }
        sessionIncrement = (sessionSeconds / 60) * i
    }
    
}

let data = Data()





