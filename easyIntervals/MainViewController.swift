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
    @IBOutlet weak var elapsedTime: UILabel!
    
    @IBOutlet weak var topView: UIView!
    
    @IBOutlet weak var labelStack: UIStackView!
    
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
    
    var intervalWindow: RoundModeView {
        if workout.currentMode == .run {
            return self.walkWindow
        } else {
            return self.runWindow
        }
    }
    
    lazy var sessionClock: ClockView = {
        
        let dim: CGFloat = self.countDownView.frame.height
        let x = self.view.frame.width/2 - dim/2
        let clock = ClockView(frame: CGRect(x: 0, y: 0, width: dim, height: dim))
        
        clock.backgroundColor = UIColor.white
        clock.layer.cornerRadius = dim/2
        clock.clipsToBounds = true
        
        
        return clock
        
    }()
    
    //MARK:- LIFECYCLE
    override func viewDidLoad() {
        super.viewDidLoad()
        loadMusicControls()
        configure()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        configure()
        initWorkout()
        postTimes()
      
       // countDownView.addSubview(sessionClock)
    
        countDownView.insertSubview(sessionClock, at: 0)
        sessionClock.center.x = countDownView.frame.width/2
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
        view.backgroundColor = UIColor.background
        titleLabel.attributedText = data.formattedTitle
        initGestures()
        configureButtons()
        
        runWindow.mode = .run
        walkWindow.mode = .walk
        
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
        
        cadenceButton.interactive = data.cadenceOn
        musicButton.interactive = data.musicOn
        
        infoButton.makeInfo()
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
            intervalWindow.pause()
            intervalWindow.pauseIntervalClock()
            intervalWindow.intervalClock.alpha = 0.3
        } else {
            settingsButton.isEnabled = false
            if intervalWindow.intervalClock.hasStarted {
                //resume
                intervalWindow.resumeIntervalClock()
                intervalWindow.intervalClock.alpha = 1
            } else {
                //start
                setScreenMode()
                if workout.woSession != nil {
                    sessionClock.shapeLayer.strokeColor = UIColor.red.cgColor
                    sessionClock.shapeLayer.lineWidth = sessionClock.frame.size.width * 0.92 //- 12
                    
                    
                    sessionClock.begin(with: data.totalSessionSeconds)
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
    
    func setScreenMode() {
        let intervalSecs = workout.currentInterval.lengthInSeconds
        switch workout.currentMode {
        case .run:
            runWindow.statusOff()
            walkWindow.statusOn()
            walkWindow.beginIntervalClock(intervalSeconds: intervalSecs)
        case .walk:
            walkWindow.statusOff()
            runWindow.statusOn()
            runWindow.beginIntervalClock(intervalSeconds: intervalSecs)
        default:
            break
        }
        postTimes()
    }
    
    
    
    func postTimes() {
        
        let intervalText = Tool.intervalTimeFormatted(seconds: workout.currentInterval.remainingSeconds)
        
        var textColor = UIColor.run
        
        var elapsedText = Tool.elapsedTimeFormatted(seconds: workout.elapsedSeconds)
        if let session = workout.woSession {
             elapsedText = Tool.elapsedTimeFormatted(seconds: session.remainingSeconds)
        }
        
        
        if workout.currentMode == .walk {
            textColor = UIColor.walk
        }
        
        let shadow = NSShadow()
        shadow.shadowOffset = CGSize(width: 3, height: 3)
        shadow.shadowBlurRadius = 3
        shadow.shadowColor = UIColor.black
        
        intervalText.addAttribute(NSForegroundColorAttributeName, value: textColor, range: NSMakeRange(0, intervalText.length))
        elapsedText.addAttribute(NSForegroundColorAttributeName, value: textColor, range: NSMakeRange(0, elapsedText.length))
        
        intervalText.addAttribute(NSShadowAttributeName, value: shadow, range: NSMakeRange(0, intervalText.length))
        
 
        intervalTime.attributedText = intervalText
        elapsedTime.attributedText = elapsedText
        
    }
    
    func  openResetOptions() {
        let ac = UIAlertController(title: nil, message: nil, preferredStyle: .alert)
        
        let runAction = UIAlertAction(title: "Restart Run Interval", style: .default) { [unowned self] (action) in
            self.reset(type: .run)
            //self.timerWindowView.reset(interval: true, session: false)
        }
        
        let walkAction = UIAlertAction(title: "Restart Walk Interval", style: .default) { [unowned self] (action) in
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

        if !data.workoutOn {
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
            self.setScreenMode()
        case .walk:
            self.workout.restart(mode: .walk)
            self.setScreenMode()
        case .elapsed:
            self.workout.elapsedSeconds = 0
        case .all:
            self.workout.restart(mode: self.workout.currentMode)
            self.workout.elapsedSeconds = 0
            self.setScreenMode()
        case.session:
            self.workout.startSession()
            if data.isRunWalk {
                self.workout.restart(mode: .run)
            } else {
                self.workout.restart(mode: .walk)
            }
            self.setScreenMode()
        }
        
        postTimes()
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
        musicControls.frame = buttonBar.frame
        musicControls.frame.origin.x = view.frame.width
        
        musicControls.frame.origin.y = view.frame.height - musicControls.frame.height
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
        //print("modeUpdate called")
       // postTimes()
    }
    
    func modeChanged(to mode: Mode) {
        setScreenMode()
    }
    
}



