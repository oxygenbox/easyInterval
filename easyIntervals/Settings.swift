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

extension UIColor
{
    public class var off: UIColor
    {
        return UIColor(red: 236/255, green: 44/255, blue: 8/255, alpha: 1.0)
    }
    
    public class var on: UIColor
    {
        return UIColor(red: 250/255, green: 179/255, blue: 0/255, alpha: 1.0)
    }
    
    public class var myBlue: UIColor
    {
        return UIColor(red: 5/255, green: 85/255, blue: 179/255, alpha: 1.0)
    }
    
    public class var base: UIColor {
        return UIColor.white
    }
    
    public class var accent: UIColor {
        return UIColor(red: 5/255, green: 85/255, blue: 179/255, alpha: 1.0)
    }
    
    public class var blueA: UIColor {
        return UIColor(red: 225/255, green: 252/255, blue: 255/255, alpha: 1.0)
    }
    
    public class var blueB: UIColor {
        return UIColor(red: 149/255, green: 252/255, blue: 242/255, alpha: 1.0)
    }
    
    public class var blueC: UIColor {
        return UIColor(red: 114/255, green: 184/255, blue: 253/255, alpha: 1.0)
    }
    
    public class var blueD: UIColor {
        return UIColor(red: 144/255, green: 153/255, blue: 216/255, alpha: 1.0)
    }
    
    //
    public class var b50: UIColor {
        return UIColor(red: 227/255, green: 242/255, blue: 253/255, alpha: 1.0)
    }
    
    public class var b100: UIColor {
        return UIColor(red: 187/255, green: 222/255, blue: 251/255, alpha: 1.0)
    }
    
    public class var b200: UIColor {
        return UIColor(red: 144/255, green: 202/255, blue: 249/255, alpha: 1.0)
    }
    
    public class var b300: UIColor {
        return UIColor(red: 100/255, green: 181/255, blue: 246/255, alpha: 1.0)
    }
    
    public class var b400: UIColor {
        return UIColor(red: 66/255, green: 165/255, blue: 245/255, alpha: 1.0)
    }
    
    public class var b500: UIColor {
        return UIColor(red: 33/255, green: 150/255, blue: 243/255, alpha: 1.0)
    }
    
    public class var o500: UIColor {
        return UIColor(red: 222/255, green: 105/255, blue: 12/255, alpha: 1.0)
    }
    
    public class var b600: UIColor {
        return UIColor(red: 30/255, green: 136/255, blue: 229/255, alpha: 1.0)
    }
    
    public class var b700: UIColor {
        return UIColor(red: 25/255, green: 118/255, blue: 210/255, alpha: 1.0)
    }
    
    public class var o700: UIColor {
        return UIColor(red: 230/255, green: 137/255, blue: 45/255, alpha: 1.0)
    }
    
    public class var b800: UIColor {
        return UIColor(red: 21/255, green: 101/255, blue: 192/255, alpha: 1.0)
    }
    
    public class var b900: UIColor {
        return UIColor(red: 13/255, green: 71/255, blue: 161/255, alpha: 1.0)
    }
    
    struct Theme {
        static var base: UIColor {return .b500}
        static var ibase: UIColor {return .o500}
        static var back: UIColor { return .white}
        static var buttonBar: UIColor {return .clear}
        static var text: UIColor {return .b700}
        static var on: UIColor {return .b200}
        static var off: UIColor {return .white}
        
        
        static var bar: UIColor {return .b700}
        static var ibar: UIColor {return .o700}
        static var on: UIColor {return .b200}
         static var off: UIColor {return .white}
        static var borderOn: UIColor {return .b50}
        static var borderOff: UIColor {return .b900}
        static var textLight: UIColor {return .b50}
        static var windowStart: UIColor {return .b50}
        static var windowEnd: UIColor {return .b200}
    }
    
    struct OLDTheme {
        static var base: UIColor {return .b500}
        static var ibase: UIColor {return .o500}
        static var bar: UIColor {return .b700}
        static var ibar: UIColor {return .o700}
        static var on: UIColor {return .b200}
       
        static var borderOn: UIColor {return .b50}
        static var borderOff: UIColor {return .b900}
        static var textLight: UIColor {return .b50}
        static var windowStart: UIColor {return .b50}
        static var windowEnd: UIColor {return .b200}
    }
    
    
    
    struct Fonts {
        static var avenirNextCondMed: String {return "AvenirNextCondensed-Medium"}
    }
}


extension UIFont {
    public class var session: UIFont {
        return UIFont(name: "AvenirNextCondensed-Medium", size: 14.0)!
    }
    
    public class var cadence: UIFont {
        return UIFont(name: "AvenirNextCondensed-Medium", size: 12.0)!
    }
    
    public class var title: UIFont {
        return UIFont(name: "AvenirNextCondensed-Regular", size: 20.0)!
    }
}

extension UIImageView {
    func tintImageColor(color : UIColor) {
        self.image = self.image!.withRenderingMode(UIImageRenderingMode.alwaysTemplate)
        self.tintColor = color
    }
}


