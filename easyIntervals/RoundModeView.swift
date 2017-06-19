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
    lazy var intervalClock: ClockView = {
        let clock = ClockView(frame: self.frame)
        clock.backgroundColor = UIColor.blue
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
    
    var mode: Mode = .run {
        didSet {
            configure()
        }
    }
    
    override func draw(_ rect: CGRect) {
        layer.cornerRadius = frame.size.height/2
        clipsToBounds = true
    }
    
    
    func configure() {
        addSubview(intervalClock)
        addSubview(imageView)
        
        switch mode {
        case .run:
            self.backgroundColor = UIColor.run
            imageView.image = UIImage(named: "run_solid")
        case .walk:
            self.backgroundColor = UIColor.walk
            imageView.image = UIImage(named: "walk_solid")
        default:
            break
        }
        
       
    }

}

/*
 func setImage() {
 var imageName = "walk_solid"
 //var tintColor = UIColor.walk
 if mode == .run {
 imageName = "run_solid"
 //  tintColor = UIColor.run
 }
 
 
 imageView.tintImageColor(color: UIColor.white)
 }

  */
