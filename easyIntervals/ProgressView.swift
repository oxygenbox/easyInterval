//
//  ProgressView.swift
//  easyIntervals
//
//  Created by Michael Schaffner on 2/8/17.
//  Copyright © 2017 Michael Schaffner. All rights reserved.
//

import Foundation
import  UIKit


class ProgressView: UIView {
    var progressBar: UIView!
    
    
    override func draw(_ rect: CGRect) {
        progressBar = UIView(frame: rect)
        
        
        progressBar.frame = CGRect(x: 0, y: frame.size.height, width: frame.size.width, height: 0)
        progressBar.backgroundColor = UIColor.orange
        addSubview(progressBar)
    }
    
    
    func update(pct: CGFloat) {
        let w = frame.size.width
        let h = frame.size.height * (1 - pct)
        let x: CGFloat = 0
        let y: CGFloat = frame.size.height - h
        
        print(frame)
        var t: TimeInterval = 0
        if  h > 1 {
            t = 1
        }
        print(progressBar.frame)
        UIView.animate(withDuration: t) {
           self.progressBar.frame = CGRect(x: x, y: y, width: w, height: h)
        }
        
        
    }
}
