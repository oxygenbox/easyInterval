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

enum Playstate {
    case stopped
    case paused
    case playing
    case complete
}


protocol WorkoutDelegate {
    func woTick()
    func modeUpdate()
    func modeChanged(to mode: Mode) 
    func workoutTick(remaining seconds: Int)
    func sessionComplete()
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
    var woSession:Session?
    
    var isPaused: Bool {
        return timer == nil
    }
    
    var isSession: Bool {
        return woSession != nil
    }
    
    var state: Playstate = .stopped
    
    //MARK:- Lifecycle
    override init() {
        super.init()
        cadenceTracker = 0
        setUp()
        
        if data.workoutOn {
            startSession()
        }
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
        switch state {
        case .stopped:
            state = .playing
            startTimer()
            speak(word: "start")
        case .paused:
            state = .playing
            startTimer()
            speak(word: currentMode.name.lowercased())
        case .playing:
            state = .paused
            pauseTimer()
            speak(word: "stop")
        case .complete:
            state = .playing
            startSession()
            startTimer()
            speak(word: "start")
        }
    }
    
    func startSession() {
        let secs = data.totalSessionSeconds
        woSession = Session(totalSecs: secs)
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
        
        if let cadenceTimer = cadenceTimer {
            cadenceTimer.invalidate()
            self.cadenceTimer = nil
        }
    }

    func tickOccured() {
        intervalTick()
        
        if woSession != nil {
            woSession!.tick()
        }
        
        guard let mainVC = delegate else {
            return
        }
        
        mainVC.workoutTick(remaining: currentInterval.remainingSeconds)
    }
    
    func intervalTick() {
        currentInterval.remainingSeconds -= 1
        elapsedSeconds += 1
        
        if currentInterval.countDown {
            let word = String(currentInterval.remainingSeconds)
            speak(word: word)
            vibrate()
        } else if currentInterval.complete {
            complete()
        }
    }
    
    func cadenceCheck() {
        
        guard let _ = timer else {
            return
        }
        
        if data.cadenceOn && currentMode == .run {
            if cadenceTracker < data.cadenceFrequency {
                cadenceTracker += 1
                
            } else {
                
                cadenceTimer = Timer.scheduledTimer(timeInterval: 5, target: self, selector: #selector(playCadence), userInfo: nil, repeats: false)
                RunLoop.main.add(cadenceTimer!, forMode: RunLoopMode.commonModes)
                cadenceTracker = 0
            }
        }
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
        if data.audioOn || word == "cadenceBeat" {
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
    
    func startNewInterval() {
        advance()
        speak(word: currentInterval.mode.name.lowercased())
        if let d = delegate {
            d.modeUpdate()
            d.modeChanged(to: currentMode)
        }
    }
    
    func complete() {
        if let session = woSession {
            if session.complete {
                //session.remainingSeconds = session.totalSeconds
                //session.elapsedSeconds = 0
                self.sessionComplete()
                return
            }
        }
        startNewInterval()
    }
    
    func sessionComplete() {
        pauseTimer()
        speak(word: "complete")
        guard  let d = delegate else {
            return
        }
        d.sessionComplete()
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

