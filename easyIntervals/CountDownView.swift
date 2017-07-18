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
    
    var sequenceTracker  = true
    var sequenceArray = [0, 1, 3, 4]
    
    var timer: Timer?
    
    override func draw(_ rect: CGRect) {
        
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
    
    func startSequence() {
        timer = Timer.scheduledTimer(withTimeInterval: 0.5, repeats: true, block: { (t) in
            let index = self.sequenceArray.remove(at: 0)
            self.sequenceArray.append(index)
            self.dots[index].sequenceOn()
            print("dddddd")
        })
        
        
    }
    
    func stopSequence() {
        timer?.invalidate()
        timer = nil
        
        for dot in dots {
            dot.sequenceOff()
        }
    }
    
    
    
}
