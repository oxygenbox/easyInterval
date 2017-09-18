//
//  EntryInterfaceController.swift
//  easyIntervalsWachKitApp Extension
//
//  Created by Michael Schaffner on 9/12/17.
//  Copyright © 2017 Michael Schaffner. All rights reserved.
//

import WatchKit
import Foundation


class EntryInterfaceController: WKInterfaceController {

    override func awake(withContext context: Any?) {
        super.awake(withContext: context)
        
        // Configure interface objects here.
    }

    override func willActivate() {
        // This method is called when watch view controller is about to be visible to user
        super.willActivate()
    }

    override func didDeactivate() {
        // This method is called when watch view controller is no longer visible
        super.didDeactivate()
    }
    
    @IBAction func startTapped() {
        WKInterfaceController.reloadRootControllers(withNamesAndContexts: [(name: "mainController", context: NSObject())])
        
        
      //  WKInterfaceController.reloadRootControllers(withNamesAndContexts: <#T##[(name: String, context: AnyObject)]#>)
    }
    
    
// WKInterfaceController.reloadRootControllers(withNames: ["WorkoutInterfaceController"], contexts: [selectedActivity])
}
//InterfaceController
//mainController
