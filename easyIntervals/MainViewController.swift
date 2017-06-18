//
//  MainViewController.swift
//  easyIntervals
//
//  Created by Michael Schaffner on 6/17/17.
//  Copyright © 2017 Michael Schaffner. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {

    //MARK- IBOutlet
    @IBOutlet weak var infoButton: PreferenceButton!
    @IBOutlet weak var audioButton: PreferenceButton!
    @IBOutlet weak var vibrateButton: PreferenceButton!
    @IBOutlet weak var cadenceButton: PreferenceButton!
    @IBOutlet weak var musicButton: PreferenceButton!
    @IBOutlet weak var workoutButton: PreferenceButton!
    @IBOutlet weak var settingsButton:UIButton!
    @IBOutlet weak var resetButton:UIButton!
    @IBOutlet weak var titleLabel:UILabel!

    @IBOutlet weak var leftWindow: RoundModeView!
    @IBOutlet weak var rightWindow: RoundModeView!
    
    //MARK- VARIABLES
    var workout: Workout!
    var musicControls: MusicControls!
    
    var runWindow: RoundModeView {
        if data.isRunWalk {
            return self.leftWindow
        } else {
            return self.rightWindow
        }
    }
    
    var walkWindow: RoundModeView {
        if data.isRunWalk {
            return self.rightWindow
        } else {
            return self.leftWindow
        }
    }

    //MARK:- LIFECYCLE
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        configure()
        initWorkout()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    //MARK- IBACTIONS
    @IBAction func settingsTapped(_ sender: UIButton) {
        
    }
    
    @IBAction func resetTapped(_ sender: UIButton) {
        openResetOptions()
    }
    
    
    @IBAction func infoTapped(_ sender: UIButton) {
        
    }
    
    @IBAction func cadenceTapped(_ sender: UIButton) {
        guard let workout = workout else {
            return
        }
        workout.playCadence()
    }
    
    
    @IBAction func musicTapped(_ sender: UIButton) {
        openMusicControls()
    }
    
    //MARK:- METHODS
    func configure() {
        configureButtons()
    }
    
    func configureButtons() {
        audioButton.isOn = data.audioOn
        audioButton.isUserInteractionEnabled = false
        vibrateButton.isOn = data.vibrateOn
        vibrateButton.isUserInteractionEnabled = false
        cadenceButton.isOn = data.cadenceOn
        cadenceButton.isUserInteractionEnabled = data.cadenceOn
        musicButton.isOn = data.musicOn
        musicButton.isUserInteractionEnabled = data.musicOn
        workoutButton.isOn = data.workoutOn
        workoutButton.isUserInteractionEnabled = false
        
        infoButton.makeInfo()
        resetButton.tintColor = UIColor.Theme.base
        settingsButton.tintColor = UIColor.Theme.base
    }
    
    func initWorkout() {
        
    }
    
    func  openResetOptions() {
        
    }
    
    func openMusicControls() {
        
    }


   

}


