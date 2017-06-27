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
    @IBOutlet weak var doneButton: UIButton!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var cadenceControl: UISegmentedControl!
    @IBOutlet weak var sessionControl: UISegmentedControl!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    @IBOutlet var buttonCollection: [PreferenceButton]!
    
    @IBOutlet weak var topView: UIView!
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
        let button = buttonCollection[data.settingsTab]
        positionSwitchView(destination: button.center.x)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    //MARK:- ACTIONS
    @IBAction func preferenceButtonTapped(_ sender: PreferenceButton) {
        data.settingsTab  = sender.tag
        data.save()
        self.positionSwitchView(destination: sender.center.x)
        self.selectButton(button: sender)
        self.initSegmentedControls()
    }
    
    @IBAction func doneButtonTapped(_sender:UIButton) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func intervalOrderChanged(_ sender: UISegmentedControl) {
        data.isRunWalk = sender.selectedSegmentIndex == 0
        data.isRunWalk = sender.selectedSegmentIndex == 0
        data.save()
        picker.reloadAllComponents()
        picker.selectRow(data.runValue, inComponent: runComponent, animated: false)
        picker.selectRow(data.walkValue, inComponent: walkComponent, animated: false)
    }
    
    @IBAction func controlChanged(_ sender: UISegmentedControl) {
        if activePreference  == .cadence {
            data.cadenceFrequency = sender.selectedSegmentIndex
        } else if activePreference == .workout {
            data.sequenceRepeats = sender.selectedSegmentIndex
        }
        data.save()
        postDescription()
        
    }
    
    //MARK:- METHODS
    func configure() {
        self.view.backgroundColor = UIColor.background
        switchView.delegate = self
        picker.selectRow(data.runValue, inComponent: runComponent, animated: false)
        picker.selectRow(data.walkValue, inComponent: walkComponent, animated: false)
        
        if !data.isRunWalk {
            intervalOrderControl.selectedSegmentIndex = 1
        }
        
        
        
        configureButtons()
        initSegmentedControls()
        postTitle()
    }
    
    func configureButtons() {
        for (index, button) in buttonCollection.enumerated() {
            button.tag = index
            
         
            if index == data.settingsTab {
                //positionSwitchView(destination: button.center.x)
                
                button.select()
                print(index)
               
                
            } else {
                button.deselect()
            }
            
            setButtonState()
            infoButton.makeInfo()
            //doneButton.tintColor = UIColor.Theme.base
        }
        
       
    }
    
    func postTitle() {
        titleLabel.attributedText = data.formattedTitle
    }
    
    func postDescription() {
        switch activePreference {
            case .audio:
                break
            case .vibrate:
                break
            case .cadence:
                self.descriptionLabel.text = data.cadenceDescription
            case .music:
                break
            case .workout:
                self.descriptionLabel.text = data.workoutDescription
            default:
                break
        }
        descriptionLabel.descFormat(lineHeight: 1)
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
  
    func initSegmentedControls() {
        intervalOrderControl.tintColor = UIColor.activeButton
        intervalOrderControl.backgroundColor = UIColor.white.withAlphaComponent(0.25)
        sessionControl.tintColor = UIColor.activeButton
        cadenceControl.tintColor = UIColor.activeButton
        sessionControl.backgroundColor = UIColor.white.withAlphaComponent(0.2)
        cadenceControl.backgroundColor = UIColor.white.withAlphaComponent(0.2)
        
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
        postDescription()
    }
    
    func positionSwitchView(destination: CGFloat) {
        switchView.preference = activePreference
        let pa = UIViewPropertyAnimator(duration: 0.25, curve: .easeOut) {
            self.switchView.center.x = destination
        }
        
        pa.startAnimation()
        view.layoutIfNeeded()
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
        
        let margin: CGFloat = 30
        let imageView = UIImageView(frame: CGRect(x: margin, y: margin, width: dim-margin*2, height: dim-margin*2))
        pView.addSubview(imageView)
        
        let label = UILabel(frame: pView.frame)
        label.attributedText = Tool.formatPickerTime(time: Data.timeArray[row])
        label.textAlignment = .center
        pView.addSubview(label)
        label.textColor = UIColor.white
        
        
        if component == runComponent {
            pView.backgroundColor = UIColor.run
          //  imageView.image = UIImage(named: "run_solid")
             imageView.tintColor = UIColor.run
            
        } else {
            pView.backgroundColor = UIColor.walk
           // imageView.image = UIImage(named: "walk_solid")
            imageView.tintColor = UIColor.walk
        }
        
        
        return pView
    }
}

extension PreferenceViewController: SwitchViewDelegate {
    func changePreferenceState() {
        setButtonState()
        initSegmentedControls()
    }
}


