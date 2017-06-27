//
//  TimerViewController.swift
//  easyIntervals
//
//  Created by Michael Schaffner on 2/16/17.
//  Copyright © 2017 Michael Schaffner. All rights reserved.
//

import UIKit

class TimerViewController: UIViewController{
    /*
    //MARK:- IBOUTLET
    @IBOutlet weak var intervalTime: UILabel!
    @IBOutlet weak var elapsedTime: UILabel!
    @IBOutlet weak var sessionType: UILabel!
    @IBOutlet weak var buttonBar: ButtonView!
    
    @IBOutlet weak var infoButton: RoundButton!
    @IBOutlet weak var audioButton: RoundButton!
    @IBOutlet weak var vibrateButton: RoundButton!
    @IBOutlet weak var cadenceButton: RoundButton!
    @IBOutlet weak var musicButton: RoundButton!
    @IBOutlet weak var workoutButton: RoundButton!
    @IBOutlet weak var settingsButton:UIButton!
    @IBOutlet weak var resetButton:UIButton!
    @IBOutlet weak var titleLabel:UILabel!

    
    @IBOutlet var prefButtons: [UIButton]!
   
    //MARK - VARIABLES
    var workout: Workout!
    var musicControls: MusicControls!
    
    lazy var timerWindowView: TimerWindowView = {
        var h = self.view.frame.size.height
        h -= 120 // header + footer
        h -= 10 //margin
        h/=2
        let x = self.view.frame.width - h
        let frame = CGRect(x: x/2, y: h + 60, width: h, height: h)
        return TimerWindowView(frame: frame)
    }()
    
    //MARK:- LIFECYCLE
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        configureScreen()
        initWorkout()
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadMusicControls()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK:- IBACTIONS
    @IBAction func settingsTapped(_ sender: UIButton) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        if let ivc = storyboard.instantiateViewController(withIdentifier: "Settings") as? SettingsViewController {
            ivc.settingHome = timerWindowView.frame
            ivc.modalTransitionStyle = .crossDissolve
            self.present(ivc, animated: true, completion: { _ in })
        }

    }
    
    @IBAction func resetTapped(_ sender: UIButton) {
        openResetAlert()
    }

    @IBAction func infoButtonTapped(_ sender: RoundButton) {
        timerWindowView.instructions.toggle()
    }
    
    @IBAction func musicTapped(_ sender: UIButton) {
       showMusicControls()
    }
    
    @IBAction func cadenceTapped(_ sender: UIButton) {
        if let wo = workout {
            wo.playCadence()
        }
    }
    
    
    //MARK:- METHODS
    func configureScreen() {
        view.backgroundColor = UIColor.Theme.back
        
        
        configureLabels()
        configureButtons()
        
        initGestures()
        view.addSubview(timerWindowView)
    }
    
    func configureButtons() {
        audioButton.isOn = data.audioOn
        vibrateButton.isOn = data.vibrateOn
        cadenceButton.isOn = data.cadenceOn
        musicButton.isOn = data.musicOn
        workoutButton.isOn = data.workoutOn
        
        audioButton.isUserInteractionEnabled = false
        vibrateButton.isUserInteractionEnabled = false
        cadenceButton.isUserInteractionEnabled = data.cadenceOn
        musicButton.isUserInteractionEnabled = data.musicOn
        workoutButton.isUserInteractionEnabled = false
        
        infoButton.makeInfo()
        resetButton.tintColor = UIColor.Theme.base
        settingsButton.tintColor = UIColor.Theme.base
    }
    
    func configureLabels() {
        titleLabel.font = UIFont.title
        titleLabel.textColor = UIColor.Theme.base
        titleLabel.text = data.settingTitle
        elapsedTime.textColor = UIColor.Theme.base
        sessionType.textColor = UIColor.Theme.base
    }
    
    func updateTimeLabels() {
        intervalTime.attributedText = Tool.intervalTimeFormatted(seconds: workout.currentInterval.remainingSeconds)
        
        if workout.currentMode == .run {
            intervalTime.textColor = UIColor.run
        } else {
            intervalTime.textColor = UIColor.walk
        }
        
        timerWindowView.intervalSeconds = workout.currentInterval.remainingSeconds
        
        if let session = workout.woSession {
            elapsedTime.text = Tool.formatTime(secs: session.remainingSeconds, withHours: true)
            sessionType.text = "remaining"
        } else {
            elapsedTime.text = Tool.formatTime(secs: workout.elapsedSeconds, withHours: true)
            sessionType.text = "elapsed"
        }
    }
    */
    
}




