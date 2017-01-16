//
//  SettingViewController.swift
//  easyIntervals
//
//  Created by Michael Schaffner on 1/16/17.
//  Copyright © 2017 Michael Schaffner. All rights reserved.
//
enum Picker: Int {
    case mode
    case time
    
    var width: CGFloat {
        switch self {
        case .mode:
            return 145.0
        default:
            return 75.0
        }
    }
    
    var height: CGFloat {
        switch self {
        case .mode:
            return 60.0
        default:
            return 50.0
        }
    }
}

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
}


import UIKit

class SettingViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource, UITableViewDelegate, UITableViewDataSource {
    
   var pickerData = [1, 2, 3, 4, 5]
    
    //MARK: - IBOutlets
    @IBOutlet weak var picker:UIPickerView!
    @IBOutlet weak var tableView: UITableView!
    
    //MARK: - Variables
    var preferences: [Preference] =  [.info, .audio, .vibrate, .cadence, .music, .workout]
    
    var runComponent: Int {
        if data.isRunWalk {
            return 1
        } else {
            return 2
        }
    }
    
    var walkComponent: Int {
        if data.isRunWalk {
            return 2
        } else {
            return 1
        }
    }
    
    var activePreference : Preference {
        return preferences[data.settingsTab]
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    //MARK: - PickerView
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 3
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if component == 0 {
            return Data.modeNameArray.count
        } else {
            return Data.timeArray.count
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, widthForComponent component: Int) -> CGFloat {
        if component == 0 {
            return Picker.mode.width
        } else {
            return Picker.time.width
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
        if component == 0 {
            return Picker.mode.height
        } else {
            return Picker.time.height
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        
        let label = UILabel(frame: CGRect(x: 0, y: 0, width: 145, height: 60))
        
        label.textAlignment = .center
        label.textColor = UIColor.myBlue
        label.font = UIFont.boldSystemFont(ofSize: 24)
        label.backgroundColor = UIColor.clear
        label.isOpaque = false
        
        
        if component == Picker.mode.rawValue {
            label.text = Data.modeNameArray[row]
            label.attributedText = Tool.formatPickerMode(mode: Data.modeNameArray[row])
            label.backgroundColor = UIColor.myBlue
            label.textColor = UIColor.white
            label.layer.cornerRadius = 4.0
            label.clipsToBounds = true
            
        } else {
            label.text = Data.timeArray[row]
            label.attributedText = Tool.formatPickerTime(time: Data.timeArray[row])
        }
        return label
    }
    
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        data.isRunWalk = picker.selectedRow(inComponent: 0) == 0
        data.runValue = picker.selectedRow(inComponent: runComponent)
        data.walkValue = picker.selectedRow(inComponent: walkComponent)
        data.save()
        data.calcSessionIncrement()
        title = data.settingTitle
       // initSlider()
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return pickerData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as UITableViewCell
        
        cell.textLabel?.text = String(pickerData[indexPath.row])
        
        return cell
    }
    
    
    
    
    
    /*
     
     import UIKit
     
     class SettingsViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate {
     
     //MARK: - IBOutlets
     @IBOutlet weak var picker: UIPickerView!
     @IBOutlet weak var segmentedControl: UISegmentedControl!
     @IBOutlet weak var preferenceSwitch: UISwitch!
     
     @IBOutlet weak var sessionSlider: UISlider!
     @IBOutlet weak var sliderMessage: UILabel!
     @IBOutlet weak var message1: UILabel!
     @IBOutlet weak var message2: UILabel!
     
     //variables
     
     
     //MARK: - Lifecycle
     override func viewWillAppear(_ animated: Bool) {
     super.viewWillAppear(animated)
     setUp()
     initSlider()
     }
     
     override func viewDidLoad() {
     super.viewDidLoad()
     }
     
     
     
     
    
     
     
     
    
     
   
     
     //MARK: - IBAction
     @IBAction func segmentChanged(sender: UISegmentedControl) {
     data.settingsTab = sender.selectedSegmentIndex
     data.save()
     changePreference()
     }
     
     @IBAction func switchChanged(sender: UISwitch) {
     switch activePreference {
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
     }
     
     @IBAction func sliderChanged(sender: UISlider) {
     let value  = Int(sender.value)
     sessionSlider.setValue(Float(value), animated: false)
     postSliderMessage()
     if activePreference == .workout {
     data.sequenceRepeats = value
     
     } else {
     data.cadenceFrequency = value
     }
     data.save()
     }
     
     //MARK: - Methods
     func setUp() {
     navigationItem.backBarButtonItem = UIBarButtonItem(title: "Main", style: .plain, target: nil, action: nil)
     title = data.settingTitle
     //init interface
     segmentedControl.selectedSegmentIndex = data.settingsTab
     picker.selectRow(data.runValue, inComponent: runComponent, animated: false)
     picker.selectRow(data.walkValue, inComponent: walkComponent, animated: false)
     if !data.isRunWalk {
     picker.selectRow(1, inComponent: 0, animated: false)
     }
     changePreference()
     }
     
     func changePreference() {
     
     if activePreference == .cadence || activePreference == .workout {
     sessionSlider.isHidden = false
     initSlider()
     } else {
     sessionSlider.isHidden = true
     }
     sliderMessage.isHidden = sessionSlider.isHidden
     
     preferenceSwitch.isHidden = activePreference == .info
     
     switch activePreference {
     case .audio:
     preferenceSwitch.isOn = data.audioOn
     case .vibrate:
     preferenceSwitch.isOn = data.vibrateOn
     case .cadence:
     preferenceSwitch.isOn = data.cadenceOn
     case .music:
     preferenceSwitch.isOn = data.musicOn
     case .workout:
     preferenceSwitch.isOn = data.workoutOn
     default:
     break
     }
     }
     
     func initSlider() {
     if activePreference == .workout {
     sessionSlider.minimumValue = 1
     sessionSlider.maximumValue  = 6
     let value = Float(data.sequenceRepeats)
     sessionSlider.setValue(value, animated: false)
     postSliderMessage()
     } else if activePreference == .cadence {
     sessionSlider.minimumValue = 1
     sessionSlider.maximumValue = 4
     let value = Float(data.cadenceFrequency)
     sessionSlider.setValue(value, animated: false)
     postSliderMessage()
     }
     }
     
     func postSliderMessage() {
     if activePreference == .workout {
     let minutes = data.sessionIncrement * data.sequenceRepeats
     let h = minutes / 60
     let m = minutes - h * 60
     let time = "\(h):\(Tool.numberToString(value: m))"
     sliderMessage.text = "\(minutes) MINUTE (\(time)) WORKOUT"
     } else if activePreference == .cadence {
     sliderMessage.text = cadenceMessage()
     }
     }
     
     func cadenceMessage() -> String {
     switch data.cadenceFrequency {
     case 1:
     return "Every Run Interval"
     case 2:
     return "Every Other Run Interval"
     case 3:
     return "Every Third Run Interval"
     default:
     return "Every Fourth Run Interval"
     }
     }
     }
     
     
    */

}
