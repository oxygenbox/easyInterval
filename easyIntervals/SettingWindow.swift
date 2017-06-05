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
    @IBOutlet weak var controlLabel: UILabel!
    @IBOutlet weak var cadenceControl: UISegmentedControl!
    @IBOutlet weak var sessionControl: UISegmentedControl!

    
    var preference: Preference = .info {
        didSet {
            setUp()
        }
    }
    
    var cadenceMessage: String {
        switch data.cadenceFrequency {
        case 0:
            return "Every Run Interval"
        case 1:
            return "Every Other Run Interval"
        case 2:
            return "Every Third Run Interval"
        default:
            return "Every Fourth Run Interval"
        }
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
        controlLabel.font = UIFont.cadence
        controlLabel.textColor = UIColor.Theme.base
        
        //init segmentedControls
        sessionControl.tintColor = UIColor.Theme.base
        cadenceControl.tintColor = UIColor.Theme.base
        cadenceControl.setTitleTextAttributes([NSFontAttributeName: UIFont.cadence],
                                              for: .normal)
        sessionControl.setTitleTextAttributes([NSFontAttributeName: UIFont.session],
                                              for: .normal)

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
        case .vibrate:
            prefSwitch.isOn = data.vibrateOn
            iconImage.image = UIImage(named: "vibrate_panel")
        case .cadence:
            prefSwitch.isOn = data.cadenceOn
            iconImage.image = UIImage(named: "cadence_panel")
        case .music:
            prefSwitch.isOn = data.musicOn
            iconImage.image = UIImage(named: "music_panel")
        case .workout:
            prefSwitch.isOn = data.workoutOn
            iconImage.image = UIImage(named: "session_panel")
        default:
            iconImage.image = nil
            break
        }
        
        descLabel.text = preference.desc
        
        prefSwitch.isHidden = preference == .info
        sessionControl.isHidden = preference != .workout
        cadenceControl.isHidden = preference != .cadence
        
        if !sessionControl.isHidden || !cadenceControl.isHidden {
            controlLabel.isHidden = false
        } else {
            controlLabel.isHidden = true
        }
        
        

    }
    
    func initSegmentedControl() {
        if preference == .workout {
            sessionControl.isHidden = false
            cadenceControl.isHidden = true
            sessionControl.isEnabled = data.workoutOn
            sessionControl.selectedSegmentIndex = data.sequenceRepeats
            
            for (index, minutes) in data.sessionArray.enumerated() {
                sessionControl.setTitle("\(minutes)m", forSegmentAt: index)
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
            controlLabel.text = sessionMessage
        } else if preference == .cadence {
            controlLabel.text = "Play cadence check \(cadenceMessage)"
        } else {
          //  controlLabel.text = ""
        }
    }

    
    
    

}



