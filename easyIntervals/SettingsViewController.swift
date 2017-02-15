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
    
    var desc: String {
        switch self {
        case .info:
            return "Info mention need tio be written"
        case .audio:
            return "Play audio cues including counting down the last five seconds of each interval"
        case .vibrate:
            return "Vibrate for the last five seconds of each interval"
        case .cadence:
            return "Play audio cadence check at the beginning of every other run interval"
        case .music:
            return "Play music from your iTunes while timer is running"
        case .workout:
            return "Run  a session for the length of:"
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
    @IBOutlet weak var sliderView: UIView!
    @IBOutlet weak var switchView: UIView!
    @IBOutlet weak var messageview: UIView!
    
    @IBOutlet weak var modeImageA: UIImageView!
    @IBOutlet weak var modeImageB: UIImageView!
    @IBOutlet weak var modeDivider: UIView!
    
    
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
        
        let newView = UIView()
        newView.frame = CGRect(x: 0, y: 0, width: modeImageA.frame.size.width, height: modeImageA.frame.size.height)
        newView.backgroundColor = UIColor.yellow
        
        let sl = CAShapeLayer()
        sl.path = Paths.runningBody.cgPath
        modeImageA.layer.addSublayer(sl)
        
        
        
        modeImageA.addSubview(newView)
        
        
        
        
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
        
        let label = UILabel(frame: CGRect(x: 0, y: 0, width: 145, height: 60))
        label.textAlignment = .center
        label.textColor = higlightColor
        label.font = UIFont.boldSystemFont(ofSize: 24)
        label.font = UIFont(name: "Avenir Next", size: 30.0)!
        label.backgroundColor = UIColor.clear
        label.isOpaque = false
        
        
        if component == Picker.mode.rawValue {
            label.text = Data.modeNameArray[row]
            label.attributedText = Tool.formatPickerMode(mode: Data.modeNameArray[row])
            //label.backgroundColor = UIColor.myBlue
            label.textColor = higlightColor
            label.layer.cornerRadius = label.frame.size.height / 2
            label.clipsToBounds = true
            
            label.layer.borderWidth = 1
            label.layer.borderColor = higlightColor.cgColor

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
        initSlider()
        
        if component == 0 {
            modeChange()
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
        setModeImages()
        
        changePreference()
    }
    
    func setUpViews() {
        
        view.backgroundColor = baseColor
        for pref in prefViews {
            pref.backgroundColor = baseColor
            pref.layer.borderColor = UIColor.black.cgColor
            pref.layer.borderWidth = 0.5
            pref.layer.shadowColor = UIColor.white.cgColor
            pref.layer.shadowRadius = 1
            pref.layer.shadowOpacity = 1
            pref.layer.shadowOffset = CGSize(width: 1, height: -1)
        }
    }
   
    func changePreference() {
        
        if activePreference == .cadence || activePreference == .workout {
            prefSlider.isHidden = false
            initSlider()
            revealSlider(show: true)
        } else {
            revealSlider(show: false)
          //  prefSlider.isHidden = true
        }
       // sliderMessage.isHidden = sessionSlider.isHidden
        
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
            UIView.transition(with: sliderView, duration: 1.0, options: [.transitionFlipFromLeft], animations: {
                self.prefSlider.isHidden = show
            }, completion: { (success: Bool) in
                
            })
        }
    }
    
    func revealMessage() {
        UIView.transition(with: messageview, duration: 1.0, options: [.transitionFlipFromLeft], animations: {
            self.prefMessage.text = self.activePreference.desc
        }, completion: { (success: Bool) in
            
        })
    }
    
    func modeChange(){
        
        UIView.animate(withDuration: 0.60, delay: 0, options: [.curveEaseOut], animations: {
            self.modeImageA.center.x -= 300
            self.modeImageB.center.x += 300
        }) { (success: Bool) in
            self.setModeImages()
            UIView.animate(withDuration: 0.60, delay: 0, options: [.curveEaseInOut], animations: {
                self.modeImageA.center.x += 300
                self.modeImageB.center.x -= 300
            })
        }
        
        /*
        
        UIView.animate(withDuration: 0.25, animations: {
            self.modeImageA.center.x -= 300
            self.modeImageB.center.x += 300
        }) { (success: Bool) in
            self.setModeImages()
            UIView.animate(withDuration: 0.25, animations: {
                self.modeImageA.center.x += 300
                self.modeImageB.center.x -= 300
            })
        }
        */
        
        
        
        
    }
    
    func setModeImages() {
        if data.isRunWalk {
            modeImageA.image = UIImage(named: "run")
            modeImageB.image = UIImage(named: "walk")
        } else {
            modeImageA.image = UIImage(named: "walk")
            modeImageB.image = UIImage(named: "run")
        }
        
        modeImageA.tintImageColor(color: UIColor.accent)
        modeImageB.tintImageColor(color: UIColor.accent)
    }
    
    
}


/*
 

 UIView.transition(with: sliderView, duration: 1.0, options: [.transitionFlipFromRight], animations: {
 self.slider.isHidden = show
 })

 
 
 
 
 func setUp() {
 let tap = UITapGestureRecognizer(target: self, action: #selector(tapped))
 boxA.isUserInteractionEnabled = true
 boxA.addGestureRecognizer(tap)
 }
 
 
 func sliderFlip(show: Bool) {
 if  slider.isHidden != show {
 UIView.transition(with: sliderView, duration: 1.0, options: [.transitionFlipFromRight], animations: {
 self.slider.isHidden = show
 })
 }
 }
 
 func imageFlip(show: Bool) {
 UIView.transition(with: imageView, duration: 1.25, options: [.transitionFlipFromRight], animations: {
 
 })
 }
 
 
 func switchFlip(show: Bool) {
 UIView.transition(with: switchView, duration: 1.25, options: [.transitionFlipFromRight], animations: {
 
 })
 }
 
 
 
 func messageFlip(show: Bool) {
 UIView.transition(with: messageVview, duration: 1.0, options: [.transitionFlipFromRight], animations: {
 
 })
 }

 
 
 */


















/*
 
 
 enum Device {
 case iPad, iPhone
 var year: Int {
 switch self {
	case iPhone: return 2007
	case iPad: return 2010
 }
 }
 }
 
 @objc(pickerView:viewForRow:forComponent:reusingView:) func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
 
 let label = UILabel(frame: CGRect(x: 60, y: 0, width: 145, height: 80))
 label.textAlignment = .center
 label.font = UIFont.boldSystemFont(ofSize: 24)
 label.backgroundColor = UIColor.clear
 label.isOpaque = false
 
 switch component {
 case 0:
 label.text = sharedData.modeArray[row]
 label.attributedText = modeAttributedText(sharedData.modeArray[row])
 
 
 label.backgroundColor = pickerBlue
 label.textColor = UIColor.white
 default:
 label.text = sharedData.timeArray[row]
 label.attributedText = timeLabelAttibutedText(sharedData.timeArray[row])
 label.textColor = pickerBlue
 }
 return label
 }
 
 
 
 
 */
