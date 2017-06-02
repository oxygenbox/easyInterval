//
//  PreferenceWindow.swift
//  easyIntervals
//
//  Created by Michael Schaffner on 5/26/17.
//  Copyright © 2017 Michael Schaffner. All rights reserved.
//

import UIKit

class PreferenceWindow: UIView {
    @IBOutlet weak var iconImage: UIImageView!
    @IBOutlet weak var descLabel: UILabel!
    @IBOutlet weak var prefSwitch: UISwitch!
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    
    override init(frame: CGRect) {
        super.init(frame:frame)
        
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

}
