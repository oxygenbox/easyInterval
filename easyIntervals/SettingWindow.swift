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
    @IBOutlet weak var cadenceControl: UISegmentedControl!
    @IBOutlet weak var sessionControl: UISegmentedControl!

    
    var preference: Preference = .info {
        didSet {
            setUp()
        }
    }
    
    override func didMoveToWindow() {
        super.didMoveToWindow()
        layer.cornerRadius = frame.size.width/2
        layer.borderColor = UIColor.Theme.base.cgColor
        layer.borderWidth = 1
        
        backgroundColor = UIColor.Theme.on
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

    }

}



