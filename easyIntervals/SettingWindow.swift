//
//  SettingWindow.swift
//  easyIntervals
//
//  Created by Michael Schaffner on 6/1/17.
//  Copyright © 2017 Michael Schaffner. All rights reserved.
//

import UIKit

class SettingWindow: UIView {
    @IBOutlet weak var iconImage: UIImageView!
    @IBOutlet weak var descLabel: UILabel!
    @IBOutlet weak var prefSwitch: UISwitch!
    //@IBOutlet weak var controlLabel: UILabel!
    @IBOutlet weak var cadenceControl: UISegmentedControl!
    @IBOutlet weak var sessionControl: UISegmentedControl!

    
    var preference: Preference = .info {
        didSet {
            setUp()
        }
    }
    
    
    var cadenceString: NSMutableAttributedString {
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = -3
        var string: String
        switch data.cadenceFrequency {
            case 0:
                string = ""
            case 1:
                string =  "Other"
            case 2:
            string  = "Third"
            default:
             string = "Fourth"
        }
        
        let attributedString = NSMutableAttributedString(string: "Play Cadence Check Every \(string) Run Interval")
         attributedString.addAttribute(NSParagraphStyleAttributeName, value:paragraphStyle, range:NSMakeRange(0, attributedString.length))
        
        return attributedString

    }

    
    var workoutString: NSMutableAttributedString {
        let minutes = data.sessionArray[data.sequenceRepeats]
       // return "Ready for a \(minutes) minute workout"
        
         let attributedString = NSMutableAttributedString(string: "Ready for a \(minutes) minute workout")
         
         // *** Create instance of `NSMutableParagraphStyle`
         let paragraphStyle = NSMutableParagraphStyle()
         
         // *** set LineSpacing property in points ***
         paragraphStyle.lineSpacing = -5
         
         // *** Apply attribute to string ***
         attributedString.addAttribute(NSParagraphStyleAttributeName, value:paragraphStyle, range:NSMakeRange(0, attributedString.length))
         
         // *** Set Attributed String to your label ***
         return attributedString
    }
    
    
    var sessionMessage: String {
        let minutes = data.sessionArray[data.sequenceRepeats]
        return "Ready for a \(minutes) minute workout"
    }
    
    override func didMoveToWindow() {
        super.didMoveToWindow()
        layer.cornerRadius = frame.size.width/2
        layer.borderColor = UIColor.Theme.base.cgColor
        layer.borderWidth = 1
        
        backgroundColor = UIColor.Theme.on
     //   controlLabel.font = UIFont.cadence
      //  controlLabel.textColor = UIColor.Theme.borderOn
        
        //init segmentedControls
        sessionControl.tintColor = UIColor.Theme.borderOn
        cadenceControl.tintColor = UIColor.Theme.borderOn
        cadenceControl.setTitleTextAttributes([NSFontAttributeName: UIFont.cadence],
                                              for: .normal)
        sessionControl.setTitleTextAttributes([NSFontAttributeName: UIFont.session],
                                              for: .normal)
        
        descLabel.font = UIFont.setting
        descLabel.textAlignment = .center
        descLabel.textColor = UIColor.Theme.borderOn

    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func setUp() {
        switch preference {
        case .audio:
            prefSwitch.isOn = data.audioOn
            iconImage.image = UIImage(named: "audio_panel")
            descLabel.attributedText = makeAttributed(stringValue: preference.desc)
        case .vibrate:
            prefSwitch.isOn = data.vibrateOn
            iconImage.image = UIImage(named: "vibrate_panel")
            descLabel.attributedText = makeAttributed(stringValue: preference.desc)
        case .cadence:
            prefSwitch.isOn = data.cadenceOn
            iconImage.image = UIImage(named: "cadence_panel")
            cadenceControl.isEnabled = data.cadenceOn
            cadenceControl.selectedSegmentIndex = data.cadenceFrequency
            initSegmentedControl()
            descLabel.attributedText = cadenceString
            
        case .music:
            prefSwitch.isOn = data.musicOn
            iconImage.image = UIImage(named: "music_panel")
             descLabel.attributedText = makeAttributed(stringValue: preference.desc)
           
        case .workout:
            prefSwitch.isOn = data.workoutOn
            iconImage.image = UIImage(named: "session_panel")
            sessionControl.isEnabled = data.workoutOn
            sessionControl.selectedSegmentIndex = data.sequenceRepeats
            initSegmentedControl()
            descLabel.text = sessionMessage
            descLabel.attributedText = workoutString
        default:
            iconImage.image = nil
            descLabel.attributedText = makeAttributed(stringValue: preference.desc)
            break
        }
        
        
        
    
        
        prefSwitch.isHidden = preference == .info
        sessionControl.isHidden = preference != .workout
        cadenceControl.isHidden = preference != .cadence
        
        if !sessionControl.isHidden || !cadenceControl.isHidden {
          //  controlLabel.isHidden = false
          //  controlLabel.isHidden = true
        } else {
          //  controlLabel.isHidden = true
        }
        
        setAppearance()
         descLabel.setLineHeight(lineHeight: 2)
    }
    
    func initSegmentedControl() {
        if preference == .workout {
            sessionControl.isHidden = false
            cadenceControl.isHidden = true
            sessionControl.isEnabled = data.workoutOn
            sessionControl.selectedSegmentIndex = data.sequenceRepeats
            
            for (index, minutes) in data.sessionArray.enumerated() {
                sessionControl.setTitle("\(minutes)", forSegmentAt: index)
            }
        } else if preference == .cadence {
            sessionControl.isHidden = true
            cadenceControl.isHidden = false
            cadenceControl.isEnabled = data.cadenceOn
            cadenceControl.selectedSegmentIndex = data.cadenceFrequency
        } else {
            sessionControl.isHidden = true
            cadenceControl.isHidden = true
        }
        postControlMessage()
    }
    
    func postControlMessage() {
        if preference == .workout {
            descLabel.attributedText = workoutString
        } else if preference == .cadence {
            descLabel.attributedText = cadenceString
        } else {
          //  controlLabel.text = ""
        }
    }

    func setAppearance(){
        if prefSwitch.isOn {
            backgroundColor = UIColor.Theme.on
            iconImage.tintColor = UIColor.Theme.off
        }else {
            backgroundColor = UIColor.Theme.off
            iconImage.tintColor = UIColor.Theme.on
        }
    }
    
    func makeAttributed(stringValue: String) -> NSMutableAttributedString {
        let attrString = NSMutableAttributedString(string: stringValue)
        let style = NSMutableParagraphStyle()
        style.lineSpacing = 0 // change line spacing between paragraph like 36 or 48
        style.minimumLineHeight = 8 // change line spacing between each line like 30 or 40
        attrString.addAttribute(NSParagraphStyleAttributeName, value: style, range: NSRange(location: 0, length: stringValue.characters.count))
        return attrString
    }

}



