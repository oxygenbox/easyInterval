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
    var delay: Double = 0
    
    var mode: Mode = .run {
        didSet {
           // setImage()
            change()
        }
    }
    
    override func awakeFromNib() {
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
    
    
    func setImage() {
        var imageName = "walk_solid"
        if mode == .run {
            imageName = "run_solid"
        }
        
        imageView.image = UIImage(named: imageName)
        imageView.tintImageColor(color: UIColor.myBlue)
        
    }
    
    func change() {
    
        
        UIView.animate(withDuration: 0.2, delay: 0, options: .curveLinear, animations: {
            self.imageView.transform = CGAffineTransform(translationX: 0, y: self.bounds.height)
        }) { (true) in
            self.imageView.transform = CGAffineTransform(translationX: 0, y: -self.bounds.height)
            self.setImage()
            
            UIView.animate(withDuration: 0.2, delay: self.delay, usingSpringWithDamping: 0.7, initialSpringVelocity: 0.7, options: .curveLinear, animations: {
                self.imageView.transform = .identity
            }, completion: nil)
            
            
        }
 
    }

}
