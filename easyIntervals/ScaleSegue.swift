//
//  ScaleSegue.swift
//  easyIntervals
//
//  Created by Michael Schaffner on 5/24/17.
//  Copyright © 2017 Michael Schaffner. All rights reserved.
//

import UIKit

class ScaleSegue: UIStoryboardSegue {

    override func perform() {
        scale()
    }
    
    func scale() {
        let toVC = self.destination
        let fromVC = self.source
        let containerView = fromVC.view.superview
        let origCenter = fromVC.view.center
        toVC.view.transform = CGAffineTransform(scaleX: 0.05, y: 0.05)
        toVC.view.center = origCenter
        
        containerView?.addSubview(toVC.view)
        
        UIView.animate(withDuration: 0.5, delay: 0, options: [.curveEaseInOut], animations: {
            toVC.view.transform = CGAffineTransform.identity
        }) { (success) in
            fromVC.present(toVC, animated: false, completion: nil)
        }
    }
    
    @IBAction func prepareForUnwind(segue: UIStoryboardSegue) {
        
    }
    
}


class unwindScaleSegue: UIStoryboardSegue {
    override func perform() {
        scale()
    }

    func scale() {
        let toVC = self.destination
        let fromVC = self.source
        
      fromVC.view.insertSubview(toVC.view, at: 0)
        UIView.animate(withDuration: 0.5, delay: 0, options: [.curveEaseInOut], animations: {
            fromVC.view.transform = CGAffineTransform(scaleX: 0.05, y: 0.05)
            
        }) { (success) in
            fromVC.dismiss(animated: false, completion: nil)
        }
    }

    
    
    
}
