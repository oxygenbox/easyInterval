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
    - value from Data
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
 */

import UIKit
import QuartzCore

class MainViewController: UIViewController, WorkoutDelegate {
    
    //MARK:- IBOUTLET
    @IBOutlet weak var intervalTime: UILabel!
    @IBOutlet weak var elapsedTime: UILabel!
    @IBOutlet weak var modeLabel: UILabel!
    
    @IBOutlet weak var infoButton: UIBarButtonItem!
    @IBOutlet weak var audioButton: UIBarButtonItem!
    @IBOutlet weak var vibrateButton: UIBarButtonItem!
    @IBOutlet weak var cadenceButton: UIBarButtonItem!
    @IBOutlet weak var musicButton: UIBarButtonItem!
    @IBOutlet weak var workoutButton: UIBarButtonItem!
    
    //MARK -  Variable
    var workout = Workout()
    
    //MARK -  LifeCycle
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setUp()
        initInterface()
        initGestures()
        initWorkout()
        view.backgroundColor = UIColor.myBlue
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

   //MARK: METHODS
    //-------
    func setUp() {
        title = data.settingTitle
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Settings", style: .plain, target: self, action: #selector(settingTapped))
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Reset", style: .plain, target: self, action: #selector(resetTapped))
        
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "Main", style: .plain, target: nil, action: nil)
    }
    
    func initInterface() {
        audioButton.isEnabled = data.audioOn
        vibrateButton.isEnabled = data.vibrateOn
        cadenceButton.isEnabled = data.cadenceOn
        musicButton.isEnabled = data.musicOn
        workoutButton.isEnabled = data.workoutOn
        
        
    }
    
    func initWorkout() {
        workout.delegate = self
        postTimes()
        modeLabel.text = workout.currentMode.name.uppercased()
      //  intervalTime.text = workout.intervalSeconds()
    }
    
    func toggleSession() {
        workout.toggleTimer()
    }
    
    //MARK: - Gestures
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
    
    
    func settingTapped() {
        if let vc = storyboard?.instantiateViewController(withIdentifier: "Settings") as? SettingsViewController {
            self.navigationController?.pushViewController(vc, animated: true)
            self.modeUpdate()
        }
    }
    
    func postTimes() {
        intervalTime.text = Tool.formatTime(secs: workout.currentInterval.remainingSeconds, withHours: false)
        elapsedTime.text = Tool.formatTime(secs: workout.elapsedSeconds, withHours: true)
        
        intervalTime.textColor = UIColor.white
        intervalTime.backgroundColor = UIColor.black
        
        
        
        self.modeUpdate()
    }
    
    
    //reset alert functions
    func resetTapped() {
        let ac = UIAlertController(title: nil, message: nil, preferredStyle: .alert)
        let runAction = UIAlertAction(title: "Restart Run Interval", style: .default) { [unowned self] (action) in
            self.workout.restart(mode: .run)
        }
        
        let walkAction = UIAlertAction(title: "Restart Walk Interval", style: .default) { [unowned self] (action) in
           self.workout.restart(mode: .walk)
        }
        
        let elapsedAction = UIAlertAction(title: "Restart Elapsed Time", style: .default) { [unowned self] (action) in
            self.workout.elapsedSeconds = 0
        }
        
        let allAction = UIAlertAction(title: "Restart Interval & Elapsed Time", style: .default) { [unowned self] (action) in
             self.workout.restart(mode: self.workout.currentMode)
            self.workout.elapsedSeconds = 0
        }
        
        let workoutAction = UIAlertAction(title: "Restart Workout", style: .default) { (action) in
            
        }
        
        let endWOAction = UIAlertAction(title: "End Workout", style: .default) { (action) in
            
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
    
    //MARK:- WorkoutDelegate Methods
    func woTick() {
        postTimes()
    }
    
    func percentComplete(pct: CGFloat) {
        //print(1 - pct)
    }
    
    func modeUpdate() {
        modeLabel.text = workout.currentMode.name.uppercased()
    }
    
    func test() {
    //QuartzCorw
        let color = UIColor.red
        intervalTime.textColor = color
        intervalTime.layer.shadowColor = color.cgColor
        intervalTime.layer.shadowRadius = 4.0 / 2
        intervalTime.layer.shadowOpacity = 0.9
        intervalTime.layer.shadowOffset = CGSize.zero
        intervalTime.layer.masksToBounds = false
        
    }
    
    func testA() {
        //QuartzCorw
        let color = UIColor.black
        intervalTime.textColor = UIColor.darkGray
        intervalTime.layer.shadowColor = color.cgColor
        intervalTime.layer.shadowRadius = 4.0 / 4
        intervalTime.layer.shadowOpacity = 1.0
        intervalTime.layer.shadowOffset = CGSize(width: 1, height: -1)
        intervalTime.layer.masksToBounds = false
        
    }
    
    func testB() {
        //QuartzCorw
        let color = UIColor.white
        intervalTime.textColor = UIColor.lightGray
        intervalTime.layer.shadowColor = color.cgColor
        intervalTime.layer.shadowRadius = 4.0 / 4
        intervalTime.layer.shadowOpacity = 1.0
        intervalTime.layer.shadowOffset = CGSize(width: 1, height: -1)
        intervalTime.layer.masksToBounds = false
        
    }
    
    func testC() {
        //QuartzCorw
        let color = UIColor.black
        intervalTime.textColor = UIColor.darkGray
        intervalTime.layer.shadowColor = color.cgColor
        intervalTime.layer.shadowRadius = 4.0 / 4
        intervalTime.layer.shadowOpacity = 1.0
        intervalTime.layer.shadowOffset = CGSize(width: -1, height: 1)
        intervalTime.layer.masksToBounds = false
        
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
}



/*
 
 IColor *color = button.currentTitleColor;
 button.titleLabel.layer.shadowColor = [color CGColor];
 button.titleLabel.layer.shadowRadius = 4.0f;
 button.titleLabel.layer.shadowOpacity = .9;
 button.titleLabel.layer.shadowOffset = CGSizeZero;
 button.titleLabel.layer.masksToBounds = NO;
 
 
 
 
 let attrs = [NSForegroundColorAttributeName: UIColor.red,
 NSFontAttributeName: UIFont(name: "Georgia-Bold", size: 24)!,
 NSTextEffectAttributeName: NSTextEffectLetterpressStyle as NSString
 ]
 
 let string = NSAttributedString(string: "Hello, world!", attributes: attrs)
 yourLabel.attributedText = string
 */














