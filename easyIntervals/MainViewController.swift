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
    
    
    lazy var instructionView: InstructionView = {
        let iv = Bundle.main.loadNibNamed("InstructionView", owner: self, options: nil)?.first as! InstructionView
        let dim: CGFloat = 256 //self.view.frame.size.width*0.8
        iv.frame = CGRect(x: 0, y: 0, width: dim, height: dim)
        
        let x = self.view.frame.size.width/2
        let y = self.topView.frame.origin.y + self.topView.frame.size.height + 0
    
        iv.center.x = x
        iv.frame.origin.y = y
        self.view.addSubview(iv)
        iv.isHidden = true
        return iv
    }()
    
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
    
    //MARK:- LIFECYCLE
    override func viewDidLoad() {
        super.viewDidLoad()
        loadMusicControls()
         addSessionClock()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        configure()
        initWorkout()
        postTimes()
       
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        sessionClock.center.x = countDownView.center.x
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    //MARK- IBACTIONS
    @IBAction func settingsTapped(_ sender: UIButton) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        data.workout = workout
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
        
        let session = AVAudioSession.sharedInstance()
        do {
             try session.setCategory(AVAudioSessionCategoryPlayback, with: .duckOthers)
        } catch {
            print("Cant set audio category")
        }
        
        do {
            try session.setActive(true)
        } catch  {
            print("Cant set audio active")
        }
        
        view.backgroundColor = UIColor.packLight
        topView.backgroundColor = UIColor.packLight
        let topGap = UIView(frame: CGRect(x: 0, y: topView.bounds.height, width: view.bounds.width, height: 1))
        topGap.backgroundColor = UIColor.white
        topView.addSubview(topGap)
        
        let botGap = UIView(frame: CGRect(x: 0, y: 0, width: view.bounds.width, height: 1))
        botGap.backgroundColor = UIColor.white
        buttonBar.addSubview(botGap)
        
        buttonBar.backgroundColor = UIColor.packDark
        
        titleLabel.attributedText = data.colorizedTitle
        initGestures()
        configureButtons()
        
        runWindow.mode = .run
        walkWindow.mode = .walk
       
        defaultInstructions()
        addGradient()
        
        sessionClock.isHidden = !data.workoutOn
        sessionClock.center.x = countDownView.center.x
        
    }
    
    func defaultInstructions() {
        
        if data.firstVisit {
            instructionView.show()
        }
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
        
        data.state = State(runValue: data.runValue, walkValue: data.walkValue, sessionOn: data.workoutOn, isRunWalk: data.isRunWalk)
        
        
        
        if let wo = data.workout {
            workout = wo
            data.workout = nil
        } else {
            workout = Workout()
            workout.delegate = self
        }
        
        modeUpdate()
    }
    
    func toggleWorkout() {
        
        switch workout.state {
            case .stopped:
                setScreenMode()
                
                if let session = workout.woSession {
                    if session.complete {
                        reset(type: .session)
                        session.remainingSeconds = session.totalSeconds
                        session.elapsedSeconds = 0
                    }
            
                    self.sessionClock.beginClock(intervalSeconds: data.totalSessionSeconds)
                    
                }
            
                settingsButton.isEnabled = false
                settingsButton.alpha = 0.5
                playMusic()
                
        case .paused:
            settingsButton.isEnabled = false
            settingsButton.alpha = 0.5
            intervalWindow.resumeIntervalClock()
            
         
            if data.workoutOn {
                self.sessionClock.resume()
            }
            
            playMusic()

        case .playing:
            settingsButton.isEnabled = true
            settingsButton.alpha = 1
            intervalWindow.pauseIntervalClock()
            if data.workoutOn {
                self.sessionClock.pause()
            }
            
            pauseMusic()
            
        default:
            break
        }
        
        workout.toggleTimer()
       // setBackground()
       
        
    }
    
    func setScreenMode() {
        let intervalSecs = workout.currentInterval.lengthInSeconds
        
        switch workout.currentMode {
        case .run:
            runWindow.statusOff()
            walkWindow.statusOn()
            
            if workout.state == .stopped || !workout.isPaused {
                walkWindow.beginIntervalClock(intervalSeconds: intervalSecs)
            } else {
                walkWindow.intervalView.clock.reset()

        }
        case .walk:
            walkWindow.statusOff()
            runWindow.statusOn()
            if workout.state == .stopped || !workout.isPaused {
                runWindow.beginIntervalClock(intervalSeconds: intervalSecs)
            } else {
                runWindow.intervalView.clock.reset()
            }
        default:
            break
        }
        postTimes()
    }
    
    func addSessionClock() {
        countDownView.insertSubview(sessionClock, at: 0)
        
        //sessionClock.frame.origin.x = countDownView.frame.size.width/2 - sessionClock.frame.size.width/2
        //sessionClock.frame.origin.x = view.bounds.width/2 - sessionClock.frame.size.width/2
       // sessionClock.center.x = countDownView.center.x
        countDownView.backgroundColor = UIColor.white
        sessionClock.isHidden = !data.workoutOn
        
        
       // let test = UIView(frame: CGRect(x: 0, y: 0, width: 20, height: 200))
        ////test.center.x = countDownView.center.x
       // test.backgroundColor = UIColor.yellow
        //countDownView.addSubview(test)
        
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
        
        
        textColor = UIColor.white
        shadow.shadowColor = UIColor.packDark
        
        intervalText.addAttribute(NSForegroundColorAttributeName, value: textColor, range: NSMakeRange(0, intervalText.length))
        elapsedText.addAttribute(NSForegroundColorAttributeName, value: textColor, range: NSMakeRange(0, elapsedText.length))
        
        intervalText.addAttribute(NSShadowAttributeName, value: shadow, range: NSMakeRange(0, intervalText.length))
        elapsedText.addAttribute(NSShadowAttributeName, value: shadow, range: NSMakeRange(0, elapsedText.length))
 
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
            //self.sessionClock.reset()
            if data.isRunWalk {
                self.workout.restart(mode: .run)
            } else {
                self.workout.restart(mode: .walk)
            }
            
            if workout.state == .paused {
                workout.timer = nil
                workout.state = .stopped
                //intervalWindow.imageView.frame.origin.y = 0
                //intervalWindow.statusOff()
                runWindow.statusOff()
                walkWindow.statusOff()
            } else {
                setScreenMode()
                self.sessionClock.reset()
                
                workout.speak(word: "start")
            }
        }
        
        postTimes()
    }
    
   //MARK:- MUSIC METHODS
    
    func playMusic() {
        if data.musicOn {
        
            switch MPMediaLibrary.authorizationStatus() {
            case .notDetermined:
                MPMediaLibrary.requestAuthorization({(newPermissionStatus: MPMediaLibraryAuthorizationStatus) in
                    if newPermissionStatus == .authorized {
                        self.musicControls.playMusic()
                    }
                })
            case .denied, .restricted:
                break
            default:
                musicControls.playMusic()
            }
 
        }
    }
    
    func pauseMusic() {
        if data.musicOn {
            musicControls.pauseMusic()
        }
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
    
    func openMusicControls() {
        musicControls.frame = buttonBar.frame
        musicControls.frame.origin.x = view.frame.width
        musicControls.frame.origin.x = -musicControls.frame.size.width
        
        musicControls.frame.origin.y = view.frame.height - musicControls.frame.height
        musicControls.isHidden = false
        let fadeAnimator = UIViewPropertyAnimator(duration: 0.25, curve: .linear) {
            self.buttonBar.alpha = 0.0
        }
        
        let animator = UIViewPropertyAnimator(duration: 0.75, dampingRatio: 0.6) { 
            self.musicControls.frame.origin.x = 0
        }
        
        animator.addCompletion { (animation) in
            
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
        //let swipeRecognizer = UISwipeGestureRecognizer(target: self, action: #selector(swipeDetected(_:)))
        //view.addGestureRecognizer(swipeRecognizer)

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
                let mediaPicker = MPMediaPickerController(mediaTypes: .music)
                mediaPicker.delegate = self
                mediaPicker.allowsPickingMultipleItems = true
                mediaPicker.prompt = "Pick songs to play"
                self.present(mediaPicker, animated: true, completion: nil)
            } else {
                self.displayMediaLibraryError()
            }
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
    
    func addGradient() {
        let gradientLayer = CAGradientLayer()
        let offset: CGFloat = 80
        var h = view.bounds.height
        h -= buttonBar.bounds.height
        h -= offset
        let w = view.bounds.width
    
        gradientLayer.frame = CGRect(x: 0, y: offset, width: w, height: h)
        gradientLayer.colors = [UIColor.packLight.cgColor, UIColor.packDark.cgColor]
        gradientLayer.locations = [0,  1.0]
        self.view.layer.insertSublayer(gradientLayer, at: 0)
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
            data.firstVisit = false
            data.save()
        }
        
    }
    
    func sessionComplete() {
        workout.state = .complete
        rightWindow.completeView.show(animated: true)
        leftWindow.completeView.show(animated: true)
       
    }
}

//MARK:- MediaPicker Celegate
extension MainViewController: MPMediaPickerControllerDelegate {
    func mediaPicker(_ mediaPicker: MPMediaPickerController, didPickMediaItems mediaItemCollection: MPMediaItemCollection) {
        let selectedSongs = mediaItemCollection
        musicControls.musicPlayer.setQueue(with: selectedSongs)
        musicControls.musicPlayer.play()
        
        mediaPicker.dismiss(animated: true, completion: nil)
    }
    
    func mediaPickerDidCancel(_ mediaPicker: MPMediaPickerController) {
        mediaPicker.dismiss(animated: true, completion: nil)
    }
}








