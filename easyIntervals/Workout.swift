//
//  Workout.swift
//  easyIntervals
//
//  Created by Michael Schaffner on 1/11/17.
//  Copyright © 2017 Michael Schaffner. All rights reserved.
//

import Foundation
import UIKit
import AVFoundation

protocol WorkoutDelegate {
    func woTick()
    func modeUpdate()
    func percentComplete(pct: CGFloat)
    
    func workoutTick(with percent: CGFloat)
}

class Workout: NSObject, AVAudioPlayerDelegate {
    //MARK: Variables
    let tick: Double = 1.0
    var elapsedSeconds: Int = 0
    var timer: Timer?
    var cadenceTimer: Timer?
    var delegate: WorkoutDelegate?
    var audioPlayer: AVAudioPlayer?
    
    var bgTaskIdentifier: UIBackgroundTaskIdentifier!
    var currentMode: Mode = .run
    var currentInterval: Interval!
    var modeArray = [Mode]()
    var cadenceTracker = 1
    
    //MARK:- Lifecycle
    override init() {
        super.init()
        cadenceTracker = 0
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
        cadenceCheck()
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

    func tickOccured() {
        intervalTick()
        elapsedSeconds += 1
        
        guard let timerViewController = delegate else {
            return
        }
        
       // timerViewController.woTick()
        timerViewController.workoutTick(with: currentInterval.intervalPercent())
        
//        if let d = delegate {
//            //            d.woTick()
//            //            d.percentComplete(pct: currentInterval.intervalPercent())
//        }
    }
    
    func intervalTick() {
        currentInterval.remainingSeconds -= 1
        if currentInterval.countDown {
            let word = String(currentInterval.remainingSeconds)
            speak(word: word)
            vibrate()
        } else if currentInterval.complete {
            complete()
        }
        
        if data.workoutOn {
            // print("WORKOUT \(data.sequenceRepeats * data.sessionIncrement)")
        }
    }
    
    
    
    func cadenceCheck() {
//        if data.cadenceOn && currentMode == .run {
//            if cadenceTracker == data.cadenceFrequency {
//                cadenceTimer = Timer.scheduledTimer(timeInterval: 5, target: self, selector: #selector(playCadence), userInfo: nil, repeats: false)
//                RunLoop.main.add(timer!, forMode: RunLoopMode.commonModes)
//                cadenceTracker = 0
//            }
//            cadenceTracker += 1
//        }
    }
    
    func playCadence() {
        speak(word: "cadenceBeat")
    }
    
    func vibrate() {
        if data.vibrateOn {
            AudioServicesPlaySystemSound(kSystemSoundID_Vibrate)
        }
    }
    
    
    func speak(word: String){
        if data.audioOn {
            do {
                let url = Bundle.main.url(forResource: word, withExtension: "caf")
                audioPlayer = try AVAudioPlayer(contentsOf: url!)
                audioPlayer!.delegate = self
                audioPlayer!.prepareToPlay()
                
                let audioSession = AVAudioSession.sharedInstance()
                
                do {
                    try audioSession.setCategory(AVAudioSessionCategoryPlayback)
                }
                
                audioPlayer!.volume = 1
                audioPlayer!.play()
            } catch {
                print("Couldn't speak \(word)")
            }
        }
    }
    
   
    
    func intervalSeconds() -> Int {
        return currentInterval.remainingSeconds
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
        
        if  let del = delegate  {
            del.modeUpdate()
        }
    }
    
    
    

}

