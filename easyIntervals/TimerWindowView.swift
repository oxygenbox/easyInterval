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
        label.font = UIFont(name: "AvenirNext-Bold", size: 120)
        label.textColor = UIColor.highlight
        label.text = "5"
        return label
    }()

    var intervalSeconds: Int = 0 {
        didSet {
            tick()
        }
    }
    var instructions =  InstructionView()
    var imageView: UIImageView!
    var dropDuration: Double = 0.4
    var delay: Double = 0
    var label = UILabel()
    

    //override func draw(_ rect: CGRect) {
        // Drawing code
  //  }
    
    override func didMoveToSuperview() {
        super.didMoveToSuperview()
        layer.cornerRadius = frame.size.height/2
        clipsToBounds = true
        layer.borderColor = UIColor.Theme.base.cgColor
        layer.borderWidth = 1
       
        config()
    }
    
    func config() {
//        //backgroundColor = UIColor.Theme.on
//        setBackground()
//        let m = 0.10 * frame.size.height
//        let rect = CGRect(x: m, y: m, width: bounds.size.width - m*2, height: bounds.size.height - m*2)
//        imageView = UIImageView(frame: rect)
//        imageView.contentMode = .scaleAspectFit
//    
//        addSubview(intervalClock)
//        intervalClock.frame = self.bounds
//        addSubview(imageView)
//        createLabel()
//        sessionClock.frame = self.bounds
//        sessionClock.isHidden = true
//        addSubview(sessionClock)
//        loadInstructions()
    }
    
    func change() {
//        UIView.animate(withDuration: self.dropDuration, delay: 0, options: .curveLinear, animations: {
//            self.imageView.transform = CGAffineTransform(translationX: 0, y: self.bounds.height)
//        }) { (true) in
//            self.imageView.transform = CGAffineTransform(translationX: 0, y: -self.bounds.height)
//            self.setImage()
//            UIView.animate(withDuration:self.dropDuration, delay: self.delay, usingSpringWithDamping: 0.7, initialSpringVelocity: 0.7, options: .curveLinear, animations: {
//                self.imageView.transform = .identity
//            }, completion: nil)
//        }
//        
//        UIView.animate(withDuration: 0.2) {
//            self.setBackground()
//        }
        
    }

    func setImage() {
//        var imageName = "walk_solid"
//        //var tintColor = UIColor.walk
//        if mode == .run {
//            imageName = "run_solid"
//          //  tintColor = UIColor.run
//        }
//        
//        imageView.image = UIImage(named: imageName)
//        imageView.tintImageColor(color: UIColor.white)
    }
    
    func tick() {
//        if intervalSeconds > 0 && intervalSeconds < 6 {
//            addPulse()
//            label.text = "\(intervalSeconds)"
//                self.label.transform = CGAffineTransform.identity
//                self.label.alpha = 1
//            UIView.animate(withDuration: 0.5, animations: {
//                self.label.alpha = 0
//                self.label.transform = CGAffineTransform(scaleX: 2.0, y: 2.0)
//            })
//        } else {
//             label.text = ""
//      }
    }
    
    func pause() {
//        intervalClock.pause()
//        sessionClock.pause()
        
    }
    
    func resume() {
//        intervalClock.resume()
//        sessionClock.resume()
    }
    
    func beginClocks(intervalSeconds: Int, sessionSeconds: Int?) {
//       
//        if mode == .walk {
//             intervalClock.shapeLayer.strokeColor = UIColor.run.cgColor
//        } else {
//             intervalClock.shapeLayer.strokeColor = UIColor.walk.cgColor
//        }
//        
//       
//        intervalClock.shapeLayer.lineWidth = frame.size.height - 12
//        intervalClock.begin(with: intervalSeconds)
//        
//        guard let t = sessionSeconds else {
//            return
//        }
//        
//        sessionClock.shapeLayer.strokeColor = UIColor.highlight.cgColor
//        sessionClock.shapeLayer.lineWidth = 10
//        sessionClock.isHidden = false
//        sessionClock.begin(with: t)
        
    }
    
    func reset(interval: Bool, session: Bool) {
//        if interval {
//            intervalClock.reset()
//        }
//        
//        if session {
//            sessionClock.reset()
//        }
    }
    
    func addPulse() {
//        let radius = imageView.frame.width //* 0.8
//        let pulse = Pulsing(numberOfPulses: 1, radius: radius/2, position: imageView.center)
//        pulse.animationDuration = 0.5
//        pulse.backgroundColor = UIColor.highlight.cgColor
//        layer.insertSublayer(pulse, below: imageView.layer)
    }
    
    func createLabel() {
//        let h: CGFloat = 70
//        let w = frame.size.width
//        let y  = frame.height/2 - h/2
//        self.label = UILabel(frame: CGRect(x: 0, y: y-20, width: w, height: h))
//        self.label.frame = self.bounds
//        self.label.font = UIFont(name: "AvenirNext-Bold", size: h)
//        self.label.textAlignment = .center
//        self.label.textColor = UIColor.highlight
//        self.label.text = ""
//        self.addSubview(self.label)
    }
    
   
    
    
    func loadInstructions() {
//        
//        if let infoWindow = Bundle.main.loadNibNamed("InstructionView", owner: self, options: nil)?.first as? InstructionView {
//            self.instructions = infoWindow
//            infoWindow.frame = bounds
//            infoWindow.layer.cornerRadius = frame.width/2
//            
//            addSubview(infoWindow)
//        }
    }
    
    func hideInstructions() {
//        if !instructions.isHidden {
//            instructions.toggle()
//        }
    }

    func setBackground()  {
//        if mode == .run {
//            backgroundColor = UIColor.run
//            
//        }
//        else {
//            backgroundColor = UIColor.walk
//        }
//        
//        //backgroundColor = UIColor.tertiary
    }
}









