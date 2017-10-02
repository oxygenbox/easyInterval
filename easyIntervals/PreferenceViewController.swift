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
    @IBOutlet weak var secondsButton: PreferenceButton!
    @IBOutlet weak var audioButton: PreferenceButton!
    @IBOutlet weak var vibrateButton: PreferenceButton!
    @IBOutlet weak var cadenceButton: PreferenceButton!
    @IBOutlet weak var musicButton: PreferenceButton!
    @IBOutlet weak var sessionButton: PreferenceButton!
    @IBOutlet weak var infoButton: PreferenceButton!
    
    @IBOutlet weak var doneButton: UIButton!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var cadenceControl: UISegmentedControl!
    @IBOutlet weak var sessionControl: UISegmentedControl!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var buttonBar: ButtonView!
    
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
    
   //Help Sequence
    var helpSeqTimer: Timer?
    var helpSeqPointer = 0
    var helpSeqComponents = [Int]()
    var helpSeqDelay = 0
    var helpSeqDelayLength = 3

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
        gradientLayer.locations = [0.0, 0.75]
        gradientLayer.colors = [UIColor.packLight.cgColor, UIColor.packDark.cgColor]
        buttonHighlight.layer.addSublayer(gradientLayer)
    }
    
    lazy var buttonRing: UIView = {
        let view = UIView(frame: (CGRect(x: 0, y: 8, width: 44, height: 44)))
        view.backgroundColor = UIColor.white.withAlphaComponent(0.75)
        view.layer.cornerRadius = 22
        view.layer.borderColor = UIColor.run.cgColor
        view.layer.borderWidth = 4
        view.isHidden = true
        return view
    }()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        let button = buttonCollection[data.settingsTab]
        positionSwitchView(destination: button.center.x)
    }
    
    //MARK:- ACTIONS
    @IBAction func preferenceButtonTapped(_ sender: PreferenceButton) {
        stopHelpSeq()
        data.settingsTab  = sender.tag
        data.save()
        self.positionSwitchView(destination: sender.center.x)
        self.selectButton(button: sender)
        self.initSegmentedControls(animateDesc: true)
    }
    
    @IBAction func doneButtonTapped(_sender:UIButton) {
        stopHelpSeq()
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
        stopHelpSeq()
        data.isRunWalk = sender.selectedSegmentIndex == 0
        data.isRunWalk = sender.selectedSegmentIndex == 0
        data.save()
        picker.reloadAllComponents()
        picker.selectRow(data.runValue, inComponent: runComponent, animated: false)
        picker.selectRow(data.walkValue, inComponent: walkComponent, animated: false)
        postTitle()
    }
    
    @IBAction func controlChanged(_ sender: UISegmentedControl) {
        stopHelpSeq()
        if activePreference  == .cadence {
            data.cadenceFrequency = sender.selectedSegmentIndex
        } else if activePreference == .workout {
            data.sequenceRepeats = sender.selectedSegmentIndex
        }
        data.save()
        setDescriptionText()
    }
    
    @IBAction func infoTapped(_sender:UIButton) {
        self.startInfo()
    }
    
    //MARK:- METHODS
    func configure() {
        view.backgroundColor = UIColor.packLight
      
        switchView.delegate = self
        picker.selectRow(data.runValue, inComponent: runComponent, animated: false)
        picker.selectRow(data.walkValue, inComponent: walkComponent, animated: false)
        
        topView.backgroundColor = UIColor.packLight
        let topGap = UIView(frame: CGRect(x: 0, y: topView.bounds.height, width: view.bounds.width, height: 1))
        topGap.backgroundColor = UIColor.white
        topView.addSubview(topGap)
        
        let botGap = UIView(frame: CGRect(x: 0, y: 0, width: view.bounds.width, height: 1))
        botGap.backgroundColor = UIColor.white
        buttonBar.addSubview(botGap)
        
        let buttonBack = UIView(frame: CGRect(x: 0, y: view.frame.height - buttonBar.bounds.height, width: view.frame.width, height: buttonBar.bounds.height))
        buttonBack.backgroundColor = UIColor.packDark
        
        view.insertSubview(buttonBack, at: 0)
        
        
      //  buttonBar.backgroundColor = UIColor.packDark
        addGradient()
        
        
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
//
                setButtonState()
//            //infoButton.makeInfo()
//            //infoButton.isEnabled = false
//           // infoButton.alpha = 0.0
        }
        
        infoButton.makeInfo()
        
        buttonBar.addSubview(buttonRing)
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
            if data.isSixtySeconds {
                 self.descriptionLabel.attributedText = data.formatDescription(lineOne: "display intervals", lineTwo: "as 60 second", lineThree: "increments")
            } else {
                self.descriptionLabel.attributedText = data.formatDescription(lineOne: "display intervals", lineTwo: "as 30 second", lineThree: "increments")
            }
        }
        
        descriptionLabel.backgroundColor = UIColor.clear
        descriptionLabel.layer.cornerRadius  = 0
        descriptionLabel.layer.borderWidth = 0
        descriptionLabel.clipsToBounds = false
    }
    
   
    
    func setButtonState() {
        audioButton.isOn = data.audioOn
        vibrateButton.isOn = data.vibrateOn
        cadenceButton.isOn = data.cadenceOn
        musicButton.isOn = data.musicOn
        sessionButton.isOn = data.workoutOn
        secondsButton.isOn = data.isSixtySeconds
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
                case secondsButton:
                    but.isOn = data.isSixtySeconds
                default:
                break
            }
        }
    }
  
    func initSegmentedControls(animateDesc:Bool) {
        intervalOrderControl.tintColor = UIColor.packDark
       // intervalOrderControl.backgroundColor = UIColor.white.withAlphaComponent(0.5)
        sessionControl.tintColor = UIColor.white
        cadenceControl.tintColor = UIColor.white
       // sessionControl.backgroundColor = UIColor.white.withAlphaComponent(0.5)
      //  cadenceControl.backgroundColor = UIColor.white.withAlphaComponent(0.5)
        
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
            h -= buttonBar.bounds.height
            let w = view.bounds.width
        
            gradientLayer.frame = CGRect(x: 0, y: offset, width: w, height: h)
            gradientLayer.colors = [UIColor.packLight.cgColor, UIColor.packDark.cgColor]
            gradientLayer.locations = [0,  1.0]
            self.view.layer.insertSublayer(gradientLayer, at: 0)
    }
    
    func startInfo() {
        guard helpSeqTimer == nil else {
            self.stopHelpSeq()
            return
        }
        initHelpSequence()
        helpSeqTimer = Timer.scheduledTimer(withTimeInterval: 1.1, repeats: true) { (timer) in
            

            if self.helpSeqComponents.count > 0 {
                self.helpPickerSequence()
            } else {
                
                if self.helpSeqDelay > 0 {
                    self.helpSeqDelay -= 1
                } else {
                    self.helpButtonSequence()
                }
            }
        }
    }
    
    func initHelpSequence() {
        helpSeqPointer = 0
        helpSeqComponents = [runComponent, walkComponent]
        helpSeqDelay = helpSeqDelayLength
    
        descriptionLabel.layer.cornerRadius  = 20
        descriptionLabel.layer.borderColor = UIColor.white.cgColor
        descriptionLabel.layer.borderWidth = 1
        descriptionLabel.clipsToBounds = true
        self.descriptionLabel.attributedText = data.formatDescription(lineOne: "set the", lineTwo: "run and walk intervals", lineThree: "by swiping numbers above")
    }
    
    func helpButtonSequence() {
        self.descriptionLabel.attributedText = data.formatDescription(lineOne: "use the buttons below to", lineTwo: "set preferences", lineThree: "")
        let button = self.buttonCollection[helpSeqPointer]
        self.buttonRing.center.x = button.center.x + 20
        self.buttonRing.isHidden = false
        helpSeqPointer += 1
        if helpSeqPointer >= self.buttonCollection.count {
            initHelpSequence()
        }
    }
    
    func helpPickerSequence() {
       // self.descriptionLabel.attributedText = data.formatDescription(lineOne: "set the", lineTwo: "run and walk intervals", lineThree: "by swiping numbers above")
        
        let component = helpSeqComponents.remove(at: 0)
        var value = 0
        if component == runComponent {
            value = data.runValue
        } else {
            value = data.walkValue
        }
        let current = self.picker.selectedRow(inComponent: component)
        
        var i = 1
        
        if value >= data.timeArray.count-1 {
            i = -1
        }
        
        if value == current {
            self.picker.selectRow(current + i, inComponent: component, animated: true)
        } else {
            self.picker.selectRow(value, inComponent: component, animated: true)
        }
    }
    
    func stopHelpSeq() {
        helpSeqTimer?.invalidate()
        helpSeqTimer = nil
        buttonRing.isHidden = true
        self.picker.selectRow(data.runValue, inComponent: runComponent, animated: true)
        self.picker.selectRow(data.walkValue, inComponent: walkComponent, animated: true)
        self.postDescription()
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
         stopHelpSeq()
        
    }
}

extension PreferenceViewController: UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 2
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return data.timeArray.count
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
        
        label.attributedText = Tool.formatPickerTime(time: data.timeArray[row])
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
        stopHelpSeq()
        setDescriptionText()
        setButtonState()
        initSegmentedControls(animateDesc: false)
    }
    
    func incrementUpdate() {
        var runVal = data.runValue
        var walkVal = data.walkValue
       
        if data.isSixtySeconds {
            runVal /= 2
            walkVal /= 2
            let image = UIImage(named: "icon_00")
            secondsButton.setImage(image, for: .normal)
        } else {
            runVal *= 2
            walkVal *= 2
            let image = UIImage(named: "icon_30")
            secondsButton.setImage(image, for: .normal)
        }
        
        data.runValue = runVal
        data.walkValue = walkVal
        data.save()
        
        self.picker.reloadAllComponents()
        self.picker.selectRow(data.runValue, inComponent: runComponent, animated: true)
        self.picker.selectRow(data.walkValue, inComponent: walkComponent, animated: true)
        postTitle()
    }
}





