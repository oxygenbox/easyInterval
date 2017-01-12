//
//  Settings.swift
//  easyIntervals
//
//  Created by Michael Schaffner on 1/9/17.
//  Copyright © 2017 Michael Schaffner. All rights reserved.
//

import UIKit

enum BoolKey: String {
    case isSaved
    case audioOn
    case vibrateOn
    case cadenceOn
    case musicOn
    case workoutOn
    case isRunWalk
}

enum IntKey: String {
    case runValue
    case walkValue
    case sequenceRepeats
    case cadenceFrequency
    case settingsTab
}

class Settings {
    //MARK: Variables
    var isSaved = false
    var audioOn = true
    var vibrateOn = true
    var cadenceOn = false
    var musicOn = true
    var workoutOn = false
    var isRunWalk = true
   
    var runValue = 4
    var walkValue = 0
    var sequenceRepeats = 0
    var cadenceFrequency = 0
    var settingsTab = 0
    
   
    
    //MARK: Methods
    init() {
        print("init settings")
        get()
    }
    
    func get() {
        let defaults = UserDefaults.standard
        if !defaults.bool(forKey: BoolKey.isSaved.rawValue) {
            save()
        } else {
            audioOn = defaults.bool(forKey: BoolKey.audioOn.rawValue)
            vibrateOn = defaults.bool(forKey: BoolKey.vibrateOn.rawValue)
            cadenceOn = defaults.bool(forKey: BoolKey.cadenceOn.rawValue)
            musicOn = defaults.bool(forKey: BoolKey.musicOn.rawValue)
            workoutOn = defaults.bool(forKey: BoolKey.workoutOn.rawValue)
            isRunWalk = defaults.bool(forKey: BoolKey.isRunWalk.rawValue)
            
            runValue = defaults.value(forKeyPath: IntKey.runValue.rawValue) as! Int
            walkValue = defaults.value(forKeyPath: IntKey.walkValue.rawValue) as! Int
            sequenceRepeats = defaults.value(forKeyPath: IntKey.sequenceRepeats.rawValue) as! Int
            cadenceFrequency = defaults.value(forKeyPath: IntKey.cadenceFrequency.rawValue) as! Int
            settingsTab = defaults.value(forKeyPath: IntKey.settingsTab.rawValue) as! Int
        }
    }
    
    func save() {
        let defaults = UserDefaults.standard
        defaults.set(true, forKey: BoolKey.isSaved.rawValue)
        defaults.set(audioOn, forKey: BoolKey.audioOn.rawValue)
        defaults.set(vibrateOn, forKey: BoolKey.vibrateOn.rawValue)
        defaults.set(cadenceOn, forKey: BoolKey.cadenceOn.rawValue)
        defaults.set(musicOn, forKey: BoolKey.musicOn.rawValue)
        defaults.set(workoutOn, forKey: BoolKey.workoutOn.rawValue)
        defaults.set(isRunWalk, forKey: BoolKey.isRunWalk.rawValue)
        
        defaults.set(runValue, forKey: IntKey.runValue.rawValue)
        defaults.set(walkValue, forKey: IntKey.walkValue.rawValue)
        defaults.set(sequenceRepeats, forKey: IntKey.sequenceRepeats.rawValue)
        defaults.set(cadenceFrequency, forKey: IntKey.cadenceFrequency.rawValue)
        defaults.set(settingsTab, forKey: IntKey.settingsTab.rawValue)
        
        defaults.synchronize()
    }
    
    
}

