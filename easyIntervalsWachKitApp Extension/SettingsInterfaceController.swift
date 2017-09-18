//
//  SettingsInterfaceController.swift
//  easyIntervalsWachKitApp Extension
//
//  Created by Michael Schaffner on 9/11/17.
//  Copyright © 2017 Michael Schaffner. All rights reserved.
//

import WatchKit
import Foundation


class SettingsInterfaceController: WKInterfaceController {
    @IBOutlet var leftPicker: WKInterfacePicker!
    @IBOutlet var rightPicker: WKInterfacePicker!
    @IBOutlet var leftPickerLabel: WKInterfaceLabel!
    @IBOutlet var rightPickerLabel: WKInterfaceLabel!
    
    var runSetting = 0
    var walkSetting = 0
    
    let tool = Tool()
    
    override func awake(withContext context: Any?) {
        super.awake(withContext: context)
        
        // Configure interface objects here
        leftPicker.setSelectedItemIndex(9)
        rightPicker.setSelectedItemIndex(9)
        print("Awake")
        
    }

    override func willActivate() {
        // This method is called when watch view controller is about to be visible to user
        super.willActivate()
         setUp()
        print("will activate")
    }

    override func didDeactivate() {
        // This method is called when watch view controller is no longer visible
        super.didDeactivate()
        saveData()
    }
    
    @IBAction func leftPickerChanged(_ value: Int) {
        self.runSetting = value
        self.postPickerLabel()
        //saveData()
    }
    
    @IBAction func rightPickerChanged(_ value: Int) {
        self.walkSetting = value
        self.postPickerLabel()
       // saveData()
    }
    
    //my methods
    func setUp() {
        var items = [WKPickerItem]()
        for minute in 1...10 {
            let picker = WKPickerItem()
            picker.title = "\(minute):00"
            items.append(picker)
        }
        leftPicker.setItems(items)
        rightPicker.setItems(items)
        
        //load Defaults
        getData()
        
        print("run: \(self.runSetting)")
        print("walk: \(self.walkSetting)")
        //set picker
        
        
        postPickerLabel()
        leftPicker.setSelectedItemIndex(self.runSetting)
        rightPicker.setSelectedItemIndex(self.walkSetting)
        
        
    }
    
    func getData() {
        let defaults = UserDefaults.standard
        
        if defaults.bool(forKey: "isSaved") {
            self.runSetting = defaults.integer(forKey: Keys.runSetting.rawValue)
            self.walkSetting = defaults.integer(forKey: Keys.walkSetting.rawValue)
            print("got data")
        } else {
            self.saveData()
            print("first fisit")
        }
    }
    
    func saveData() {
        let defaults = UserDefaults.standard
        defaults.set(true, forKey: Keys.isSaved.rawValue)
        defaults.set(runSetting, forKey: Keys.runSetting.rawValue)
        defaults.set(walkSetting, forKey: Keys.walkSetting.rawValue)
        print("save data")
        defaults.synchronize()
    }
    
    func postPickerLabel() {
        let runSeconds = (runSetting + 1) * 60
        let walkSeconds = (walkSetting + 1) * 60
        let runMsg = "run:\(tool.formatTime(secs: runSeconds, withHours: false))"
        let walkMsg = "walk:\(tool.formatTime(secs: walkSeconds, withHours: false))"
        
        self.leftPickerLabel.setText(runMsg)
        self.rightPickerLabel.setText(walkMsg)
    }
}




/*
 class SettingsInterfaceController: WKInterfaceController {
 
 var isRunWalk = true
 
 @IBOutlet var settingsLabel: WKInterfaceLabel!
 print("right value \(value) walkSetting \(walkSetting)")
 
 postPickerLabel()
 
 }
 
 func setUp() {
 //populate picker

 
 
 
 
 }
 

 
 
 
 
 
 func saveData() {
 
 }
 


 */
