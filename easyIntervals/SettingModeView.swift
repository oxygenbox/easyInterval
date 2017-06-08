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
    var dropDuration: Double = 0.2
    
    var mode: Mode = .run {
        didSet {
            change()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        config()
    }
    
    override func didMoveToWindow() {
        super.didMoveToWindow()
    }
    
    func config() {
        layer.cornerRadius = self.bounds.height / 2
        layer.borderColor = UIColor.Theme.base.cgColor
        layer.borderWidth = 2
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
        imageView.tintImageColor(color: UIColor.Theme.base)
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

}
