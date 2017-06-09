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
        
        print("music \(musicOn)")
        
        
        
        defaults.synchronize()
    }
}

extension UIColor
{

//    
//    public class var base: UIColor {
//        return UIColor.white
//    }
    
//    public class var accent: UIColor {
//        return UIColor(red: 5/255, green: 85/255, blue: 179/255, alpha: 1.0)
//    }
//    


    
    //
    public class var blueA: UIColor {
        return UIColor(red: 227/255, green: 242/255, blue: 253/255, alpha: 1.0)
    }
    
    public class var blueB: UIColor {
        return UIColor(red: 187/255, green: 222/255, blue: 251/255, alpha: 1.0)
    }
    
    public class var blueC: UIColor {
        return UIColor(red: 144/255, green: 202/255, blue: 249/255, alpha: 1.0)
    }
    
    public class var blueD: UIColor {
        return UIColor(red: 100/255, green: 181/255, blue: 246/255, alpha: 1.0)
    }
    
    public class var blueE: UIColor {
        return UIColor(red: 66/255, green: 165/255, blue: 245/255, alpha: 1.0)
    }
    
    public class var blueF: UIColor {
        return UIColor(red: 33/255, green: 150/255, blue: 243/255, alpha: 1.0)
    }
    
    public class var orangeF: UIColor {
        return UIColor(red: 222/255, green: 105/255, blue: 12/255, alpha: 1.0)
    }
    
    public class var blueG: UIColor {
        return UIColor(red: 30/255, green: 136/255, blue: 229/255, alpha: 1.0)
    }
    
    public class var blueH: UIColor {
        return UIColor(red: 25/255, green: 118/255, blue: 210/255, alpha: 1.0)
    }
    
    public class var orangeH: UIColor {
        return UIColor(red: 230/255, green: 137/255, blue: 45/255, alpha: 1.0)
    }
    
    public class var blueI: UIColor {
        return UIColor(red: 21/255, green: 101/255, blue: 192/255, alpha: 1.0)
    }
    
    public class var blueJ: UIColor {
        return UIColor(red: 13/255, green: 71/255, blue: 161/255, alpha: 1.0)
    }
    
    struct Theme {
        static var base: UIColor {return .blueF}
        static var ibase: UIColor {return .orangeF}
        static var back: UIColor { return .white}
        static var buttonBar: UIColor {return .clear}
        static var text: UIColor {return .blueH}
        static var on: UIColor {return .blueC}
        static var off: UIColor {return .white}
        static var borderOn: UIColor {return .blueH}
        static var borderOff: UIColor {return .blueC}
        static var bar: UIColor {return .blueH}
        static var ibar: UIColor {return .orangeH}
    }
}


extension UIFont {
    public class var session: UIFont {
        return UIFont(name: "AvenirNextCondensed-Medium", size: 12.0)!
    }
    
    public class var cadence: UIFont {
        return UIFont(name: "AvenirNextCondensed-Medium", size: 12.0)!
    }
    
    public class var title: UIFont {
        return UIFont(name: "AvenirNextCondensed-Regular", size: 20.0)!
    }
    
    
    public class var setting: UIFont {
        return UIFont(name: "AvenirNextCondensed-Regular", size: 17.0)!
    }
}

extension UIImageView {
    func tintImageColor(color : UIColor) {
        self.image = self.image!.withRenderingMode(UIImageRenderingMode.alwaysTemplate)
        self.tintColor = color
    }
}

extension UILabel
{    
    func descFormat(lineHeight: CGFloat) {
        if let text = self.text {
            let attributeString = NSMutableAttributedString(string: text)
            let style = NSMutableParagraphStyle()
            
            
            style.lineSpacing = lineHeight
            style.lineHeightMultiple = 1
            style.alignment = .center;
            style.lineSpacing = 0.5;
            style.lineBreakMode = .byWordWrapping
            style.alignment = .center
            
            let charRange = NSMakeRange(0, text.characters.count)
            let fontName = UIFont(name: "AvenirNextCondensed-Regular", size: 16)
            
            attributeString.addAttribute(NSParagraphStyleAttributeName,
                                         value: style,
                                         range: NSMakeRange(0, text.characters.count))
            attributeString.addAttribute(NSForegroundColorAttributeName, value: UIColor.Theme.borderOn, range: charRange)
            
            attributeString.addAttribute(NSFontAttributeName, value: fontName!, range: charRange)
            
            
            
            
            self.attributedText = attributeString
        }

    }
    
    
}





/*
 //let attrString = NSMutableAttributedString(string: stringValue)
// let style = NSMutableParagraphStyle()
 style.lineSpacing = 0 // change line spacing between paragraph like 36 or 48
 style.minimumLineHeight = 8 // change line spacing between each line like 30 or 40
// attrString.addAttribute(NSParagraphStyleAttributeName, value: style, range: NSRange(location: 0, length: stringValue.characters.count))
// return attrString
 
 */


