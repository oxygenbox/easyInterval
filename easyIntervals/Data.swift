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
    
    
    var colorizedTitle: NSMutableAttributedString {
        let font = UIFont(name: "AvenirNext-DemiBold", size: 20.0)!
        
        let runAttributes = [NSForegroundColorAttributeName: UIColor.run, NSFontAttributeName: font]
        let runString = NSMutableAttributedString(string: "run: \(runTimeString)", attributes: runAttributes)
        
        let walkAttributes = [NSForegroundColorAttributeName: UIColor.walk, NSFontAttributeName: font]
        let walkString = NSMutableAttributedString(string: "walk: \(walkTimeString)", attributes: walkAttributes)
        
        let space = NSMutableAttributedString(string: " ", attributes: runAttributes)
        
        let combination = NSMutableAttributedString()
        
        if data.isRunWalk {
            combination.append(runString)
            combination.append(space)
            combination.append(walkString)
        }else {
            combination.append(walkString)
            combination.append(space)
            combination.append(runString)
        }
    
        return combination
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
        
        return "Play Cadence Check\n Every \(freq)\nRun Interval"
    }
    
    var attrCadenceDescription: NSMutableAttributedString {
        var freq: String
        switch cadenceFrequency {
        case 0:
            freq = ""
        case 1:
            freq =  "Other"
        case 2:
            freq  = "Third"
        default:
            freq = "Fourth"
        }

        let lineA = "Play Cadence Check"
        let lineB = "Every \(freq)"
        let lineC = "Run Interval"
        
         return formatDescription(lineOne: lineA, lineTwo: lineB, lineThree: lineC)
    }
    
    var attrWorkoutDescription: NSMutableAttributedString {
        let minutes = sessionArray[sequenceRepeats]

        let lineA = "Set For A"
        let lineB = "\(minutes) Minute"
        let lineC = "Workout Session"
        
        return formatDescription(lineOne: lineA, lineTwo: lineB, lineThree: lineC)
    }
    
    
    var workoutDescription: String {
        let minutes = sessionArray[sequenceRepeats]
        return "Set for a\n \(minutes)\n minute workout"
    }

    func calcSessionIncrement() {
        var i = 0
        while (sessionSeconds / 60) * i < 30 {
            i += 1
        }
        sessionIncrement = (sessionSeconds / 60) * i
    }
    
    func formatDescription(lineOne: String, lineTwo: String, lineThree:String) -> NSMutableAttributedString {
        
        let fontA = UIFont(name: "AvenirNext-DemiBold", size: 18.0)!
        let fontB = UIFont(name: "AvenirNext-Bold", size: 20.0)!
        let mainAttributes = [NSForegroundColorAttributeName: UIColor.packDark, NSFontAttributeName: fontA]
        let lineOne = NSMutableAttributedString(string: "\(lineOne)\n", attributes: mainAttributes)
        let bigAttributes = [NSForegroundColorAttributeName: UIColor.bush, NSFontAttributeName: fontB]
        let lineTwo = NSMutableAttributedString(string: "\(lineTwo)\n", attributes: bigAttributes)
        let lineThree = NSMutableAttributedString(string: lineThree, attributes: mainAttributes)
        let combination = NSMutableAttributedString()
        
        combination.append(lineOne)
        combination.append(lineTwo)
        combination.append(lineThree)
        
        let style = NSMutableParagraphStyle()
        
        style.lineHeightMultiple = 0.8
        style.alignment = .center;
        style.lineSpacing = 1;
        style.lineBreakMode = .byWordWrapping
        style.alignment = .center
        
        combination.addAttribute(NSParagraphStyleAttributeName,
                                 value: style,
                                 range: NSMakeRange(0, combination.length))
        
        return combination
        
    }
    
}

let data = Data()





