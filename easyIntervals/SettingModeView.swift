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
    
    var mode: Mode = .run {
        didSet {
            setImage()
        }
    }
    
    
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
        super.draw(rect)
        layer.cornerRadius = bounds.width/2
        layer.borderColor = UIColor.myBlue.cgColor
        layer.borderWidth = 4
        clipsToBounds = true
        
        let rect = CGRect(x: 10, y: 10, width: bounds.size.width - 20, height: bounds.size.height - 20)
        imageView = UIImageView(frame: bounds)
        imageView.frame = rect
        imageView.contentMode = .scaleAspectFit
        addSubview(imageView)
        
       // setMode(mode: .walk)
       // print("draw")
    }
    
    override func awakeFromNib() {
        print("awake")
    }
    
    
    func setImage() {
        
        print("MODE \(self.mode)")
        
        var imageName = "walk_solid"
        if mode == .run {
            imageName = "run_solid"
        }
        
        imageView.image = UIImage(named: imageName)
        imageView.tintImageColor(color: UIColor.myBlue)
        
    }

}
