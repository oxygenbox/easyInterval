//
//  SettingsViewController.swift
//  easyIntervals
//
//  Created by Michael Schaffner on 1/9/17.
//  Copyright © 2017 Michael Schaffner. All rights reserved.
//

/*
enum Picker: Int {
    case mode
    case time
    var width: CGFloat {
        switch self {
        case .mode:
            return 130.0
        default:
            return 66.0
        }
    }
    
    var height: CGFloat {
        switch self {
        case .mode:
            return 50.0
        default:
            return 30.0
        }
    }
}*/

enum Preference: Int {
    case info, audio, vibrate, cadence, music, workout
    var name: String {
        switch self {
            case .info:
                return "Info"
            case .audio:
                return "Audio"
            case .vibrate:
                return "Vibrate"
            case .cadence:
                return "Cadence"
            case .music:
                return "Music"
            case .workout:
                return "Workout"
        }
    }
    
    var desc: String {
        switch self {
        case .info:
            return "Info mention need to be written"
        case .audio:
            return "Play audio cues"
        case .vibrate:
            return "Vibrate for the last five seconds \nof each interval"
        case .cadence:
            return "Play audio cadence check at the beginning of every other run interval"
        case .music:
            return "Play music from your iTunes \nwhile timer is running"
        case .workout:
            return "Run a session for the length of:"
        }
    }
}


import UIKit
class SettingsViewController: UIViewController {
/*
     
*/
}









