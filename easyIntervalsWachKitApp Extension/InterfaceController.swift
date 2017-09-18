//
//  InterfaceController.swift
//  easyIntervalsWachKitApp Extension
//
//  Created by Michael Schaffner on 9/7/17.
//  Copyright © 2017 Michael Schaffner. All rights reserved.
//

import WatchKit
import Foundation

enum Mode: String {
    case run
    case walk
    case countDown
}

enum Keys: String {
    case isSaved
    case runSetting
    case walkSetting
}

class InterfaceController: WKInterfaceController {
    let tool = Tool()
    
    var timer: Timer?
    
    var elapsedSeconds = 0
    var intervalSeconds = 10 * 60
    var runSetting = 4
    var walkSetting = 0
    var countDown = 5
    
    var modes:[Mode] = [.run, .walk]
    
    @IBOutlet var intervalTimeLabel: WKInterfaceLabel!
    @IBOutlet var elapsedTimeLabel: WKInterfaceLabel!
    @IBOutlet var intervalImage: WKInterfaceImage!
    
    @IBOutlet var startButton: WKInterfaceButton!
    
    override func awake(withContext context: Any?) {
        super.awake(withContext: context)
        
        // Configure interface objects here.
    }
    
    @IBAction func startTapped() {
        if let secondTimer = timer {
            secondTimer.invalidate()
            timer = nil

        } else {
            modes = [.countDown, .run, .walk]
            countDown = 5
            startButton.setHidden(true)
            self.intervalImage.setHidden(false)
            timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { (timer) in
                self.tickOccurred()
            }
        }
    }
    
    override func willActivate() {
        // This method is called when watch view controller is about to be visible to user
        super.willActivate()
        intervalImage.setHidden(true)
        getData()
        changeMode()
    }
    
    override func didDeactivate() {
        // This method is called when watch view controller is no longer visible
        super.didDeactivate()
    }

    //my methods
    func getData() {
        let defaults = UserDefaults.standard
        
        if defaults.bool(forKey: "isSaved") {
            self.runSetting = defaults.integer(forKey: Keys.runSetting.rawValue)
            self.walkSetting = defaults.integer(forKey: Keys.walkSetting.rawValue)
            print("got dataAA")
        } else {
            self.saveData()
            print("first fisit")
        }
    }
    
    func saveData() {
        let defaults = UserDefaults.standard
        defaults.set(true, forKey: Keys.isSaved.rawValue)
        defaults.set(runSetting, forKey: Keys.runSetting.rawValue)
        defaults.set(walkSetting, forKey: Keys.walkSetting.rawValue)
        print("save data")
        defaults.synchronize()
    }
    
    func changeMode() {
        let mode = modes.remove(at: 0)
        modes.append(mode)
        
        if mode == .run {
            intervalSeconds = (runSetting + 1) * 60
            intervalImage.setImageNamed("run_icon")
        } else {
            intervalSeconds = (walkSetting + 1) * 60
            intervalImage.setImageNamed("walk_icon")
        }
        postTimes()
    }
    
    func tickOccurred() {
        
        if intervalSeconds < 6 && intervalSeconds > 0 {
            let imageName = "countDown_\(intervalSeconds)"
           
            intervalImage.setImageNamed(imageName)
        }
        
        if intervalSeconds < 1 {
            self.changeMode()
        }
        
        elapsedSeconds += 1
        intervalSeconds -= 1
        postTimes()
    }
    
    func postTimes() {
        
        elapsedTimeLabel.setText(tool.formatTime(secs: elapsedSeconds, withHours: true))
        intervalTimeLabel.setText(tool.formatTime(secs: intervalSeconds, withHours: false))
    }
}











