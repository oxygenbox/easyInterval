//
//  SettingsViewController.swift
//  easyIntervals
//
//  Created by Michael Schaffner on 1/9/17.
//  Copyright © 2017 Michael Schaffner. All rights reserved.
//


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
    
    var desc: String {
        switch self {
        case .info:
            return "Info mention need to be written"
        case .audio:
            return "Play audio cues including counting down the last five seconds of each interval"
        case .vibrate:
            return "Vibrate for the last five seconds of each interval"
        case .cadence:
            return "Play audio cadence check at the beginning of every other run interval"
        case .music:
            return "Play music from your iTunes while timer is running"
        case .workout:
            return "Run a session for the length of:"
        }
    }
}

import UIKit
class SettingsViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate {

    //MARK: - IBOutlets
    @IBOutlet weak var picker: UIPickerView!
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    @IBOutlet weak var preferenceSwitch: UISwitch!
    
    @IBOutlet weak var prefSlider: UISlider!
    @IBOutlet weak var prefMessage: UILabel!
    @IBOutlet weak var message1: UILabel!
    @IBOutlet weak var message2: UILabel!
    
    @IBOutlet weak var iconView: UIView!
    @IBOutlet weak var switchView: UIView!
    
    
    @IBOutlet weak var modeDivider: UIView!
    
    @IBOutlet weak var leftModeIcon: SettingModeView!
    @IBOutlet weak var rightModeIcon: SettingModeView!
    
    @IBOutlet var prefViews: [UIView]!
    
    let baseColor = UIColor.white
    let higlightColor = UIColor.myBlue
    
    //variables
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
    
    //MARK: - Lifecycle
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setUp()
        initSlider()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
         setModeImages()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    //MARK: - PickerViewMethods
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
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if component == 0 {
            return Data.modeNameArray[row]
        } else {
            return Data.timeArray[row]
        }
    }
        
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        let label = UILabel(frame: CGRect(x: 0, y: 0, width: Picker.time.width, height: 50))
        label.textAlignment = .center
        label.textColor = higlightColor
        label.font = UIFont(name: "Avenir Next", size: 24.0)!
        label.backgroundColor = UIColor.clear
        label.isOpaque = false
        
        if component == Picker.mode.rawValue {
            
            label.frame.size.height = Picker.mode.height
            label.frame.size.width = Picker.mode.width
            label.attributedText = Tool.formatPickerMode(mode: Data.modeNameArray[row])
            label.layer.cornerRadius = label.frame.size.height / 2
            label.clipsToBounds = true
            label.layer.borderWidth = 2
            label.layer.borderColor = higlightColor.cgColor
            
        } else {
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
        initSlider()
        
        if component == 0 {
            setModeImages()
        }
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
        prefSlider.setValue(Float(value), animated: false)
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
        segmentedControl.tintColor = UIColor.accent
        
        title = data.settingTitle
        //init interface
        segmentedControl.selectedSegmentIndex = data.settingsTab
        picker.selectRow(data.runValue, inComponent: runComponent, animated: false)
        picker.selectRow(data.walkValue, inComponent: walkComponent, animated: false)
        if !data.isRunWalk {
            picker.selectRow(1, inComponent: 0, animated: false)
        }
        
        setUpViews()
        changePreference()
    }
    
    func setUpViews() {
        view.backgroundColor = baseColor
        /*
        
        for pref in prefViews {
            pref.backgroundColor = baseColor
            pref.layer.borderColor = UIColor.black.cgColor
            pref.layer.borderWidth = 0.5
            pref.layer.shadowColor = UIColor.white.cgColor
            pref.layer.shadowRadius = 1
            pref.layer.shadowOpacity = 1
            pref.layer.shadowOffset = CGSize(width: 1, height: -1)
        }*/
    }
   
    func changePreference() {
        if activePreference == .cadence || activePreference == .workout {
            prefSlider.isHidden = false
            initSlider()
            revealSlider(show: false)
        } else {
            revealSlider(show: true)
          
        }
        
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
        revealMessage()
      //  prefMessage.text = activePreference.desc
    }
    
    func initSlider() {
        if activePreference == .workout {
            prefSlider.minimumValue = 1
            prefSlider.maximumValue  = 6
            let value = Float(data.sequenceRepeats)
            prefSlider.setValue(value, animated: false)
            postSliderMessage()
        } else if activePreference == .cadence {
            prefSlider.minimumValue = 1
            prefSlider.maximumValue = 4
            let value = Float(data.cadenceFrequency)
            prefSlider.setValue(value, animated: false)
            //postSliderMessage()
        }
    }
    
    func postSliderMessage() {
        if activePreference == .workout {
           // let minutes = data.sessionIncrement * data.sequenceRepeats
           // let h = minutes / 60
           // let m = minutes - h * 60
           // let time = "\(h):\(Tool.numberToString(value: m))"
           // sliderMessage.text = "\(minutes) MINUTE (\(time)) WORKOUT"
        } else if activePreference == .cadence {
            //sliderMessage.text = cadenceMessage()
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
    
    
    func revealSlider(show: Bool) {
        if prefSlider.isHidden != show {
            UIView.transition(with: prefSlider, duration: 1.0, options: [.transitionFlipFromLeft], animations: {
                self.prefSlider.isHidden = show
            }, completion: { (success: Bool) in
                
            })
        }
    }
    
    func revealMessage() {
        UIView.transition(with: prefMessage, duration: 1.0, options: [.transitionFlipFromLeft], animations: {
            self.prefMessage.text = self.activePreference.desc
        }, completion: { (success: Bool) in
            
        })
    }
    
    func setModeImages() {
        rightModeIcon.delay = 0.2
        
        if data.isRunWalk {
            leftModeIcon.mode = .run
            rightModeIcon.mode = .walk
        } else {
            leftModeIcon.mode = .walk
            rightModeIcon.mode = .run
        }
    }
    
    
}