/*

 
 import UIKit
 
 class TimerViewController: UIViewController{
 //MARK:- IBOUTLET
 @IBOutlet weak var intervalTime: UILabel!
 @IBOutlet weak var elapsedTime: UILabel!
 @IBOutlet weak var sessionType: UILabel!
 @IBOutlet weak var buttonBar: ButtonView!
 
 

 
 @IBOutlet var prefButtons: [UIButton]!
 
 //MARK - VARIABLES
 
 
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
 
 override func viewDidLoad() {
 super.viewDidLoad()
 loadMusicControls()
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
 
 
 @IBAction func infoButtonTapped(_ sender: RoundButton) {
 timerWindowView.instructions.toggle()
 }
 
 @IBAction func musicTapped(_ sender: UIButton) {
 showMusicControls()
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
 
 func initWorkout() {
 workout = Workout()
 workout.delegate = self
 updateTimeLabels()
 modeUpdate()
 }
 
 func toggleSession() {
 //called on tap gesture
 workout.toggleTimer()
 if(workout.timer == nil) {
 timerWindowView.pause()
 settingsButton.isEnabled = true
 
 } else {
 timerWindowView.hideInstructions()
 if timerWindowView.intervalClock.hasStarted {
 timerWindowView.resume()
 } else {
 let intervalSecs = workout.currentInterval.lengthInSeconds
 var sessionSecs: Int?
 if workout.woSession != nil {
 sessionSecs = data.totalSessionSeconds
 }
 timerWindowView.beginClocks(intervalSeconds: intervalSecs, sessionSeconds: sessionSecs)
 }
 settingsButton.isEnabled = false
 }
 }
 
 func openResetAlert() {
 let ac = UIAlertController(title: nil, message: nil, preferredStyle: .alert)
 let runAction = UIAlertAction(title: "Restart Run Interval", style: .default) { [unowned self] (action) in
 self.timerWindowView.reset(interval: true, session: false)
 self.workout.restart(mode: .run)
 self.updateTimeLabels()
 }
 
 let walkAction = UIAlertAction(title: "Restart Walk Interval", style: .default) { [unowned self] (action) in
 self.timerWindowView.reset(interval: true, session: false)
 self.workout.restart(mode: .walk)
 self.updateTimeLabels()
 }
 
 let elapsedAction = UIAlertAction(title: "Restart Elapsed Time", style: .default) { [unowned self] (action) in
 self.workout.elapsedSeconds = 0
 self.updateTimeLabels()
 }
 
 let allAction = UIAlertAction(title: "Restart Interval & Elapsed Time", style: .default) { [unowned self] (action) in
 self.workout.restart(mode: self.workout.currentMode)
 self.workout.elapsedSeconds = 0
 self.updateTimeLabels()
 }
 
 let workoutAction = UIAlertAction(title: "Restart Workout", style: .default) { (action) in
 self.workout.startSession()
 if data.isRunWalk {
 self.workout.restart(mode: .run)
 } else {
 self.workout.restart(mode: .walk)
 }
 self.timerWindowView.reset(interval: true, session: true)
 }
 
 let endWOAction = UIAlertAction(title: "End Workout", style: .default) { (action) in
 self.workout.woSession!.remainingSeconds = 0
 self.workout.complete()
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
 
 func loadMusicControls() {
 if let mc = Bundle.main.loadNibNamed("MusicControls", owner: self, options: nil)?.first as? MusicControls {
 self.musicControls = mc
 self.musicControls.delegate = self
 mc.frame = buttonBar.frame
 mc.isHidden = true
 view.addSubview(mc)
 }
 }
 
 func showMusicControls() {
 musicControls.frame.origin.x = view.frame.width
 musicControls.isHidden = false
 
 UIView.animate(withDuration: 0.25) {
 self.buttonBar.alpha = 0.0
 }
 
 UIView.animate(withDuration: 0.75, delay: 0.2, usingSpringWithDamping: 0.6, initialSpringVelocity: 0.4, options: [], animations: {
 self.musicControls.frame.origin.x = 0
 }) { (success) in
 
 }
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
 updateTimeLabels()
 }
 
 func workoutTick(with percent: CGFloat) {
 updateTimeLabels()
 }
 
 func modeUpdate(){
 timerWindowView.mode = workout.currentMode
 if workout.timer != nil {
 let intervalSecs = workout.currentInterval.lengthInSeconds
 timerWindowView.beginClocks(intervalSeconds: intervalSecs, sessionSeconds: nil)
 }
 }
 
 func percentComplete(pct: CGFloat) {
 
 }
 }
 
 extension TimerViewController: MusicControlDelegate {
 func hideMusicControls() {
 UIView.animate(withDuration: 0.5, animations: {
 self.musicControls.frame.origin.x = self.view.frame.width
 self.buttonBar.alpha = 1
 }) { (success) in
 self.musicControls.isHidden = true
 }
 }
 }
 
 
 
 
 

 */
