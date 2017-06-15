//
//  SwitchView.swift
//  easyIntervals
//
//  Created by Michael Schaffner on 6/15/17.
//  Copyright © 2017 Michael Schaffner. All rights reserved.
//

import UIKit

class SwitchView: UIView {

       override func draw(_ rect: CGRect) {
        // Drawing code
        
        layer.cornerRadius = frame.size.height/2
        clipsToBounds = true
    }
}
