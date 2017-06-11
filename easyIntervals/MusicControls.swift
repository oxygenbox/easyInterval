//
//  MusicControls.swift
//  easyIntervals
//
//  Created by Michael Schaffner on 6/8/17.
//  Copyright © 2017 Michael Schaffner. All rights reserved.
//

import Foundation
import  UIKit


protocol MusicControlDelegate {
    func hideMusicControls()
}

class MusicControls: UIView {
    var delegate: MusicControlDelegate?
    
    
    
    @IBOutlet var buttons: [RoundButton]!
    
    
    //MARK:- LIFECYCLE
    override func didMoveToSuperview() {
        super.didMoveToSuperview()
        backgroundColor = UIColor.clear
    }
    
    @IBAction func closeTapped(_ sender: UIButton) {
        hide()
    }
    
    @IBAction func nextTapped(_ sender: UIButton) {
        print("next")
    }
    
    @IBAction func previousTapped(_ sender: UIButton) {
        print("previou")
    }
    
    @IBAction func playPauseTapped(_ sender: UIButton) {
        print("pause")
    }
    
    @IBAction func chooseTapped(_ sender: UIButton) {
        print("choose")
    }
    
    func configure() {
        for button in buttons {
            button.select()
            button.isOn = false
        }
    }
    
    func hide() {
        if let del = delegate {
            del.hideMusicControls()
        } else {
            isHidden = true
        }
    }
    
    
}
