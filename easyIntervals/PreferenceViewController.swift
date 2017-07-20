//
//  PreferenceViewController.swift
//  easyIntervals
//
//  Created by Michael Schaffner on 6/15/17.
//  Copyright © 2017 Michael Schaffner. All rights reserved.
//

import MediaPlayer

import UIKit

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
    @IBOutlet weak var doneButton: UIButton!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var cadenceControl: UISegmentedControl!
    @IBOutlet weak var sessionControl: UISegmentedControl!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    @IBOutlet weak var buttonHighlight:UIView!
    @IBOutlet weak var descriptionView:UIView!
    
    @IBOutlet var buttonCollection: [PreferenceButton]!
    
    @IBOutlet weak var topView: UIView!
    @IBOutlet weak var switchChannel: UIView!
    
    //MARK- VARIABLES
   // var isRunWalk = true
    var runSetting = 0
    var walkSetting = 0
    var preferences: [Preference] =  [.info, .audio, .vibrate, .cadence, .music, .workout]
    
    var runComponent: Int {
        if data.isRunWalk {
            return 0
        } else {
            return 1
        }
    }
    
    var walkComponent: Int {
        if data.isRunWalk {
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
        configure()
        switchView.alpha = 0
        buttonHighlight.alpha = 0
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = buttonHighlight.bounds
        gradientLayer.colors = [UIColor.packLight.cgColor, UIColor.jake.cgColor]
        buttonHighlight.layer.addSublayer(gradientLayer)
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        let button = buttonCollection[data.settingsTab]
        positionSwitchView(destination: button.center.x)
        addGradient()
    }
    
    
    
    //MARK:- ACTIONS
    @IBAction func preferenceButtonTapped(_ sender: PreferenceButton) {
        data.settingsTab  = sender.tag
        data.save()
        self.positionSwitchView(destination: sender.center.x)
        self.selectButton(button: sender)
        self.initSegmentedControls(animateDesc: true)
    }
    
    @IBAction func doneButtonTapped(_sender:UIButton) {
        
        //if mode changed 
        //if run  is differnt
        //is walk is different
        //if session ids differnt
        
        if let state = data.state {
            if state.runValue != data.runValue {
                data.workout = nil
            }
            
            if state.walkValue != data.walkValue {
                data.workout = nil
            }
            
            if state.isRunWalk != data.isRunWalk {
                data.workout = nil
            }
            
            if state.sessionOn != data.workoutOn {
                data.workout = nil
            }
            
            data.state = nil
        }
        
        
        
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func intervalOrderChanged(_ sender: UISegmentedControl) {
        data.isRunWalk = sender.selectedSegmentIndex == 0
        data.isRunWalk = sender.selectedSegmentIndex == 0
        data.save()
        picker.reloadAllComponents()
        picker.selectRow(data.runValue, inComponent: runComponent, animated: false)
        picker.selectRow(data.walkValue, inComponent: walkComponent, animated: false)
        postTitle()
    }
    
    @IBAction func controlChanged(_ sender: UISegmentedControl) {
        if activePreference  == .cadence {
            data.cadenceFrequency = sender.selectedSegmentIndex
        } else if activePreference == .workout {
            data.sequenceRepeats = sender.selectedSegmentIndex
        }
        data.save()
        //postDescription()
        setDescriptionText()
    }
    
    //MARK:- METHODS
    func configure() {
        self.view.backgroundColor = UIColor.jake
       // topView.backgroundColor = UIColor.packLight
        switchView.delegate = self
        picker.selectRow(data.runValue, inComponent: runComponent, animated: false)
        picker.selectRow(data.walkValue, inComponent: walkComponent, animated: false)
        
        if !data.isRunWalk {
            intervalOrderControl.selectedSegmentIndex = 1
        }
        
        configureButtons()
        initSegmentedControls(animateDesc: false)
        postTitle()
        postDescription()
    
        descriptionView.backgroundColor = UIColor.clear
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
            infoButton.isEnabled = false
            infoButton.alpha = 0.0
        }
    }
    
    func postTitle() {
        titleLabel.attributedText = data.colorizedTitle
    }
    
    func postDescription() {
        
        UIView.animate(withDuration: 0.3, animations: {
            self.descriptionView.alpha = 0
        }) { (success) in
            self.setDescriptionText()
            UIView.animate(withDuration: 0.3, delay: 0.1, options: [], animations: {
                self.descriptionView.alpha = 1
            }, completion: { (success) in
                
            })
        }
    }
    
    func setDescriptionText() {
        switch activePreference {
        case .audio:
            if data.audioOn {
                self.descriptionLabel.attributedText = data.formatDescription(lineOne: "", lineTwo: "play audio cues", lineThree: "")
            } else {
                self.descriptionLabel.attributedText = data.formatDescription(lineOne: "", lineTwo: "audio cues off", lineThree: "")
            }
        case .vibrate:
            if data.vibrateOn {
                self.descriptionLabel.attributedText = data.formatDescription(lineOne: "vibrate for the", lineTwo: "last five seconds", lineThree: "of each interval")
            } else {
                self.descriptionLabel.attributedText = data.formatDescription(lineOne: "", lineTwo: "vibrate off", lineThree: "")
            }
            
        case .cadence:
            if data.cadenceOn {
                self.descriptionLabel.attributedText = data.attrCadenceDescription
            } else {
                self.descriptionLabel.attributedText = data.formatDescription(lineOne: "", lineTwo: "cadence off", lineThree: "")
            }
        case .music:
            if data.musicOn {
            self.descriptionLabel.attributedText = data.formatDescription(lineOne: "play music from", lineTwo: "the itunes library", lineThree: "while timer is running")
            } else {
                self.descriptionLabel.attributedText = data.formatDescription(lineOne: "", lineTwo: "music off", lineThree: "")
            }
        case .workout:
            if data.workoutOn {
                self.descriptionLabel.attributedText = data.attrWorkoutDescription
            } else {
                self.descriptionLabel.attributedText = data.formatDescription(lineOne: "", lineTwo: "timed session off", lineThree: "")
            }
        default:
            self.descriptionLabel.text = ""
        }
        
        descriptionLabel.backgroundColor = UIColor.clear
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
        }
    }
  
    func initSegmentedControls(animateDesc:Bool) {
        intervalOrderControl.tintColor = UIColor.activeButton
        intervalOrderControl.backgroundColor = UIColor.white.withAlphaComponent(0.5)
        sessionControl.tintColor = UIColor.activeButton
        cadenceControl.tintColor = UIColor.activeButton
        sessionControl.backgroundColor = UIColor.white.withAlphaComponent(0.5)
        cadenceControl.backgroundColor = UIColor.white.withAlphaComponent(0.5)
        
        sessionControl.isHidden = activePreference != .workout
        cadenceControl.isHidden = activePreference != .cadence
        
        switch activePreference {
        case .cadence:
            cadenceControl.isEnabled = data.cadenceOn
            cadenceControl.selectedSegmentIndex = data.cadenceFrequency
        case .workout:
            sessionControl.isEnabled = data.workoutOn
            sessionControl.selectedSegmentIndex = data.sequenceRepeats
            
            
            for (index, minutes) in data.sessionArray.enumerated() {
                sessionControl.setTitle("\(minutes)", forSegmentAt: index)
            }
        default:
           break
        }
        if animateDesc {
            self.postDescription()
        } else {
            self.setDescriptionText()
        }
    }
    
    func positionSwitchView(destination: CGFloat) {
        switchView.preference = activePreference
        let pa = UIViewPropertyAnimator(duration: 0.25, curve: .easeOut) {
            self.switchView.center.x = destination
            self.buttonHighlight.center.x = destination
            self.switchView.alpha = 1
            self.buttonHighlight.alpha = 1
        }
        
        pa.startAnimation()
        view.layoutIfNeeded()
    }
    
    func checkPermissions() {
        switch MPMediaLibrary.authorizationStatus() {
        case .notDetermined:
            MPMediaLibrary.requestAuthorization({(newPermissionStatus: MPMediaLibraryAuthorizationStatus) in
                if newPermissionStatus == .authorized {
                    //self.musicControls.playMusic()
                }
            })
        case .denied, .restricted:
            break
        default:
            break
        }

        
    }
    
    func addGradient() {
        let gradientLayer = CAGradientLayer()
        let offset: CGFloat = 80
        var h = view.bounds.height
        h -= offset
        let w = view.bounds.width
        
        gradientLayer.frame = CGRect(x: 0, y: offset, width: w, height: h)
        gradientLayer.colors = [UIColor.dot.cgColor, UIColor.dot.cgColor, UIColor.packLight.cgColor, UIColor.dot.cgColor, UIColor.dot.cgColor]
         gradientLayer.locations = [0, 0.2,  0.5, 0.8,  1.0]
        self.view.layer.insertSublayer(gradientLayer, at: 0)
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
        initSegmentedControls(animateDesc: false)
    }
}

