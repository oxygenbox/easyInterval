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
    case firstVisit
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
    var firstVisit: Bool = true
    
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
            firstVisit = defaults.bool(forKey: BoolKey.firstVisit.rawValue)
            
            
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
        defaults.set(firstVisit, forKey: BoolKey.firstVisit.rawValue)
        
        defaults.set(runValue, forKey: IntKey.runValue.rawValue)
        defaults.set(walkValue, forKey: IntKey.walkValue.rawValue)
        defaults.set(sequenceRepeats, forKey: IntKey.sequenceRepeats.rawValue)
        defaults.set(cadenceFrequency, forKey: IntKey.cadenceFrequency.rawValue)
        defaults.set(settingsTab, forKey: IntKey.settingsTab.rawValue)
        
        
        defaults.synchronize()
    }
}

extension UIColor {
    
    public class var jake: UIColor {
        return UIColor(red: 254/255, green: 188/255, blue: 29/255, alpha: 1)
    }

    public class var packLight: UIColor {
        return UIColor (red: 160/255, green: 229/255, blue: 122/255, alpha: 1)
    }
    
    public class var packDark: UIColor {
        return UIColor(red: 82/255, green: 165/255, blue: 35/255, alpha: 1)
    }

    public class var run: UIColor {
        return UIColor(red: 0/255, green: 152/255, blue: 200/255, alpha: 1)
    }
    
    public class var walk: UIColor {
       return UIColor(red: 1/255, green: 100/255, blue: 204/255, alpha: 1)
    }
    
    public class var background: UIColor {
        return packLight
    }
    
    public class var dot: UIColor {
        return jake
    }
    
    public class var grass: UIColor {
        return UIColor(red: 99/255, green: 187/255, blue: 87/255, alpha: 1)
    }
    
    public class var bush: UIColor {
        return UIColor(red: 32/255, green: 116/255, blue: 28/255, alpha: 1)
    }
    
    public class var activeButton: UIColor {
        return .bush
    }
    
    public class var primary: UIColor {
        return UIColor(red: 70/255, green: 53/255, blue: 43/255, alpha: 1)
    }
    
    public class var secondary: UIColor {
        return UIColor(red: 16/255, green: 103/255, blue:122/255, alpha: 1)
    }
    
    public class var highlight: UIColor {
        return UIColor(red: 255/255, green: 250/255, blue: 98/255, alpha: 1)
    }
    
    struct Theme {
        static var base: UIColor {return .secondary}
       
        static var back: UIColor { return .white}
        static var buttonBar: UIColor {return .clear}
        static var text: UIColor {return .packDark}
        static var on: UIColor {return .packDark}
        static var off: UIColor {return .packLight}
        static var borderOn: UIColor {return .bush}
        static var borderOff: UIColor {return .packDark}
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
            
         //   let charRange = NSMakeRange(0, text.characters.count)
         //   let fontName = UIFont(name: "AvenirNextCondensed-Regular", size: 16)
            
            attributeString.addAttribute(NSParagraphStyleAttributeName,
                                         value: style,
                                         range: NSMakeRange(0, text.characters.count))
           // attributeString.addAttribute(NSForegroundColorAttributeName, value: UIColor.white, range: charRange)
            
           // attributeString.addAttribute(NSFontAttributeName, value: fontName!, range: charRange)
            
            self.attributedText = attributeString
        }
    }
}






