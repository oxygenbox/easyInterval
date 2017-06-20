//
//  MainViewController.swift
//  easyIntervals
//
//  Created by Michael Schaffner on 6/17/17.
//  Copyright © 2017 Michael Schaffner. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {
    
    enum resetType {
        case run
        case walk
        case elapsed
        case all
        case session
    }
    
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
    @IBOutlet weak var buttonBar: ButtonView!

    @IBOutlet weak var leftWindow: RoundModeView!
    @IBOutlet weak var rightWindow: RoundModeView!
    @IBOutlet weak var countDownView: CountDownView!
    
    @IBOutlet weak var intervalTime: UILabel!
    
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
    
    var activeWindow: RoundModeView {
        if workout.currentMode == .run {
            return self.runWindow
        } else {
            return self.walkWindow
        }
    }

    //MARK:- LIFECYCLE
    override func viewDidLoad() {
        super.viewDidLoad()
        loadMusicControls()
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
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        if let preferenceVC = storyboard.instantiateViewController(withIdentifier: "Preferences") as? PreferenceViewController {
            preferenceVC.modalTransitionStyle = .crossDissolve
            self.present(preferenceVC, animated: true)
        }
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
        view.backgroundColor = UIColor.Theme.back
        titleLabel.attributedText = data.formattedTitle
        initGestures()
        configureButtons()
        
        runWindow.mode = .run
        walkWindow.mode = .walk
        
        
        
        // elapsedTime.textColor = UIColor.Theme.base
        // sessionType.textColor = UIColor.Theme.base
        
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
        workout = Workout()
        workout.delegate = self
        modeUpdate()
    }
    
    func toggleWorkout() {
        workout.toggleTimer()
       
        
        if workout.timer == nil {
            settingsButton.isEnabled = true
            activeWindow.pause()
        } else {
            settingsButton.isEnabled = false
            if activeWindow.intervalClock.hasStarted {
                //resume
                activeWindow.intervalClock.resume()
            } else {
                //start
                setScreenMode()
                if workout.woSession != nil {
                    //start session timer
                   // let sessionSecs = data.totalSessionSeconds
                }
                
            
                
            }
        }
        
        
        //playing
        //pause
        //resume
        //hasStarted
    }
    
    /*
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
     
     }
     timerWindowView.beginClocks(intervalSeconds: intervalSecs, sessionSeconds: sessionSecs)
     }
     settingsButton.isEnabled = false
     }
     }
 */
    
    func setScreenMode() {
        let intervalSecs = workout.currentInterval.lengthInSeconds
        switch workout.currentMode {
        case .run:
            runWindow.grow()
            walkWindow.shrink()
            //runWindow.alpha =  1
           // walkWindow.alpha =  0
            runWindow.beginClock(intervalSeconds: intervalSecs)
        case .walk:
            walkWindow.grow()
            runWindow.shrink()
            //walkWindow.alpha = 1
            //runWindow.alpha = 0
            walkWindow.beginClock(intervalSeconds: intervalSecs)
        default:
            break
        }
    }
    
    
    
    func postTimes() {
        intervalTime.attributedText = Tool.intervalTimeFormatted(seconds: workout.currentInterval.remainingSeconds)
    }
    
    func  openResetOptions() {
        let ac = UIAlertController(title: nil, message: nil, preferredStyle: .alert)
        
        let runAction = UIAlertAction(title: "Restart Run Interval", style: .default) { [unowned self] (action) in
            self.reset(type: .run)
            //self.timerWindowView.reset(interval: true, session: false)
        }
        
        let walkAction = UIAlertAction(title: "", style: .default) { [unowned self] (action) in
            self.reset(type: .walk)
            //self.timerWindowView.reset(interval: true, session: false)
        }
        
        let elapsedAction = UIAlertAction(title: "Restart Elapsed Time", style: .default) { [unowned self] (action) in
            self.reset(type: .elapsed)
        }

        
        let allAction = UIAlertAction(title: "Restart Interval & Elapsed Time", style: .default) { [unowned self] (action) in
            self.reset(type: .all)
        }
        
        let workoutAction = UIAlertAction(title: "Restart Workout", style: .default) { [unowned self] (action) in
            self.reset(type: .session)
            //self.timerWindowView.reset(interval: true, session: true)
        }
        
        let endWorkoutAction = UIAlertAction(title: "End Workout", style: .default) { [unowned self] (action) in
            self.workout.woSession!.remainingSeconds = 0
            self.workout.complete()
        }

        if data.workoutOn {
            ac.addAction(runAction)
            ac.addAction(walkAction)
            ac.addAction(elapsedAction)
            ac.addAction(allAction)
        } else {
            ac.addAction(workoutAction)
            ac.addAction(endWorkoutAction)
        }
        
        ac.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        
        present(ac, animated: true)
    }
    
    func reset(type: resetType) {
        switch type {
        case .run:
            self.workout.restart(mode: .run)
        case .walk:
            self.workout.restart(mode: .walk)
        case .elapsed:
            self.workout.elapsedSeconds = 0
        case .all:
            self.workout.restart(mode: self.workout.currentMode)
            self.workout.elapsedSeconds = 0
        case.session:
            self.workout.startSession()
            if data.isRunWalk {
                self.workout.restart(mode: .run)
            } else {
                self.workout.restart(mode: .walk)
            }
        }
        // self.updateTimeLabels()
    }
    
   //MARK:- MUSIC METHODS
    func loadMusicControls() {
        if let mc = Bundle.main.loadNibNamed("MusicControls", owner: self, options: nil)?.first as? MusicControls {
            self.musicControls = mc
            self.musicControls.delegate = self
            mc.frame = buttonBar.frame
            mc.isHidden = true
            view.addSubview(mc)
        }
    }
    
    func openMusicControls() {
        musicControls.frame.origin.x = view.frame.width
        musicControls.isHidden = false
        let fadeAnimator = UIViewPropertyAnimator(duration: 0.25, curve: .linear) {
            self.buttonBar.alpha = 0.0
        }
        
        let animator = UIViewPropertyAnimator(duration: 0.75, dampingRatio: 0.6) { 
            self.musicControls.frame.origin.x = 0
        }
        
        fadeAnimator.startAnimation()
        animator.startAnimation()
    }

    //MARK: - GESTURES
    func initGestures() {
        let twoFingerTap = UITapGestureRecognizer(target: self, action: #selector(twoFingerTapDetected(_:)))
        twoFingerTap.numberOfTapsRequired = 1
        twoFingerTap.numberOfTouchesRequired = 2
        view.addGestureRecognizer(twoFingerTap)
        let swipeRecognizer = UISwipeGestureRecognizer(target: self, action: #selector(swipeDetected(_:)))
        view.addGestureRecognizer(swipeRecognizer)

    }
    
    func twoFingerTapDetected(_ sender: UIGestureRecognizer){
        toggleWorkout()
    }
    
    func swipeDetected(_ sender: UIGestureRecognizer){
    //need to insert music control
    }
}

 //MARK:- EXTENSIONS
extension MainViewController: MusicControlDelegate {
    func hideMusicControls() {
        let animator = UIViewPropertyAnimator(duration: 0.5, curve: .easeInOut) { 
            self.musicControls.frame.origin.x = self.view.frame.width
            self.buttonBar.alpha = 1
        }
        
        animator.addCompletion { (position) in
            self.musicControls.isHidden = true
        }
        
        animator.startAnimation()
    }
}


extension MainViewController: WorkoutDelegate {
    func woTick() {
        print("woTick")
        postTimes()
        
    }
        
    func workoutTick(remaining seconds: Int) {
        postTimes()
        
        if workout.currentInterval.countDown {
            self.countDownView.countDown(second: seconds)
            
        }
    }
        
    func  modeUpdate() {
        print("modeUpdate called")
//        switch workout.currentMode {
//            case .run:
//                self.runWindow.isHidden = false
//                self.walkWindow.isHidden = true
//            case .walk:
//                self.walkWindow.isHidden = false
//                self.runWindow.isHidden = true
//            default:
//                break
//        }
        
//        timerWindowView.mode = workout.currentMode
//        if workout.timer != nil {
//            let intervalSecs = workout.currentInterval.lengthInSeconds
//            timerWindowView.beginClocks(intervalSeconds: intervalSecs, sessionSeconds: nil)
//        }
        postTimes()
    }
    
    func modeChanged(to mode: Mode) {
        setScreenMode()
    }
    
}




/*
 
 



 
 @IBOutlet var prefButtons: [UIButton]!
 
 //MARK - VARIABLES
 

 

 }
 
 func updateTimeLabels() {
 
 
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
