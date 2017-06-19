//
//  CountDownView.swift
//  easyIntervals
//
//  Created by Michael Schaffner on 6/19/17.
//  Copyright © 2017 Michael Schaffner. All rights reserved.
//

import UIKit

class CountDownView: UIView {

    override func draw(_ rect: CGRect) {
        layer.cornerRadius = frame.size.height/2
        clipsToBounds = true
        backgroundColor = UIColor.orange
    }
    

}
