//
//  Session.swift
//  easyIntervals
//
//  Created by Michael Schaffner on 1/10/17.
//  Copyright © 2017 Michael Schaffner. All rights reserved.
//

import UIKit
import AVFoundation
//
protocol SessionDelegate {

}
//
class Session: NSObject {
    var totalSeconds: Int = 0
    var remainingSeconds: Int = 0
    var elapsedSeconds: Int = 0
    
    var complete: Bool {
        return remainingSeconds <= 1
    }
    
     func tick() {
        remainingSeconds -= 1
        elapsedSeconds += 1
    }

    override init() {
        super.init()
    }
    
    convenience init(totalSecs: Int) {
       self.init()
        self.totalSeconds = totalSecs
        self.remainingSeconds = totalSecs
    }
}






