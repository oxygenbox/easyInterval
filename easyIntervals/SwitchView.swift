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
    func incrementUpdate()
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
        layer.borderColor = UIColor.white.cgColor
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
                data.isSixtySeconds = sender.isOn
        }
        data.save()
        
        guard let del = delegate else {
            return
        }
        
        del.changePreferenceState()
        
        if preference == .music {
            del.checkPermissions()
        }
        
        if preference == .info {
            del.incrementUpdate()
        }
    }
    
    //MARK:- METHODS
    func initSwitch() {
       

        backgroundColor = UIColor.packDark
        prefSwitch.onTintColor = UIColor.white.withAlphaComponent(0.7)
        prefSwitch.tintColor = UIColor.packLight
//        prefSwitch.thumbTintColor = UIColor.packDark
       
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
            prefSwitch.isOn = data.isSixtySeconds
        }
    }
}



