//
//  PreferenceButtom.swift
//  easyIntervals
//
//  Created by Michael Schaffner on 6/15/17.
//  Copyright © 2017 Michael Schaffner. All rights reserved.
//

import UIKit

class PreferenceButton: UIButton {

    override func draw(_ rect: CGRect) {
        layer.cornerRadius = frame.width/2
        clipsToBounds = true
    }
    

}