extension PreferenceViewController: UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 2
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return Data.timeArray.count
    }
    
    func pickerView(_ pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
        return pickerView.bounds.width / 2
    }
    
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        let dim = pickerView.bounds.width/2 - 10
        
        let pView = UIView(frame: CGRect(x: 0, y: 0, width: dim, height: dim))
        pView.layer.cornerRadius = dim/2
        
        let margin: CGFloat = 15
        let imageView = UIImageView(frame: CGRect(x: margin, y: margin, width: dim-margin*2, height: dim-margin*2))
    
        imageView.frame = CGRect(x: 0, y: margin, width: dim*0.45, height: dim*0.45)
        imageView.center.x = pView.center.x
        imageView.tintColor = UIColor.white
        
        pView.addSubview(imageView)
        
        let label = UILabel(frame: pView.frame)
        label.frame = CGRect(x: 0, y: dim*0.60, width: dim, height: dim*0.25)
        
        label.attributedText = Tool.formatPickerTime(time: Data.timeArray[row])
        label.textAlignment = .center
        pView.addSubview(label)
        label.textColor = UIColor.white
        
        
        if component == runComponent {
            pView.backgroundColor = UIColor.run
            imageView.image = UIImage(named: "run_solid")
           
            
        } else {
            pView.backgroundColor = UIColor.walk
            imageView.image = UIImage(named: "walk_solid")
            
        }
        
        pView.layer.borderWidth = 2
        pView.layer.borderColor = UIColor.white.cgColor
        
        return pView
    }
}

extension PreferenceViewController: SwitchViewDelegate {
    func changePreferenceState() {
        setDescriptionText()
        setButtonState()
        initSegmentedControls(animateDesc: false)
    }
}


