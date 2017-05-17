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
   
    @IBOutlet weak var sessionControl: UISegmentedControl!
    @IBOutlet weak var cadenceControl: UISegmentedControl!
    @IBOutlet weak var preferenceSwitch: UISwitch!
    @IBOutlet weak var descriptionView: UIView!
    @IBOutlet weak var prefMessage: UILabel!
    @IBOutlet weak var modeImageView: UIImageView!
    @IBOutlet weak var segmentedControlView: UIView!
    @IBOutlet weak var descStack: UIStackView!
    @IBOutlet weak var switchView: UIView!
    @IBOutlet weak var leftModeIcon: SettingModeView!
    @IBOutlet weak var rightModeIcon: SettingModeView!
    @IBOutlet weak var infoButton: RoundButton!
    @IBOutlet weak var audioButton: RoundButton!
    @IBOutlet weak var vibrateButton: RoundButton!
    @IBOutlet weak var cadenceButton: RoundButton!
    @IBOutlet weak var musicButton: RoundButton!
    @IBOutlet weak var sessionButton: RoundButton!
    @IBOutlet var buttonCollection: [RoundButton]!
    
    //MARK: - Variables
    let baseColor = UIColor.white
    let higlightColor = UIColor.myBlue
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
    
    //MARK: - IBACTIONS
    
    @IBAction func switchChanged(sender: UISwitch) {
        switch activePreference {
            case .audio:
                data.audioOn = sender.isOn
            case .vibrate:
                data.vibrateOn = sender.isOn
            case .cadence:
                data.cadenceOn = sender.isOn
                cadenceControl.isEnabled = sender.isOn
            case .music:
                data.musicOn = sender.isOn
            case .workout:
                data.workoutOn = sender.isOn
                sessionControl.isEnabled = sender.isOn
            default:
                break
        }
        
    }
    
    @IBAction func controlChanged(_ sender: UISegmentedControl) {
        let value = sender.selectedSegmentIndex
        postSliderMessage()
        
        if activePreference == .workout {
            data.sequenceRepeats = value
        } else {
            data.cadenceFrequency = value
        }
        data.save()
    }
    
    func buttonPressed(_ sender: RoundButton) {
        sender.alpha = 1
        
        for button in buttonCollection {
            if sender == button {
               button.alpha = 1
            } else{
                button.alpha = 0.5
            }
        }
        data.settingsTab = sender.tag
        data.save()
        changePreference()
    }
    
    //MARK: - Methods
    func setUp() {
        //NAVBAR
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "Main", style: .plain, target: nil, action: nil)
        title = data.settingTitle
        
        //init interface
        view.backgroundColor = baseColor
        sessionControl.tintColor = UIColor.accent
        cadenceControl.tintColor = UIColor.accent
        let sessionFont = UIFont(name: "AvenirNextCondensed-Medium", size: 16.0)!
        let cadenceFont = UIFont(name: "AvenirNextCondensed-Medium", size: 12.0)!
        cadenceControl.setTitleTextAttributes([NSFontAttributeName: cadenceFont],
                                              for: .normal)
        sessionControl.setTitleTextAttributes([NSFontAttributeName: sessionFont],
                                              for: .normal)
        
        picker.selectRow(data.runValue, inComponent: runComponent, animated: false)
        picker.selectRow(data.walkValue, inComponent: walkComponent, animated: false)
        if !data.isRunWalk {
            picker.selectRow(1, inComponent: 0, animated: false)
        }
        
        //buttons
        for (index, button) in buttonCollection.enumerated() {
            button.addTarget(self, action: #selector(buttonPressed(_:)), for: .touchUpInside)
            button.tag = index
            
            if index == data.settingsTab {
                button.alpha = 1.0
            } else {
                button.alpha = 0.5
            }
        }
        changePreference()
    }
    
    
     func changePreference() {
        switch activePreference {
            case .audio:
                preferenceSwitch.isOn = data.audioOn
                modeImageView.image = UIImage(named: "audio_panel")
            
            
            case .vibrate:
                preferenceSwitch.isOn = data.vibrateOn
                modeImageView.image = UIImage(named: "vibrate_panel")
            case .cadence:
                preferenceSwitch.isOn = data.cadenceOn
                modeImageView.image = UIImage(named: "cadence_panel")
            case .music:
                preferenceSwitch.isOn = data.musicOn
                modeImageView.image = UIImage(named: "music_panel")
            case .workout:
                preferenceSwitch.isOn = data.workoutOn
                modeImageView.image = UIImage(named: "session_panel")
            default:
                modeImageView.image = nil
                break
        }
        
        UIView.transition(with: switchView, duration: 0.8, options: [.transitionFlipFromLeft], animations: {
           
        }, completion: { (success: Bool) in
            
        })
        
        

        if activePreference == .cadence || activePreference == .workout {
            revealSegmentedControl(show: false)
        } else {
           revealSegmentedControl(show: true)
        }
       
        revealMessage()
        prefMessage.text = activePreference.desc
        preferenceSwitch.isHidden = activePreference == .info
    }
    
    
    func initSegmentedControl() {
        if activePreference == .workout {
            sessionControl.isHidden = false
            cadenceControl.isHidden = true
            sessionControl.isEnabled = data.workoutOn
            sessionControl.selectedSegmentIndex = data.sequenceRepeats
        } else if activePreference == .cadence {
            sessionControl.isHidden = true
            cadenceControl.isHidden = false
            cadenceControl.isEnabled = data.cadenceOn
            cadenceControl.selectedSegmentIndex = data.cadenceFrequency
        } else {
            sessionControl.isHidden = true
            cadenceControl.isHidden = true
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
            print(cadenceMessage())
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
    
    //
    func revealSegmentedControl(show: Bool) {
        UIView.transition(with: segmentedControlView, duration: 0.8, options: [.transitionFlipFromBottom], animations: {
            self.initSegmentedControl()
        }, completion: { (success: Bool) in
            
        })
        
        
        
        
        
     //   if segmentedControlView.isHidden != show {
//            UIView.transition(with: segmentedControl, duration: 1.0, options: [.transitionFlipFromBottom], animations: {
//                self.segmentedControl.isHidden = show
//           }, completion: { (success: Bool) in
//                
//            })
//        }
    }
    
    func revealMessage() {
        
        
    UIView.transition(with: descriptionView, duration: 0.8, options: [.transitionFlipFromBottom], animations: {
        //                self.segmentedControl.isHidden = show
                   }, completion: { (success: Bool) in
        
                   })
               // }
        
        
        
       
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
        initSegmentedControl()
        
        if component == 0 {
            setModeImages()
        }
    }
}












