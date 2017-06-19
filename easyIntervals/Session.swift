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
        
       // print("total \(totalSeconds)")
       // print("remain \(remainingSeconds)")
      //  print("elpsed \(elapsedSeconds)")
    }

    override init() {
        super.init()
    }
    
    convenience init(totalSecs: Int) {
       self.init()
        self.totalSeconds = totalSecs
        remainingSeconds = totalSecs
    }
    
    
    
}
//    
//    override func advance() {
//        
//        if modeArray.count > 0 {
//            currentMode = modeArray.remove(at: 0)
//            currentInterval  = Interval(mode: currentMode)
//        } else {
//            print("SESSION COMPLETE")
//        }
//    }
    /*
     class Workout: NSObject, AVAudioPlayerDelegate {
     
     //MARK: Variables
     let tick: Double = 0.5
     var elapsedSeconds: Int = 0
     var timer: Timer?
     var delegate: WorkoutDelegate?
     var audioPlayer: AVAudioPlayer?
     var bgTaskIdentifier: UIBackgroundTaskIdentifier!
     var currentMode: Mode = .run
     var currentInterval: Interval!
     var modeArray = [Mode]()
     
     //MARK:- Lifecycle
     override init() {
     super.init()
     setUp()
     }
     
     //MARK:- Methods
     func setUp() {
     if data.isRunWalk {
     modeArray = [.run, .walk]
     } else {
     modeArray = [.walk, .run]
     }
     advance()
     }
     
     func advance() {
     let mode = modeArray.remove(at: 0)
     modeArray.append(mode)
     currentMode = mode
     currentInterval = Interval(mode: currentMode)
     }
     
     func toggleTimer() {
     if  timer == nil {
     startTimer()
     speak(word: "start")
     } else {
     pauseTimer()
     speak(word: "stop")
     }
     }
     
     func speak(word: String){
     if data.audioOn {
     do {
     let url = Bundle.main.url(forResource: word, withExtension: "caf")
     audioPlayer = try AVAudioPlayer(contentsOf: url!)
     audioPlayer!.delegate = self
     audioPlayer!.prepareToPlay()
     audioPlayer!.volume = 1
     audioPlayer!.play()
     } catch {
     print("Couldn't speak \(word)")
     }
     }
     }
     
     func tickOccured() {
     intervalTick()
     elapsedSeconds += 1
     
     if let d = delegate {
     d.woTick()
     d.percentComplete(pct: currentInterval.intervalPercent())
     }
     }
     
     func intervalSeconds() -> Int {
     return currentInterval.remainingSeconds
     }
     
     func intervalTick() {
     currentInterval.remainingSeconds -= 1
     
     if currentInterval.countDown {
     let word = String(currentInterval.remainingSeconds)
     speak(word: word)
     } else if currentInterval.complete {
     complete()
     }
     }
     
     func complete() {
     advance()
     speak(word: currentInterval.mode.name.lowercased())
     if let d = delegate {
     d.modeUpdate()
     }
     }
     
     func restart(mode: Mode) {
     if mode == currentMode {
     currentInterval.remainingSeconds = currentInterval.lengthInSeconds
     } else {
     advance()
     }
     }
     
     //MARK:- Timer Methods
     func startTimer() {
     bgTaskIdentifier = UIApplication.shared.beginBackgroundTask(expirationHandler: {
     UIApplication.shared.endBackgroundTask(self.bgTaskIdentifier)
     })
     
     timer = Timer.scheduledTimer(timeInterval: tick, target: self, selector: #selector(tickOccured), userInfo: nil, repeats: true)
     RunLoop.main.add(timer!, forMode: RunLoopMode.commonModes)
     }
     
     func pauseTimer() {
     if let timer = timer {
     timer.invalidate()
     self.timer = nil
     }
     }


    */
//}






