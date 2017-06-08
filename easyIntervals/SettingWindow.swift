//
//  SettingWindow.swift
//  easyIntervals
//
//  Created by Michael Schaffner on 6/1/17.
//  Copyright © 2017 Michael Schaffner. All rights reserved.
//

import UIKit

class SettingWindow: UIView {
    @IBOutlet weak var iconImage: UIImageView!
    @IBOutlet weak var descLabel: UILabel!
    @IBOutlet weak var prefSwitch: UISwitch!
    @IBOutlet weak var cadenceControl: UISegmentedControl!
    @IBOutlet weak var sessionControl: UISegmentedControl!

    var preference: Preference = .info {
        didSet {
            preferenceChanged()
        }
    }
    
    var cadenceDescription: String {
        var freq: String
        switch data.cadenceFrequency {
        case 0:
            freq = ""
        case 1:
            freq =  "Other"
        case 2:
            freq  = "Third"
        default:
            freq = "Fourth"
        }
        
        return "Play Cadence Check\n Every \(freq) Run Interval"
    }
    
    
    var workoutDescription: String {
        let minutes = data.sessionArray[data.sequenceRepeats]
        return "Set for a \(minutes) minute workout"
    }
    
    var shapeLayer = CAShapeLayer()
    let lineWidth: CGFloat = 10
    
    override func didMoveToSuperview() {
        super.didMoveToSuperview()
        configure()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    //MARK:- Methods
    func configure() {
        layer.cornerRadius = frame.size.width/2
        layer.borderColor = UIColor.Theme.base.cgColor
        layer.borderWidth = 1
        clipsToBounds = true
        
        configureLabels()
        configureControls()
       // addCircle()
    }
    
    func configureControls() {
        sessionControl.tintColor = UIColor.Theme.borderOn
        cadenceControl.tintColor = UIColor.Theme.borderOn
        cadenceControl.setTitleTextAttributes(
            [NSFontAttributeName: UIFont.cadence],
            for: .normal)
             sessionControl.setTitleTextAttributes(
                [NSFontAttributeName: UIFont.session],
                for: .normal)
    }
    
    func configureLabels() {
       // descLabel.font = UIFont.setting
       // descLabel.textAlignment = .center
        descLabel.descFormat(lineHeight: 1)
        descLabel.textColor = UIColor.Theme.borderOn
    }
    
    func preferenceChanged() {
        //set switch and image
        switch preference {
        case .audio:
            prefSwitch.isOn = data.audioOn
            iconImage.image = UIImage(named: "audio_panel")
        case .vibrate:
            prefSwitch.isOn = data.vibrateOn
            iconImage.image = UIImage(named: "vibrate_panel")
        case .cadence:
            prefSwitch.isOn = data.cadenceOn
            iconImage.image = UIImage(named: "cadence_panel")
        case .music:
            prefSwitch.isOn = data.musicOn
            iconImage.image = UIImage(named: "music_panel")
        case .workout:
            prefSwitch.isOn = data.workoutOn
            iconImage.image = UIImage(named: "session_panel")
        default:
            //info
            iconImage.image = nil
        }
       
        prefSwitch.isHidden = preference == .info
        descLabel.text = preference.desc
        initSegmentedControl()
        
        descLabel.descFormat(lineHeight: 1)
        
        setAppearance()
    }
    
    func initSegmentedControl() {
        switch preference {
        case .cadence:
            cadenceControl.isHidden = false
            sessionControl.isHidden = true
            cadenceControl.isEnabled = data.cadenceOn
            cadenceControl.selectedSegmentIndex = data.cadenceFrequency
        case .workout:
            sessionControl.isHidden = false
            cadenceControl.isHidden = true
            sessionControl.isEnabled = data.workoutOn
            sessionControl.selectedSegmentIndex = data.sequenceRepeats
            for (index, minutes) in data.sessionArray.enumerated() {
                sessionControl.setTitle("\(minutes)", forSegmentAt: index)
            }
        default:
            sessionControl.isHidden = preference != .workout
            cadenceControl.isHidden = preference != .cadence
        }
        
        updateControlDescription()
    }
        
    func updateControlDescription() {
        if preference == .workout {
            descLabel.text = workoutDescription
        } else if preference == .cadence {
            descLabel.text = cadenceDescription
        } else {
            //controlLabel.text = ""
        }
        descLabel.descFormat(lineHeight: 1)
    }
    
    func setAppearance(){
        if prefSwitch.isOn {
            backgroundColor = UIColor.Theme.on
            iconImage.tintColor = UIColor.Theme.off
        }else {
            backgroundColor = UIColor.Theme.off
            iconImage.tintColor = UIColor.Theme.on
        }
    }
        
//    func addCircle() {
//        let dim = frame.size.height/2
//        let cRadius = frame.size.height/2 //- lineWidth
//        
//        let circlePath = UIBezierPath(arcCenter: CGPoint(x: dim, y: dim), radius: cRadius, startAngle: -CGFloat.pi/2, endAngle: 2*CGFloat.pi-CGFloat.pi/2, clockwise: true)
//        
//        self.shapeLayer.path = circlePath.cgPath
//        self.shapeLayer.fillColor = UIColor.clear.cgColor
//        self.shapeLayer.strokeColor = UIColor.green.cgColor
//        self.shapeLayer.lineWidth = frame.size.height///2 //lineWidth
//        shapeLayer.lineCap = kCALineCapButt
//        self.layer.insertSublayer(shapeLayer, at: 0)
//    }
//    
//    func animationOn() {
//        let animation = CABasicAnimation(keyPath: "strokeEnd")
//        animation.fromValue = 0
//        animation.toValue = 1
//        animation.duration = Double(0.5)
//        animation.fillMode = kCAFillModeForwards
//        animation.isRemovedOnCompletion = false
//        self.shapeLayer.add(animation, forKey: "ani")
//    }
//    
//    func animationOff() {
//        let animation = CABasicAnimation(keyPath: "strokeEnd")
//        animation.fromValue = 1
//        animation.toValue = 0
//        animation.duration = Double(0.5)
//        animation.fillMode = kCAFillModeForwards
//        animation.isRemovedOnCompletion = false
//        self.shapeLayer.add(animation, forKey: "ani")
//    }



}



