//
//  CountDownView.swift
//  easyIntervals
//
//  Created by Michael Schaffner on 6/19/17.
//  Copyright © 2017 Michael Schaffner. All rights reserved.
//

import UIKit

class CountDownView: UIView {

    
    @IBOutlet var dots: [CountDownDot]!
    
    override func draw(_ rect: CGRect) {
        //layer.cornerRadius = frame.size.height/2
        //clipsToBounds = true
        //backgroundColor = UIColor.orange
    }
    
    override func didMoveToWindow() {
        super.didMoveToWindow()
        backgroundColor = UIColor.clear
        for (index, dot) in dots.enumerated() {
            dot.configure(tagNum: dots.count - index)
        }
    }
    
    
    func countDown(second: Int) {
        let dot = dots[dots.count - second]
        dot.animateOn()
    }

}
