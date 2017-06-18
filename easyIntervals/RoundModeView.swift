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
        switch mode {
        case .run:
            self.backgroundColor = UIColor.run
        case .walk:
            self.backgroundColor = UIColor.walk
        default:
            break
        }
    }

}


