//
//  PreferenceViewController.swift
//  easyIntervals
//
//  Created by Michael Schaffner on 6/15/17.
//  Copyright © 2017 Michael Schaffner. All rights reserved.
//

import UIKit

class PreferenceViewController: UIViewController {

    
    //MARK- OUTLETS
    @IBOutlet weak var picker: UIPickerView!
    @IBOutlet weak var intervalOrderControl: UISegmentedControl!
    @IBOutlet weak var switchView: SwitchView!
    @IBOutlet weak var infoButton: PreferenceButton!
    @IBOutlet weak var audioButton: PreferenceButton!
    @IBOutlet weak var vibrateButton: PreferenceButton!
    @IBOutlet weak var cadenceButton: PreferenceButton!
    @IBOutlet weak var musicButton: PreferenceButton!
    @IBOutlet weak var sessionButton: PreferenceButton!
    
    @IBOutlet var buttonCollection: [PreferenceButton]!
    
    //MARK- VARIABLES
    var isRunWalk = true
    var runSetting = 0
    var walkSetting = 0
    var preferences: [Preference] =  [.info, .audio, .vibrate, .cadence, .music, .workout]
    
    var runComponent: Int {
        if isRunWalk {
            return 0
        } else {
            return 1
        }
    }
    
    var walkComponent: Int {
        if isRunWalk {
            return 1
        } else {
            return 0
        }
    }
    
    var activePreference : Preference {
        return preferences[data.settingsTab]
    }
    
    //MARK:- LIFECYCLE
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        configure()
    }
    
    
    //MARK:- ACTIONS
    @IBAction func preferenceButtonTapped(_ sender: PreferenceButton) {
        data.settingsTab  = sender.tag
        data.save()
        self.positionSwitchView(destination: sender.center.x)
        self.selectButton(button: sender)
    }
    
    @IBAction func intervalOrderChanged(_ sender: UISegmentedControl) {
        isRunWalk = sender.selectedSegmentIndex == 0
        data.isRunWalk = sender.selectedSegmentIndex == 0
        data.save()
        picker.reloadAllComponents()
        picker.selectRow(data.runValue, inComponent: runComponent, animated: false)
        picker.selectRow(data.walkValue, inComponent: walkComponent, animated: false)
    }
    
    //MARK:- METHODS
    
    func configure() {
        
        picker.selectRow(data.runValue, inComponent: runComponent, animated: false)
        picker.selectRow(data.walkValue, inComponent: walkComponent, animated: false)
        
        if !data.isRunWalk {
            intervalOrderControl.selectedSegmentIndex = 1
        }
        
        configureButtons()
        postTitle()
    }
    
    func configureButtons() {
        for (index, button) in buttonCollection.enumerated() {
            button.tag = index
            
            if index == data.settingsTab {
                button.select()
            } else {
                button.deselect()
            }
            
            setButtonState()
            infoButton.makeInfo()
           // doneButton.tintColor = UIColor.Theme.base
        }
    }
    
    func postTitle() {
        /*
         titleLabel.font = UIFont.title
         titleLabel.textColor = UIColor.Theme.base
         titleLabel.text = data.settingTitle
         */
    }
    
    func setButtonState() {
        audioButton.isOn = data.audioOn
        vibrateButton.isOn = data.vibrateOn
        cadenceButton.isOn = data.cadenceOn
        musicButton.isOn = data.musicOn
        sessionButton.isOn = data.workoutOn
    }
    
    func selectButton(button: PreferenceButton) {
        button.select()
        
        for but in buttonCollection {
            if but == button {
                but.select()
            } else {
                but.deselect()
            }
            
            switch but {
                case audioButton:
                    but.isOn = data.audioOn
                case vibrateButton:
                    but.isOn = data.vibrateOn
                case cadenceButton:
                    but.isOn = data.cadenceOn
                case musicButton:
                    but.isOn = data.musicOn
                case sessionButton:
                    but.isOn = data.workoutOn
                default:
                    break
            }
            print(but)
        }
        
    }
    /*
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
     
     flip()
 */
    
    
    
    
    /*
    func config() {
     loadSettingWindow()
    }
     
     */
    
    
    func initSegmentedControls() {
        
    }
    
    
    func positionSwitchView(destination: CGFloat) {
        let pa = UIViewPropertyAnimator(duration: 0.25, curve: .easeOut) {
            self.switchView.center.x = destination
        }
        
        pa.startAnimation()
    }


}

