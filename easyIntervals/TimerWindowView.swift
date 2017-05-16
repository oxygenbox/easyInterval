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
    var mode: Mode = .run {
        didSet {
            // setImage()
            change()
        }
    }
    
    var imageView: UIImageView!
    var dropDuration: Double = 0.4
    var delay: Double = 0
    
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
       
        config()
        
    }
    
    func config() {
        let m = 0.10 * frame.size.height
        
       let rect = CGRect(x: m, y: m, width: bounds.size.width - m*2, height: bounds.size.height - m*2)
        imageView = UIImageView(frame: rect)
        imageView.contentMode = .scaleAspectFit
        imageView.image = UIImage(named: "walk_solid")
        addSubview(imageView)
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
