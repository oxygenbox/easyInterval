//
//  SwitchView.swift
//  easyIntervals
//
//  Created by Michael Schaffner on 6/15/17.
//  Copyright © 2017 Michael Schaffner. All rights reserved.
//

protocol SwitchViewDelegate {
    func changePreferenceState()
    func checkPermissions()
}


import UIKit

class SwitchView: UIView {
    var delegate: SwitchViewDelegate?
    var preference: Preference = .info {
        didSet {
            initSwitch()
        }
    }
    
    @IBOutlet weak var prefSwitch: UISwitch!
    
    
    override func draw(_ rect: CGRect) {
        layer.cornerRadius = frame.size.height/2
        layer.borderWidth = 1
        layer.borderColor = UIColor.activeButton.cgColor
        clipsToBounds = true
        
    }
    
    @IBAction func switchChanged(_ sender: UISwitch) {
        
        switch preference {
            case .audio:
                data.audioOn = sender.isOn
            case .vibrate:
                data.vibrateOn = sender.isOn
            case .cadence:
                data.cadenceOn = sender.isOn
            case .music:
                data.musicOn = sender.isOn
            case .workout:
                data.workoutOn = sender.isOn
            default:
                break
        }
        data.save()
        
        guard let del = delegate else {
            return
        }
        
        del.changePreferenceState()
        
        if preference == .audio {
            del.checkPermissions()
        }
        
    }
    
    //MARK:- METHODS
    func initSwitch() {
       
        backgroundColor = UIColor.white//.withAlphaComponent(0.5)
        backgroundColor = UIColor.packLight
        prefSwitch.onTintColor = UIColor.packDark
        prefSwitch.tintColor = UIColor.packDark
        prefSwitch.thumbTintColor = UIColor.activeButton
       
        
        
        
        switch preference {
        case .audio:
            prefSwitch.isOn = data.audioOn
        case .vibrate:
            prefSwitch.isOn = data.vibrateOn
        case .cadence:
            prefSwitch.isOn = data.cadenceOn
        case .music:
            prefSwitch.isOn = data.musicOn
        case .workout:
            prefSwitch.isOn = data.workoutOn 
        default:
            break
        }
    }
}



/*
 // Set the tint color for the On state. Here we set green colour tint for On state
 [customizedSwitch setOnTintColor:[UIColor colorWithRed:64.0/255 green:128.0/255.0 blue:64.0/255.0 alpha:1.0]];
 
 // Set the tint color for the Off state. Here we set green red tint for Off state
 [customizedSwitch setTintColor:[UIColor colorWithRed:255.0/255 green:128.0/255.0 blue:128.0/255.0 alpha:1.0]];
 
 // Set the tint color for the round shaped Thumb. Here we set blue tint for the Thumb
 [customizedSwitch setThumbTintColor:[UIColor colorWithRed:64.0/255 green:64.0/255.0 blue:255.0/255.0 alpha:1.0]];
 */

