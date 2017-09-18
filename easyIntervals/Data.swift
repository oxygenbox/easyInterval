//
//  Data.swift
//  easyIntervals
//
//  Created by Michael Schaffner on 1/9/17.
//  Copyright © 2017 Michael Schaffner. All rights reserved.

struct State {
    var runValue: Int
    var walkValue: Int
    var sessionOn: Bool
    var isRunWalk: Bool
}


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
    var workout:Workout?
    var state: State?
    
    var settingTitle: String {
        if isRunWalk {
            return "RUN: \(runTimeString)/WALK: \(walkTimeString)"
        } else {
            return "WALK: \(walkTimeString)/RUN: \(runTimeString)"
        }
    }
    
    
    var colorizedTitle: NSMutableAttributedString {
        let font = UIFont(name: "AvenirNext-DemiBold", size: 20.0)!
        
        let runAttributes = [NSAttributedStringKey.foregroundColor: UIColor.run, NSAttributedStringKey.font: font]
        let runString = NSMutableAttributedString(string: "run: \(runTimeString)", attributes: runAttributes)
        
        let walkAttributes = [NSAttributedStringKey.foregroundColor: UIColor.walk, NSAttributedStringKey.font: font]
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
        attributedString.addAttribute(NSAttributedStringKey.foregroundColor, value: UIColor.Theme.text, range: NSMakeRange(0, charCount))
        attributedString.addAttribute(NSAttributedStringKey.font, value: font, range: NSMakeRange(0, charCount))
        
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
            freq =  "other "
        case 2:
            freq  = "third "
        default:
            freq = "fourth "
        }
        
        return "play cadence check\n every \(freq)\nrun interval"
    }
    
    var attrCadenceDescription: NSMutableAttributedString {
        var freq: String
        switch cadenceFrequency {
        case 0:
            freq = ""
        case 1:
            freq =  "other"
        case 2:
            freq  = "third"
        default:
            freq = "fourth"
        }

        let lineA = "play a cadence check"
        let lineB = "every \(freq)"
        let lineC = "run interval"
        
         return formatDescription(lineOne: lineA, lineTwo: lineB, lineThree: lineC)
    }
    
    var attrWorkoutDescription: NSMutableAttributedString {
        let minutes = sessionArray[sequenceRepeats]

        let lineA = "set for a"
        let lineB = "\(minutes) minute"
        let lineC = "workout session"
        
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
        
        let fontA = UIFont(name: "AvenirNext-DemiBold", size: 20.0)!
        let fontB = UIFont(name: "AvenirNext-Bold", size: 20.0)!
        let mainAttributes = [NSAttributedStringKey.foregroundColor: UIColor.white, NSAttributedStringKey.font: fontA]
        let lineOne = NSMutableAttributedString(string: "\(lineOne)\n", attributes: mainAttributes)
        let bigAttributes = [NSAttributedStringKey.foregroundColor: UIColor.white, NSAttributedStringKey.font: fontB]
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
        
        combination.addAttribute(NSAttributedStringKey.paragraphStyle,
                                 value: style,
                                 range: NSMakeRange(0, combination.length))
        
        return combination
        
    }
    
//    func formatStandardDescription(lineOne: String, lineTwo: String, lineThree:String) -> NSMutableAttributedString {
//        
//        let fontA = UIFont(name: "AvenirNext-DemiBold", size: 20.0)!
//        let fontB = UIFont(name: "AvenirNext-Bold", size: 20.0)!
//        let mainAttributes = [NSForegroundColorAttributeName: UIColor.white, NSFontAttributeName: fontA]
//        let lineOne = NSMutableAttributedString(string: "\(lineOne)\n", attributes: mainAttributes)
//        let bigAttributes = [NSForegroundColorAttributeName: UIColor.white, NSFontAttributeName: fontB]
//        let lineTwo = NSMutableAttributedString(string: "\(lineTwo)\n", attributes: bigAttributes)
//        let lineThree = NSMutableAttributedString(string: lineThree, attributes: mainAttributes)
//        let combination = NSMutableAttributedString()
//        
//        combination.append(lineOne)
//        combination.append(lineTwo)
//        combination.append(lineThree)
//        
//        let style = NSMutableParagraphStyle()
//        
//        style.lineHeightMultiple = 0.8
//        style.alignment = .center;
//        style.lineSpacing = 1;
//        style.lineBreakMode = .byWordWrapping
//        style.alignment = .center
//        
//        combination.addAttribute(NSParagraphStyleAttributeName,
//                                 value: style,
//                                 range: NSMakeRange(0, combination.length))
//        
//        return combination
//        
//    }

    
}

let data = Data()





