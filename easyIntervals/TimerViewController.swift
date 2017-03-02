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
    
    @IBOutlet weak var infoButton: UIButton!
    @IBOutlet weak var audioButton: UIButton!
    @IBOutlet weak var vibrateButton: UIButton!
    @IBOutlet weak var cadenceButton: UIButton!
    @IBOutlet weak var musicButton: UIButton!
    @IBOutlet weak var workoutButton: UIButton!
    
     @IBOutlet var prefButtons: [UIButton]!
    
    @IBOutlet weak var modeView: ModeView!
    
    //MARK -  VARIABLES
    var workout = Workout()
    
    
    //MARK:- LIFECYCLE
    //MARK -  LifeCycle
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setUp()
        initInterface()
        initGestures()
        initWorkout()
        view.backgroundColor = UIColor.base
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
        
        for button in prefButtons {
            button.backgroundColor = UIColor.blueC
        }
    }
    
    func initInterface() {
        audioButton.isEnabled = data.audioOn
        vibrateButton.isEnabled = data.vibrateOn
        cadenceButton.isEnabled = data.cadenceOn
        musicButton.isEnabled = data.musicOn
        workoutButton.isEnabled = data.workoutOn
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
        workout.toggleTimer()
        if(workout.timer == nil) {
            print("PAUSE")
            modeView.pause()
           // self.timerView.sink()
        } else {
            modeView.play()
          //  self.timerView.rise()
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
        print("swipe")
    }
    
}

//MARK:- EXTENSIONS
extension TimerViewController: WorkoutDelegate {
    func woTick(){
        postTimes()
    }

    func modeUpdate(){
        modeView.mode = workout.currentMode
    }

    func percentComplete(pct: CGFloat) {
        modeView.animateHead(pct: 1 - pct)
        modeView.elapsedTimer(percent: 1-pct)
        modeView.intervalTimer(percent: 1-pct)
        print(pct)
    }
}


/*
 
 //
 //  MainViewController.swift
 //  easyIntervals
 //
 //  Created by Michael Schaffner on 1/9/17.
 //  Copyright © 2017 Michael Schaffner. All rights reserved.
 //
 
 /*
 MainVC
 1. Access settings
 2. Respond to gestures
 3. Play audio
 4. Start/ Stop-Pause
 5. Reset/ Restart
 
 1. Display remaining seconds of current interval
 - value from Workout - remainingString
 2. Display current mode
 - value from Workout - modeString
 3. Display total elapsed time
 - value from Workout - intervalSeconds
 4. Display remaining woSession time
 - value from Session - sessionSeconds
 5. Display current settings (states)
 - value from Datatim
 6. Display progress - interval
 - value from Workout - pctInterval
 7. Display progress of woSession
 - value from session - pctSession
 8. Display info - help - instructions
 - value from ?
 9. Display countdown
 - Local
 
 Workout
 Session
 Data
 Settings
 
 //To do
 chec restart
 //stylize navigation bar
 add graphic swap
 look through graphics
 
 */

 
 func modeName() -> NSMutableAttributedString {
 let attributes =  [NSFontAttributeName: UIFont(name: "AvenirNext-DemiBold", size: 30.0)!]
 let mode = workout.currentMode.name.uppercased()
 let mutableString = NSMutableAttributedString(string: mode, attributes: attributes)
 return mutableString
 }
 }
 
 extension UIColor
 {
 public class var off: UIColor
 {
 return UIColor(red: 236/255, green: 44/255, blue: 8/255, alpha: 1.0)
 }
 
 public class var on: UIColor
 {
 return UIColor(red: 250/255, green: 179/255, blue: 0/255, alpha: 1.0)
 }
 
 public class var myBlue: UIColor
 {
 return UIColor(red: 5/255, green: 85/255, blue: 179/255, alpha: 1.0)
 }
 
 public class var base: UIColor {
 return UIColor.white
 }
 
 public class var accent: UIColor {
 return UIColor(red: 5/255, green: 85/255, blue: 179/255, alpha: 1.0)
 }
 
 public class var blueA: UIColor {
 return UIColor(red: 225/255, green: 252/255, blue: 255/255, alpha: 1.0)
 }
 
 public class var blueB: UIColor {
 return UIColor(red: 149/255, green: 252/255, blue: 242/255, alpha: 1.0)
 }
 
 public class var blueC: UIColor {
 return UIColor(red: 114/255, green: 184/255, blue: 253/255, alpha: 1.0)
 }
 
 public class var blueD: UIColor {
 return UIColor(red: 144/255, green: 153/255, blue: 216/255, alpha: 1.0)
 }
 }
 
 extension UIImageView {
 func tintImageColor(color : UIColor) {
 self.image = self.image!.withRenderingMode(UIImageRenderingMode.alwaysTemplate)
 self.tintColor = color
 }
 }
 
 
 
 
 
 
 
 
 
 
 
 
 
 

 
 
 */