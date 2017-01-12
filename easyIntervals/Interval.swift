//
//  Interval.swift
//  easyIntervals
//
//  Created by Michael Schaffner on 1/10/17.
//  Copyright © 2017 Michael Schaffner. All rights reserved.
//

import Foundation
import UIKit

class Interval {
    var lengthInSeconds: Int
    var remainingSeconds: Int
    var elapsedSeconds = 0
    var mode: Mode
    
    var countDown: Bool {
        if remainingSeconds < 6 && remainingSeconds > 0 {
            return true
        }
        return false
    }
    
    var complete: Bool {
        return remainingSeconds < 1
    }
    
    //MARK:- Methods
    init(mode: Mode) {
        self.mode = mode
        if mode == .run {
            remainingSeconds = data.runIntervalInSeconds
        } else {
            remainingSeconds =  data.walkIntervalInSeconds
        }
        lengthInSeconds = remainingSeconds
    }
    
    func tick() {
        elapsedSeconds += 1
        remainingSeconds -= 1
    }
    
    func reset() {
        elapsedSeconds = 0
        remainingSeconds = lengthInSeconds
    }
    
    func intervalPercent() -> CGFloat {
        let pct = CGFloat(remainingSeconds) / CGFloat(lengthInSeconds)
        return pct
    }
    
}
