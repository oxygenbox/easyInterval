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
    @IBOutlet weak var leftModeIcon: SettingModeView!
    @IBOutlet weak var rightModeIcon: SettingModeView!
    @IBOutlet weak var infoButton: RoundButton!
    @IBOutlet weak var audioButton: RoundButton!
    @IBOutlet weak var vibrateButton: RoundButton!
    @IBOutlet weak var cadenceButton: RoundButton!
    @IBOutlet weak var musicButton: RoundButton!
    @IBOutlet weak var sessionButton: RoundButton!
    @IBOutlet weak var doneButton: UIButton!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet var buttonCollection: [RoundButton]!
  
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
        
    var settingHome = CGRect.zero
    var settingOn = SettingWindow()
    var settingOff = SettingWindow()
    var currentWindow: SettingWindow?
    var previousWindow: SettingWindow?
    
    var settingFrame: UIView {
        return UIView(frame: settingHome)
    }

    //MARK: - Lifecycle
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        config()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        updateModeWindows()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    //MARK: - IBACTIONS
    @IBAction func switchChanged(sender: UISwitch) {
        switch activePreference {
            case .audio:
                data.audioOn = sender.isOn
            case .vibrate:
                data.vibrateOn = sender.isOn
            case .cadence:
                data.cadenceOn = sender.isOn
                settingOn.cadenceControl.isEnabled = sender.isOn
            case .music:
                data.musicOn = sender.isOn
            case .workout:
                data.workoutOn = sender.isOn
                settingOn.sessionControl.isEnabled = sender.isOn
            default:
                break
        }
        setButtonState()
        settingOn.setAppearance()
    }
    
    @IBAction func controlChanged(_ sender: UISegmentedControl) {
        let value = sender.selectedSegmentIndex
        if activePreference == .workout {
            data.sequenceRepeats = value
        } else {
            data.cadenceFrequency = value
        }
        data.save()
        settingOn.postControlMessage()
    }
    
    func buttonPressed(_ sender: RoundButton) {
        sender.select()
        
        for button in buttonCollection {
            if sender == button {
               button.select()
            } else{
                button.deselect()
                
                switch button {
                case audioButton:
                    button.isOn = data.audioOn
                case vibrateButton:
                    button.isOn = data.vibrateOn
                case cadenceButton:
                    button.isOn = data.cadenceOn
                case musicButton:
                    button.isOn = data.musicOn
                case sessionButton:
                    button.isOn = data.workoutOn
                default:
                    break
                }
            }
        }
        
        data.settingsTab = sender.tag
        data.save()
        changePreference()
        flip()
    }
    
    
    @IBAction func doneTapped(_ sender: UIButton) {
       dismiss(animated: true, completion: nil)
    }
    
    //MARK: - Methods
    func config() {
        //NAVBAR
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "Main", style: .plain, target: nil, action: nil)
        titleLabel.font = UIFont.title
        titleLabel.textColor = UIColor.Theme.base
        titleLabel.text = data.settingTitle
        doneButton.tintColor = UIColor.Theme.base
        
        //initPicker
        picker.selectRow(data.runValue, inComponent: runComponent, animated: false)
        picker.selectRow(data.walkValue, inComponent: walkComponent, animated: false)
        if !data.isRunWalk {
            picker.selectRow(1, inComponent: 0, animated: false)
        }
        
        for (index, button) in buttonCollection.enumerated() {
            button.addTarget(self, action: #selector(buttonPressed(_:)), for: .touchUpInside)
            button.tag = index
            
            if index == data.settingsTab {
                button.select()
            } else {
                button.deselect()
            }
        }
        
        changePreference()
        setButtonState()
        infoButton.makeInfo()
        loadPreference()
    }
    
    func setButtonState() {
        audioButton.isOn = data.audioOn
        vibrateButton.isOn = data.vibrateOn
        cadenceButton.isOn = data.cadenceOn
        musicButton.isOn = data.musicOn
        sessionButton.isOn = data.workoutOn
    }
    
    func changePreference() {

    }

    func updateModeWindows() {
        rightModeIcon.delay = 0.2
        if data.isRunWalk {
            leftModeIcon.mode = .run
            rightModeIcon.mode = .walk
        } else {
            leftModeIcon.mode = .walk
            rightModeIcon.mode = .run
        }
    }
        
    //MARK: - PickerView Methods
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
        label.textColor = UIColor.Theme.base
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
            label.layer.borderColor = UIColor.Theme.base.cgColor
            
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
        settingOn.initSegmentedControl()
        
        if component == 0 {
            updateModeWindows()
        }
    }
    
    func loadPreference() {
        
        if let settingWindow = Bundle.main.loadNibNamed("SettingWindow", owner: self, options: nil)?.first as? SettingWindow {
            self.settingOn = settingWindow
            settingOn.frame = settingHome
            settingFrame.layer.cornerRadius = settingFrame.frame.width/2
            settingFrame.clipsToBounds = true
            
            settingOn.prefSwitch.addTarget(self, action: #selector(switchChanged), for: .valueChanged)
            settingOn.cadenceControl.addTarget(self, action: #selector(controlChanged(_:)), for: .valueChanged)
            settingOn.sessionControl.addTarget(self, action: #selector(controlChanged(_:)), for: .valueChanged)
            settingOn.preference = activePreference
            
            view.addSubview(settingOn)
        }
    }
    
    func loadSetting() {
        if let current = currentWindow {
            previousWindow = current
        }
        
        if let nextWindow = Bundle.main.loadNibNamed("SettingWindow", owner: self, options: nil)?.first as? SettingWindow {
            currentWindow = nextWindow
            
            
            nextWindow.frame = settingFrame.frame
           // nextSetting.titleLabel.text = activePreference.rawValue
          //  nextSetting.layer.cornerRadius = nextSetting.frame.size.height/2
            currentWindow!.frame.origin.x = view.frame.width
            currentWindow!.transform = CGAffineTransform(rotationAngle: -0.90)
            currentWindow!.prefSwitch.addTarget(self, action: #selector(switchChanged), for: .valueChanged)
           // nextWindow.layer.cornerRadius = nextWindow.frame.height/2
            currentWindow!.preference = activePreference
            currentWindow!.layer.borderWidth = 1
            currentWindow!.layer.borderColor = UIColor.black.cgColor
            
            self.view.addSubview(nextWindow)
            
            animateOn()
            animateOff()

            
            
            
        }
        
    }
    
    func animateOn() {
        guard let current = currentWindow else {
            return
        }
        
        UIView.animate(withDuration: 2.0, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.2, options: .curveEaseOut, animations: {
            current.center = self.settingFrame.center
            current.transform = CGAffineTransform.identity
        }) { (success) in
            
        }
    }
    
    func animateOff() {
        guard  let previous = previousWindow else {
            return
        }
        
        
        UIView.animate(withDuration: 1.0, animations: {
            previous.frame.origin.x =  -previous.frame.size.width
        }) { (success) in
            previous.removeFromSuperview()
            self.previousWindow = nil
        }
        
    }
    
    func flip() {
        let transitionOptions: UIViewAnimationOptions = [.transitionFlipFromRight, .showHideTransitionViews]
        self.settingOn.preference = self.activePreference
        UIView.transition(with: settingOn, duration: 0.5, options: transitionOptions, animations: {
          
        })
        
    }
    
    
}









