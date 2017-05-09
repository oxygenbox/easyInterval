//
//  TimerViewController.swift
//  easyIntervals
//
//  Created by Michael Schaffner on 2/16/17.
//  Copyright © 2017 Michael Schaffner. All rights reserved.
//

import UIKit

class TimerViewController: UIViewController {
    //MARK:- IBOUTLET
    @IBOutlet weak var intervalTime: UILabel!
    @IBOutlet weak var elapsedTime: UILabel!
    @IBOutlet weak var sessionType: UILabel!
    
    @IBOutlet weak var infoButton: RoundButton!
    @IBOutlet weak var audioButton: RoundButton!
    @IBOutlet weak var vibrateButton: RoundButton!
    @IBOutlet weak var cadenceButton: RoundButton!
    @IBOutlet weak var musicButton: RoundButton!
    @IBOutlet weak var workoutButton: RoundButton!
    
     @IBOutlet var prefButtons: [UIButton]!
    @IBOutlet weak var modeView: ModeView!
    
    //MARK - VARIABLES
    var workout = Workout()
    

    //MARK:- LIFECYCLE
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setUp()
        initWorkout()
    
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    //MARK:- Methods
    func setUp() {
        title = data.settingTitle
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Settings", style: .plain, target: self, action: #selector(settingTapped))
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Reset", style: .plain, target: self, action: #selector(resetTapped))

        navigationItem.rightBarButtonItem?.setTitleTextAttributes([NSForegroundColorAttributeName: UIColor.base, NSFontAttributeName: UIFont(name: "AvenirNextCondensed-Medium", size: 16.0)!], for: .normal)
        
        navigationItem.leftBarButtonItem?.setTitleTextAttributes([NSForegroundColorAttributeName: UIColor.base, NSFontAttributeName: UIFont(name: "AvenirNextCondensed-Medium", size: 16.0)!], for: .normal)
        
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "Main", style: .plain, target: nil, action: nil)
        
        navigationItem.backBarButtonItem?.setTitleTextAttributes([NSForegroundColorAttributeName: UIColor.base, NSFontAttributeName: UIFont(name: "AvenirNextCondensed-Regular", size: 10.0)!], for: .normal)
        
        audioButton.active = data.audioOn
        vibrateButton.active = data.vibrateOn
        cadenceButton.active = data.cadenceOn
        musicButton.active = data.musicOn
        workoutButton.active = data.workoutOn
        
        view.backgroundColor = UIColor.base
        
        initGestures()
    }
    
    func postTimes() {
        intervalTime.text = Tool.formatTime(secs: workout.currentInterval.remainingSeconds, withHours: false)
        elapsedTime.text = Tool.formatTime(secs: workout.elapsedSeconds, withHours: true)
        intervalTime.textColor = UIColor.accent
        elapsedTime.textColor = UIColor.accent
        sessionType.textColor = UIColor.accent
        self.modeUpdate()
    }
    
    func initWorkout() {
        workout.delegate = self
        postTimes()
       // timerView.modeLabel.attributedText = modeName()
    }
    
    func toggleSession() {
        //called on tap gesture
        workout.toggleTimer()
        if(workout.timer == nil) {
            modeView.pause()
        } else {
            modeView.play()
        }
    }
    
    //MARK:- NAVBAR BUTTON ACTIONS
    func settingTapped() {
        if let vc = storyboard?.instantiateViewController(withIdentifier: "Settings") as? SettingsViewController {
            self.navigationController?.pushViewController(vc, animated: true)
            self.modeUpdate()
        }
    }
    
    func resetTapped() {
        let ac = UIAlertController(title: nil, message: nil, preferredStyle: .alert)
        let runAction = UIAlertAction(title: "Restart Run Interval", style: .default) { [unowned self] (action) in
            self.workout.restart(mode: .run)
        }
        
        let walkAction = UIAlertAction(title: "Restart Walk Interval", style: .default) { [unowned self] (action) in
            self.workout.restart(mode: .walk)
            self.postTimes()
        }
        
        let elapsedAction = UIAlertAction(title: "Restart Elapsed Time", style: .default) { [unowned self] (action) in
            self.workout.elapsedSeconds = 0
            self.postTimes()
        }
        
        let allAction = UIAlertAction(title: "Restart Interval & Elapsed Time", style: .default) { [unowned self] (action) in
            self.workout.restart(mode: self.workout.currentMode)
            self.workout.elapsedSeconds = 0
            self.postTimes()
        }
        
        let workoutAction = UIAlertAction(title: "Restart Workout", style: .default) { (action) in
            // postTimes()
        }
        
        let endWOAction = UIAlertAction(title: "End Workout", style: .default) { (action) in
            //  postTimes()
        }
        
        let cancelActions = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        
        if !data.workoutOn {
            ac.addAction(runAction)
            ac.addAction(walkAction)
            ac.addAction(elapsedAction)
            ac.addAction(allAction)
        } else {
            ac.addAction(workoutAction)
            ac.addAction(endWOAction)
        }
        
        ac.addAction(cancelActions)
        present(ac, animated: true, completion: nil)
    }
    
    //MARK: - GESTURES
    func initGestures() {
        let twoFingerTap = UITapGestureRecognizer(target: self, action: #selector(twoTapDetected(_:)))
        twoFingerTap.numberOfTapsRequired = 1
        twoFingerTap.numberOfTouchesRequired = 2
        view.addGestureRecognizer(twoFingerTap)
        let swipeRecognizer = UISwipeGestureRecognizer(target: self, action: #selector(swipeDetected(_:)))
        view.addGestureRecognizer(swipeRecognizer)
    }
    
    func twoTapDetected(_ sender: UITapGestureRecognizer) {
        toggleSession()
    }
    
    func swipeDetected(_ sender : UISwipeGestureRecognizer) {
        //need to insert music control
        print("swipe")
    }
}

//MARK:- EXTENSIONS
extension TimerViewController: WorkoutDelegate {
    func woTick(){
        postTimes()
    }
    
    func workoutTick(with percent: CGFloat) {
        postTimes()
        modeView.animateHead(pct: 1 - percent)
    }

    func modeUpdate(){
        modeView.mode = workout.currentMode
    }

    func percentComplete(pct: CGFloat) {
        modeView.animateHead(pct: 1 - pct)
        modeView.elapsedTimer(percent: 1-pct)
        modeView.intervalTimer(percent: 1-pct)
    }
    
    
}


