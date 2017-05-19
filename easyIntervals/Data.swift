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
    
//    var sessionSecondsArray: [Int] {
//        let sessionLength = [30, 45, 60, 75, 90, 120]
//        var times = [Int]()
//        
//        for target in sessionLength {
//            let seconds = target * 60
//            let mod = seconds % sessionSeconds
//            times.append(seconds + mod)
//        }
//        return times
//    }
//
//    var sessionMinuteArray: [Int] {
//        let sessionLength = [30, 45, 60, 75, 90, 120]
//        var times = [Int]()
//        
//        for target in sessionLength {
//            let seconds = target
//            let mod = seconds % sessionSeconds/60
//            times.append(seconds + mod)
//        }
//        return times
//    }
    
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
    
    

    func calcSessionIncrement() {
        var i = 0
        while (sessionSeconds / 60) * i < 30 {
            i += 1
        }
        sessionIncrement = (sessionSeconds / 60) * i
    }
    
}

let data = Data()