//MARK:- EXTENSIONS
extension PreferenceViewController: UIPickerViewDelegate {
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        data.runValue = picker.selectedRow(inComponent: runComponent)
        data.walkValue = picker.selectedRow(inComponent: walkComponent)
        data.save()
        data.calcSessionIncrement()
        
        postTitle()
        initSegmentedControls()
        //runSetting = picker.selectedRow(inComponent: runComponent)
        // walkSetting = picker.selectedRow(inComponent: walkComponent)
        //settingWindow.initSegmentedControl()
        //if component == 0 {
         //   updateModeWindows()
       // }
        
    }
}

extension PreferenceViewController: UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 2
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return 10
    }
    
    func pickerView(_ pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
        return pickerView.bounds.width / 2
    }
    
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        
        
        let dim = pickerView.bounds.width/2 - 10
        let pView = UIView(frame: CGRect(x: 0, y: 0, width: dim, height: dim))
        pView.layer.cornerRadius = dim/2
        pView.backgroundColor = UIColor.blue
        let label = UILabel(frame: pView.frame)
        label.textColor = UIColor.white
        label.font = UIFont(name: "Helvetica", size: 40)!
        label.text = "\(row):00"
        label.textAlignment = .center
        pView.addSubview(label)

        
        if component == runComponent {
            pView.backgroundColor = UIColor.green
        } else {
             pView.backgroundColor = UIColor.red
        }
        
        return pView
    }
}


/*
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
 class SettingsViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate {
 
 //MARK: - IBOutlets

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
 var settingHome = CGRect.zero
 var settingWindow = SettingWindow()
 
 var settingFrame: UIView {
 return UIView(frame: settingHome)
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
 settingWindow.cadenceControl.isEnabled = sender.isOn
 case .music:
 data.musicOn = sender.isOn
 print("MUSIC \(data.musicOn)")
 case .workout:
 data.workoutOn = sender.isOn
 settingWindow.sessionControl.isEnabled = sender.isOn
 default:
 break
 }
 setButtonState()
 settingWindow.setAppearance()
 data.save()
 }
 
 @IBAction func controlChanged(_ sender: UISegmentedControl) {
 let value = sender.selectedSegmentIndex
 if activePreference == .workout {
 data.sequenceRepeats = value
 } else {
 data.cadenceFrequency = value
 }
 data.save()
 settingWindow.updateControlDescription()
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
 
 flip()
 }
 
 
 @IBAction func doneTapped(_ sender: UIButton) {
 dismiss(animated: true, completion: nil)
 }
 
 //MARK: - Methods
 
 
 
 
 
 
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
 label.layer.borderColor = UIColor.primary.cgColor
 
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
 settingWindow.initSegmentedControl()
 
 if component == 0 {
 updateModeWindows()
 }
 }
 
 func loadSettingWindow() {
 
 if let settingWindow = Bundle.main.loadNibNamed("SettingWindow", owner: self, options: nil)?.first as? SettingWindow {
 self.settingWindow = settingWindow
 settingWindow.frame = settingHome
 settingFrame.layer.cornerRadius = settingFrame.frame.width/2
 settingFrame.clipsToBounds = true
 
 settingWindow.prefSwitch.addTarget(self, action: #selector(switchChanged), for: .valueChanged)
 settingWindow.cadenceControl.addTarget(self, action: #selector(controlChanged(_:)), for: .valueChanged)
 settingWindow.sessionControl.addTarget(self, action: #selector(controlChanged(_:)), for: .valueChanged)
 settingWindow.preference = activePreference
 settingWindow.setAppearance()
 view.addSubview(settingWindow)
 }
 }
 
 func flip() {
 let transitionOptions: UIViewAnimationOptions = [.transitionFlipFromRight, .showHideTransitionViews]
 self.settingWindow.preference = self.activePreference
 UIView.transition(with: settingWindow, duration: 0.5, options: transitionOptions, animations: {
 
 })
 }
 }
 
 
 
 
 
 
 
 
 

 

 */
