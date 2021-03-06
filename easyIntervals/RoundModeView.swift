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
    
    var completeView: RoundCompleteView!
    
    override func draw(_ rect: CGRect) {
        layer.cornerRadius = frame.size.height/2
        clipsToBounds = true
        layer.borderColor = UIColor.white.cgColor
        layer.borderWidth = 2
        
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
        loadCompleteView()
        
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
            self.intervalView.mode = .walk
            self.completeView.setUp(isImage: false)
        case .walk:
            self.backgroundColor = UIColor.walk
            self.imageView.image = UIImage(named: "walk_solid")
            self.intervalView.mode = .run
            self.completeView.setUp(isImage: true)
        default:
            break
        }
        
    }
    
    //called from mainVC
    func beginIntervalClock(intervalSeconds: Int) {
        
        intervalView.clock.frame = bounds
        if intervalView.mode == .run {
            intervalView.clock.shapeLayer.strokeColor = UIColor.walk.cgColor
           
        }else {
            intervalView.clock.shapeLayer.strokeColor = UIColor.run.cgColor
            
        }
        intervalView.clock.shapeLayer.lineWidth = intervalView.clock.frame.size.width * 0.92 //- 12
        intervalView.clock.begin(with: intervalSeconds)
    }
    
    func pauseIntervalClock() {
        intervalView.clock.pause()
    }
    
    func resumeIntervalClock() {
        intervalView.clock.resume()
    }
    
    func resetIntervalClock() {
        intervalView.clock.reset()
    }
        
    func statusOn() {
        intervalView.isHidden = false
        intervalView.setUp(frame: bounds)
        intervalView.frame.origin.y = -intervalView.frame.size.height
        intervalView.label.frame = intervalView.bounds
        
        UIView.animate(withDuration:self.dropDuration, delay:0, usingSpringWithDamping: 0.3, initialSpringVelocity: 0, options: [.curveLinear], animations: {
            self.intervalView.frame.origin.y = 0
        })
    }
    
      func statusOff() {
        let animator = UIViewPropertyAnimator(duration: 0.5, curve: .easeOut) { 
            self.intervalView.frame.origin.y = self.frame.size.height
        }
        
        animator.startAnimation()
    }
    
    func loadCompleteView() {
        if let cv = Bundle.main.loadNibNamed("RoundCompleteView", owner: self, options: nil)?.first as? RoundCompleteView {
                cv.frame = self.bounds
                self.completeView = cv
                addSubview(cv)
        }
    }

}

