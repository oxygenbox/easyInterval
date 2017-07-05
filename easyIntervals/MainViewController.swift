//
//  MainViewController.swift
//  easyIntervals
//
//  Created by Michael Schaffner on 6/17/17.
//  Copyright © 2017 Michael Schaffner. All rights reserved.
//

import UIKit
import MediaPlayer

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
    var instructionView: InstructionView!
    
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
    
    lazy var sessionClock: SessionClockView = {
        let dim = self.countDownView.frame.size.height
        return SessionClockView(frame: CGRect(x: 0, y: 0, width: dim, height: dim))
    }()
    
    lazy var musicPlayer: MPMusicPlayerController = {
        let player = MPMusicPlayerController.systemMusicPlayer()
        let everyThing = MPMediaQuery()
        let itemsFromGenericQuery = everyThing.items
        player.setQueue(with: everyThing)
        player.shuffleMode = MPMusicShuffleMode.songs
        return player
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
    
        countDownView.insertSubview(sessionClock, at: 0)
        sessionClock.center.x = countDownView.frame.width/2
        sessionClock.center.x = view.center.x
        sessionClock.isHidden = !data.workoutOn
        
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
        instructionView.toggle()
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
        titleLabel.attributedText = data.colorizedTitle
        initGestures()
        configureButtons()
        
        runWindow.mode = .run
        walkWindow.mode = .walk
        loadInstructions()
        
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
            //intervalWindow.intervalClock.alpha = 0.3
            if data.workoutOn {
                self.sessionClock.pause()
            }
        } else {
            settingsButton.isEnabled = false
            if intervalWindow.intervalClock.hasStarted {
                //resume
                intervalWindow.resumeIntervalClock()
                //intervalWindow.intervalClock.alpha = 1
                
                if data.workoutOn {
                    self.sessionClock.resume()
                }
                
            } else {
                //start
                setScreenMode()
                
                guard let session = workout.woSession else {
                    return
                }
                
                if session.complete {
                    reset(type: .session)
                    session.remainingSeconds = session.totalSeconds
                    session.elapsedSeconds = 0
                }
                
                self.sessionClock.beginClock(intervalSeconds: data.totalSessionSeconds)
               
            }
        }
    }
    
    func setScreenMode() {
        let intervalSecs = workout.currentInterval.lengthInSeconds
        switch workout.currentMode {
        case .run:
            runWindow.statusOff()
            walkWindow.statusOn()
            if workout.timer != nil {
                walkWindow.beginIntervalClock(intervalSeconds: intervalSecs)
            } else {
                walkWindow.intervalView.clock.reset()

        }
        case .walk:
            walkWindow.statusOff()
            runWindow.statusOn()
            if workout.timer != nil {
                runWindow.beginIntervalClock(intervalSeconds: intervalSecs)
            } else {
                runWindow.intervalView.clock.reset()
            }
        default:
            break
        }
        postTimes()
    }
    
    
    func screenCompleteMode() {
//        if workout.currentMode == .run {
//            walkWindow.intervalView.label.text = "complete"
//            runWindow.imageView.image = UIImage(named: "finishFlag")
//            walkWindow.statusOn()
//            runWindow.statusOff()
//        } else {
//            runWindow.intervalView.label.text = "complete"
//            walkWindow.imageView.image = UIImage(named: "finishFlag")
//            runWindow.statusOn()
//            walkWindow.statusOff()
//            
//        }
        print("screenCompleteMode")
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
        
        shadow.shadowOffset = CGSize(width: -1, height: 1)
        shadow.shadowBlurRadius = 1
        
        
        shadow.shadowColor = UIColor.bush
        
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
            self.intervalWindow.pauseIntervalClock()
            self.sessionClock.pause()
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
            self.sessionClock.reset()
            if data.isRunWalk {
                self.workout.restart(mode: .run)
            } else {
                self.workout.restart(mode: .walk)
            }
            self.setScreenMode()
        }
        
        postTimes()
    }
    
    func loadInstructions() {
        if let iv = Bundle.main.loadNibNamed("InstructionView", owner: self, options: nil)?.first as? InstructionView {
            
            
            self.instructionView = iv
            
            let dim: CGFloat = 256 //self.view.frame.size.width*0.8
            iv.frame = CGRect(x: 0, y: 0, width: dim, height: dim)
            //iv.frame = rightWindow.frame
           
            let x = self.view.frame.size.width/2
            let y = topView.frame.origin.y + topView.frame.size.height
            iv.center.x = x
            iv.frame.origin.y = y
           

            view.addSubview(iv)
            iv.isHidden = true
        }
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
        hideInstructions()
        hideCompletion()
        toggleWorkout()
    }
    
    func swipeDetected(_ sender: UIGestureRecognizer){
        if data.musicOn {
            musicControls.toggleMusic()
        }
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
    
    func openMediaPicker() {
        
        MPMediaLibrary.requestAuthorization { (status) in
            if status == .authorized {
                let mediaPicker = MPMediaPickerController(mediaTypes: .any)
                mediaPicker.delegate = self
                mediaPicker.allowsPickingMultipleItems = true
                mediaPicker.prompt = "Pick songs to play"
                self.present(mediaPicker, animated: true, completion: nil)
            } else {
                displayMediaLibraryError()
            }
        }
        
        func displayMediaLibraryError() {
            var error: String
            switch MPMediaLibrary.authorizationStatus() {
            case .restricted:
                error = "Media library access restricted by corporate or parental settings"
            case .denied:
                error = "Media library access denied, this can be changes in system settings"
            default:
                error = "Unknown error"
            }
            
            let controller = UIAlertController(title: "Error", message: error, preferredStyle: .alert)
            controller.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            present(controller, animated: true, completion: nil)
        }
       
    }
}


extension MainViewController: WorkoutDelegate {
    func woTick() {
        postTimes()
        
    }
        
    func workoutTick(remaining seconds: Int) {
        postTimes()
        
        if workout.currentInterval.countDown {
            self.countDownView.countDown(second: seconds)
            
        }
    }
        
    func  modeUpdate() {
        
    }
    
    func modeChanged(to mode: Mode) {
        setScreenMode()
    }
    
    func hideCompletion() {
        if !rightWindow.completeView.isHidden {
            rightWindow.completeView.hide(animated: true)
            leftWindow.completeView.hide(animated: true)
        }
    }
    
    func hideInstructions() {
        if !instructionView.isHidden {
            instructionView.toggle()
        }
    }
    
    func sessionComplete() {
        rightWindow.completeView.show(animated: true)
        leftWindow.completeView.show(animated: true)
       
    }
    
}

//MARK:- MediaPicker Celegate
extension MainViewController: MPMediaPickerControllerDelegate {
    func mediaPicker(_ mediaPicker: MPMediaPickerController, didPickMediaItems mediaItemCollection: MPMediaItemCollection) {
        
        
        mediaPicker.dismiss(animated: true, completion: nil)
    }
    
    func mediaPickerDidCancel(_ mediaPicker: MPMediaPickerController) {
        mediaPicker.dismiss(animated: true, completion: nil)
    }
}


/*
 
 extension CenterViewController: MPMediaPickerControllerDelegate {
 func mediaPicker(_ mediaPicker: MPMediaPickerController, didPickMediaItems mediaItemCollection: MPMediaItemCollection) {
 /*
 let mc = mediaItemCollection
 musicPlayer.setQueue(with: mc)
 playMusic()
 
 //mediaPicker.dismissViewControllerAnimated(true, completion: nil)
 
 mediaPicker.dismiss(animated: true) {
 self.runnerSequenceView.restartAnimation(self)
 }
 */
 }
 
 

 */









