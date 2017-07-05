//
//  RoundCompleteView.swift
//  easyIntervals
//
//  Created by Michael Schaffner on 7/4/17.
//  Copyright © 2017 Michael Schaffner. All rights reserved.
//

import UIKit

class RoundCompleteView: UIView {
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var label: UILabel!
    
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
        layer.cornerRadius = frame.width/2
        
        clipsToBounds = true
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func setUp(isImage: Bool) {
        backgroundColor = UIColor.jake
        let font = UIFont(name: "AvenirNext-DemiBold", size: 28)!
        label.font = font
        label.textColor = UIColor.white
        label.text = "complete"
        imageView.tintColor = UIColor.white
        
        if isImage {
            label.isHidden = true
        } else {
            imageView.isHidden  = true 
        }
    }

}
