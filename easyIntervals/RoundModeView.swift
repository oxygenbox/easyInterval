//
//  RoundModeView.swift
//  easyIntervals
//
//  Created by Michael Schaffner on 6/17/17.
//  Copyright © 2017 Michael Schaffner. All rights reserved.
//

import UIKit

class RoundModeView: UIView {
    
    //MARK- VARIABLES
    let shrinkSize: CGFloat = 0.25
    let animationSpeed: Double = 0.25
    let dropDuration: Double = 0.4
    
    lazy var intervalClock: ClockView = {
        let clock = ClockView(frame: self.bounds)
        return clock
    }()
    
    lazy var imageView: UIImageView = {
        let inset = self.frame.size.height * 0.10
        let rect = CGRect(x: inset, y: inset, width: self.bounds.width - inset*2, height: self.bounds.height - inset*2)
        let iv = UIImageView(frame: rect)
        iv.contentMode = .scaleAspectFit
        iv.tintColor = UIColor.white
        return iv
    }()
    
    lazy var intervalView: RoundIntervalView = {
       let sv = RoundIntervalView(frame: CGRect.zero)
        return sv
    }()
    
    var mode: Mode = .run {
        didSet {
            configure()
        }
    }
    
    var clockColor: UIColor {
        if mode == .run {
            return UIColor.walk
        } else {
            return UIColor.run
        }
    }
    
    
    
    
    override func draw(_ rect: CGRect) {
        layer.cornerRadius = frame.size.height/2
        clipsToBounds = true
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
    }
    
    
    
    
    
    func configure() {
        addSubview(intervalClock)
        addSubview(imageView)
        addSubview(intervalView)
        
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.centerXAnchor.constraint(equalTo: imageView.superview!.centerXAnchor).isActive = true
        imageView.centerYAnchor.constraint(equalTo: imageView.superview!.centerYAnchor).isActive = true
        imageView.heightAnchor.constraint(equalToConstant: frame.size.height * 0.8).isActive = true
        imageView.widthAnchor.constraint(equalToConstant: frame.size.width * 0.8).isActive = true
        
        intervalClock.translatesAutoresizingMaskIntoConstraints = false
        intervalClock.centerXAnchor.constraint(equalTo: intervalClock.superview!.centerXAnchor).isActive = true
        intervalClock.centerYAnchor.constraint(equalTo: intervalClock.superview!.centerYAnchor).isActive = true
        intervalClock.heightAnchor.constraint(equalToConstant: frame.size.height).isActive = true
        intervalClock.widthAnchor.constraint(equalToConstant: frame.size.width).isActive = true
        
        
        switch mode {
        case .run:
            self.backgroundColor = UIColor.run
            self.imageView.image = UIImage(named: "run_solid")
            
        case .walk:
            self.backgroundColor = UIColor.walk
            self.imageView.image = UIImage(named: "walk_solid")
        default:
            break
        }
    }
    
    func beginClock(intervalSeconds: Int) {
        intervalClock.shapeLayer.strokeColor = self.clockColor.cgColor
        intervalClock.shapeLayer.lineWidth = intervalClock.frame.size.width * 0.92 //- 12
        intervalClock.begin(with: intervalSeconds)
    }
    
    func beginStatusClock(intervalSeconds: Int) {
        intervalView.clock.frame = bounds
        intervalView.clock.shapeLayer.strokeColor = self.clockColor.cgColor
        intervalView.clock.shapeLayer.lineWidth = intervalView.clock.frame.size.width * 0.92 //- 12
        intervalView.clock.begin(with: intervalSeconds)
    }
    
    func pause() {
        intervalClock.pause()
    }
    
    func reset() {
        intervalClock.reset()
    }
    
    func resume() {
        if intervalClock.hasStarted {
            intervalClock.resume()
        }
    }
    

    func grow() {
        statusOff()
//        statusView.frame = CGRect(origin: CGPoint.zero, size: frame.size)
//        statusView.frame.origin.y = -statusView.frame.size.height
//        statusView.isHidden = true
//        
//        
//        UIView.animate(withDuration: 1, delay: 0, usingSpringWithDamping: 0.2, initialSpringVelocity: 0.8, options: [], animations: {
//            self.statusView.frame.origin.y = 0
//        }, completion: nil)
        
//         self.intervalClock.alpha = 1
//        let animator = UIViewPropertyAnimator(duration: self.animationSpeed, curve: .linear) {
//            self.transform = CGAffineTransform.identity
//        }
//        
//        animator.startAnimation()
    }
    
    func shrink() {
        statusOn()
        
       // let s = RoundStatusView(frame: CGRect(x: 0, y: 0, width: frame.size.width, height: frame.size.height))
       // s.backgroundColor = UIColor.purple
       // addSubview(s)
//        let animator = UIViewPropertyAnimator(duration: self.animationSpeed, curve: .linear) {
//            self.transform = CGAffineTransform(scaleX: self.shrinkSize, y: self.shrinkSize)
//            self.intervalClock.alpha = 0
//        }
//        
//        animator.addCompletion { (scale) in
//        
//        }
//        animator.startAnimation()
    }
    
    func statusOn() {
       intervalView.isHidden = false
//        statusView.frame = CGRect(origin: CGPoint.zero, size: frame.size)
//        statusView.layer.cornerRadius = statusView.frame.size.width/2
        intervalView.setUp(frame: bounds)
        intervalView.frame.origin.y = -intervalView.frame.size.height
        
        UIView.animate(withDuration:self.dropDuration, delay:0, usingSpringWithDamping: 0.5, initialSpringVelocity: 5, options: .curveLinear, animations: {
            self.intervalView.frame.origin.y = 0
        })
    }
    
    //    UIView.animate(withDuration: self.dropDuration, delay: 0, options: .curveLinear, animations: {
//            self.imageView.transform = CGAffineTransform(translationX: 0, y: self.bounds.height)
//        }) { (true) in
//            self.imageView.transform = CGAffineTransform(translationX: 0, y: -self.bounds.height)
//            self.setImage()
//            UIView.animate(withDuration:self.dropDuration, delay: self.delay, usingSpringWithDamping: 0.7, initialSpringVelocity: 0.7, options: .curveLinear, animations: {
//                self.imageView.transform = .identity
//            }, completion: nil)
  //      }
//        
//        UIView.animate(withDuration: 0.2) {
//            self.setBackground()
//        }

        
        
        
        
        
//    }
//
    func statusOff() {
       // statusView.isHidden = true
        
        let animator = UIViewPropertyAnimator(duration: 0.5, curve: .easeOut) { 
            self.intervalView.frame.origin.y = self.frame.size.height
        }
        
        animator.startAnimation()
    }
}

