//
//  TimerWindowView.swift
//  easyIntervals
//
//  Created by Michael Schaffner on 5/15/17.
//  Copyright © 2017 Michael Schaffner. All rights reserved.
//

//Session clock
//interval clock
//image
//countDown


import UIKit

class TimerWindowView: UIView {

    //MARK:- Variables
    lazy var intervalClock: ClockView = {
        let clock = ClockView(frame: self.frame)
        return clock
    }()
    
    lazy var sessionClock: ClockView = {
        let clock = ClockView(frame: self.frame)
        return clock
    }()
    var mode: Mode = .run {
        didSet {
            change()
        }
    }
    
    lazy var countDownLabel: UILabel = {
        let label = UILabel(frame: self.frame)
        label.backgroundColor = UIColor.yellow
        label.font = UIFont.boldSystemFont(ofSize: 120)
        label.text = "5"
        return label
    }()

    var intervalSeconds: Int = 0 {
        didSet {
            tick()
        }
    }
    
    var imageView: UIImageView!
    var dropDuration: Double = 0.4
    var delay: Double = 0
    var label = UILabel()
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    //override func draw(_ rect: CGRect) {
        // Drawing code
        
  //  }
    
    override func didMoveToSuperview() {
        super.didMoveToSuperview()
        layer.cornerRadius = frame.size.height/2
        layer.borderColor = UIColor.myBlue.cgColor
        layer.borderWidth = 4
        clipsToBounds = true
        backgroundColor = UIColor.white
        config()
        
    }
    
    func config() {
        let m = 0.10 * frame.size.height
        
       let rect = CGRect(x: m, y: m, width: bounds.size.width - m*2, height: bounds.size.height - m*2)
        imageView = UIImageView(frame: rect)
        imageView.contentMode = .scaleAspectFit
       // imageView.image = UIImage(named: "walk_solid")
        
        addSubview(imageView)
        intervalClock.frame = self.bounds
        addSubview(intervalClock)
       // addSubview(countDownLabel)
//        
//        let box = UIView(frame: CGRect(x: 100, y: 100, width: 100, height: 100))
//        box.backgroundColor = UIColor.orange
//        addSubview(box)
//        let c = ClockView()
//        c.frame = box.frame
//        addSubview(c)
        
        createLabel()
        
        
        
        
        
        
    }
    
    func change() {
        UIView.animate(withDuration: self.dropDuration, delay: 0, options: .curveLinear, animations: {
            self.imageView.transform = CGAffineTransform(translationX: 0, y: self.bounds.height)
        }) { (true) in
            self.imageView.transform = CGAffineTransform(translationX: 0, y: -self.bounds.height)
            self.setImage()
            UIView.animate(withDuration:self.dropDuration, delay: self.delay, usingSpringWithDamping: 0.7, initialSpringVelocity: 0.7, options: .curveLinear, animations: {
                self.imageView.transform = .identity
            }, completion: nil)
        }
    }

    func setImage() {
        var imageName = "walk_solid"
        if mode == .run {
            imageName = "run_solid"
        }
        
        imageView.image = UIImage(named: imageName)
        imageView.tintImageColor(color: UIColor.myBlue)
    }
    
    func tick() {
        if intervalSeconds > 0 && intervalSeconds < 6 {
            addPulse()
            label.text = "\(intervalSeconds)"
                self.label.transform = CGAffineTransform.identity
                self.label.alpha = 1
            UIView.animate(withDuration: 0.5, animations: {
                self.label.alpha = 0
                self.label.transform = CGAffineTransform(scaleX: 2.0, y: 2.0)
            })
        } else {
             label.text = ""
      }
        
    }
    
    func pause() {
        intervalClock.pause()
    }
    
    func resume() {
        
    }
    
    func beginClocks(intervalSeconds: Int, sessionSeconds: Int?) {
        intervalClock.begin(with: intervalSeconds)
    }
    
    func reset() {
        intervalClock.resume()
    }
    
    func addPulse() {
        
        let radius = imageView.frame.width //* 0.8
        
        let pulse = Pulsing(numberOfPulses: 1, radius: radius/2, position: imageView.center)
        pulse.animationDuration = 0.5
        pulse.backgroundColor = UIColor.myBlue.cgColor
        layer.insertSublayer(pulse, below: imageView.layer)
        
    }
    
    
    func createLabel() {
        let h: CGFloat = 70
        let w = frame.size.width
        let y  = frame.height/2 - h/2
        self.label = UILabel(frame: CGRect(x: 0, y: y-20, width: w, height: h))
        self.label.frame = self.bounds
        self.label.font = UIFont(name: "AvenirNext-Bold", size: h)
        self.label.textAlignment = .center
        //self.label.textColor = color
        self.label.text = ""
        self.addSubview(self.label)
    }

}










/*
 //
 //  SettingModeView.swift
 //  easyIntervals
 //
 //  Created by Michael Schaffner on 3/1/17.
 //  Copyright © 2017 Michael Schaffner. All rights reserved.
 //
 
 import UIKit
 
 class SettingModeView: UIView {
 var imageView: UIImageView!
 
 
 
 
 
 
 func config() {
 
 
 let rect = CGRect(x: 10, y: 10, width: bounds.size.width - 20, height: bounds.size.height - 20)
 imageView = UIImageView(frame: bounds)
 imageView.frame = rect
 imageView.contentMode = .scaleAspectFit
 addSubview(imageView)
 }
 /*
 
 configure()
 */
 
 
 func setUp() {
 
 print(frame)
 
 layer.cornerRadius = bounds.width/2
 layer.borderColor = UIColor.myBlue.cgColor
 layer.borderWidth = 4
 clipsToBounds = true
 
 let rect = CGRect(x: 10, y: 10, width: bounds.size.width - 20, height: bounds.size.height - 20)
 imageView = UIImageView(frame: bounds)
 imageView.frame = rect
 imageView.contentMode = .scaleAspectFit
 addSubview(imageView)
 }
 
 imageView.image = UIImage(named: imageName)
 imageView.tintImageColor(color: UIColor.myBlue)
 
 }


 */
