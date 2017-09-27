//
//  InterfaceController.swift
//  easyIntervalsWachKitApp Extension
//
//  Created by Michael Schaffner on 9/7/17.
//  Copyright © 2017 Michael Schaffner. All rights reserved.
//

/*
 enum WKHapticType : Int {
 case Notification
 case DirectionUp
 case DirectionDown
 case Success
 case Failure
 case Retry
 case Start
 case Stop
 case Click
 }
 
 Add setting end and resume buttons
 Add haptics
 Add 30secm seconds increment
 Watch Icons
 */

import WatchKit
import Foundation

enum Mode: String {
    case run
    case walk
    case countDown
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
    
    //MARK - IBOUTLETS
    @IBOutlet var intervalTimeLabel: WKInterfaceLabel!
    @IBOutlet var elapsedTimeLabel: WKInterfaceLabel!
    
    @IBOutlet var settingsLabel: WKInterfaceLabel!
    
    @IBOutlet var intervalImage: WKInterfaceImage!
    @IBOutlet var startButton: WKInterfaceButton!
    @IBOutlet var pauseButton: WKInterfaceButton!
    @IBOutlet var endButton: WKInterfaceButton!
    @IBOutlet var settingButton: WKInterfaceButton!
    

    //MARK - IBACTIONS
    @IBAction func startTapped() {
        let mode = modes.last?.rawValue
        
        if let secondTimer = timer {
            //set interface
            startButton.setHidden(false)
            self.intervalImage.setHidden(true)
            pauseButton.setHidden(true)
            settingButton.setHidden(false)
            endButton.setHidden(false)
            //pause timer
            secondTimer.invalidate()
            timer = nil
        } else {
           //set interface
            countDown = 5
            startButton.setHidden(true)
            self.intervalImage.setHidden(false)
            pauseButton.setHidden(false)
            settingButton.setHidden(true)
            endButton.setHidden(true)
            
            //start Timer
            timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { (timer) in
                self.tickOccurred()
            }
             print("resume_\(mode!)")
        }
    }
    
    @IBAction func endWorkoutTapped() {
        endWorkout()
    }
    
    //MARK- LIFECYCLE
    override func awake(withContext context: Any?) {
        super.awake(withContext: context)
        // Configure interface objects here.
        setUp()
        
    }
    
    override func willActivate() {
        // This method is called when watch view controller is about to be visible to user
        super.willActivate()
        print("ACTIVATE")
    }//
    
    override func didDeactivate() {
        // This method is called when watch view controller is no longer visible
        super.didDeactivate()
    }

    //MARK _- MY METHODS
    func setUp(){
        intervalImage.setHidden(true)
        endButton.setHidden(true)
        pauseButton.setHidden(true)
       // getData()
        changeMode()
    }
    
//    func getData() {
//        let defaults = UserDefaults.standard
//
//        if defaults.bool(forKey: "isSaved") {
//            self.runSetting = defaults.integer(forKey: Keys.runSetting.rawValue)
//            self.walkSetting = defaults.integer(forKey: Keys.walkSetting.rawValue)
//        } else {
//            self.saveData()
//        }
  //  }
    
//    func saveData() {
//        let defaults = UserDefaults.standard
//        defaults.set(true, forKey: Keys.isSaved.rawValue)
//        defaults.set(runSetting, forKey: Keys.runSetting.rawValue)
//        defaults.set(walkSetting, forKey: Keys.walkSetting.rawValue)
//        print("save data")
//        defaults.synchronize()
//    }
    
    func changeMode() {
        let mode = modes.remove(at: 0)
        modes.append(mode)
        
        if mode == .run {
            intervalSeconds = data.runSeconds
            intervalImage.setImageNamed("run_icon")
            startButton.setBackgroundImageNamed("resume_run")
            WKInterfaceDevice.current().play(.directionUp)
        } else {
            intervalSeconds = data.walkSeconds
            intervalImage.setImageNamed("walk_icon")
            startButton.setBackgroundImageNamed("resume_walk")
            WKInterfaceDevice.current().play(.directionDown)
        }
        postTimes()
    }
    
    func tickOccurred() {
        elapsedSeconds += 1
        intervalSeconds -= 1
        postTimes()
        
        if intervalSeconds < 6 && intervalSeconds > 0 {
            let imageName = "countDown_\(intervalSeconds)"
            intervalImage.setImageNamed(imageName)
            WKInterfaceDevice.current().play(.click)
        }
        
        if intervalSeconds < 1 {
            self.changeMode()
        }
    }
    
    func postTimes() {
        elapsedTimeLabel.setText(data.formatTime(secs: elapsedSeconds, withHours: true))
        intervalTimeLabel.setText(data.formatTime(secs: intervalSeconds, withHours: false))
        
        settingsLabel.setText(data.intervalsMessage)
    }
    
    func endWorkout() {
        timer?.invalidate()
        timer = nil
        modes = [.run, .walk]
    }
    
    
}











