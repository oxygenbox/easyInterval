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
    
    override func awake(withContext context: Any?) {
        super.awake(withContext: context)
        
        // Configure interface objects here
        setUp()
        
    }

    override func willActivate() {
        // This method is called when watch view controller is about to be visible to user
        super.willActivate()
    }

    override func didDeactivate() {
        // This method is called when watch view controller is no longer visible
        super.didDeactivate()
        data.save()
    }
    
    @IBAction func leftPickerChanged(_ value: Int) {
        data.runSetting = value
        print("run val: \(data.runSetting)")
       // data.save()
        self.postPickerLabel()
    }
    
    @IBAction func rightPickerChanged(_ value: Int) {
        data.walkSetting = value
        print("walk val: \(data.walkSetting)")
      //  data.save()
        
        self.postPickerLabel()
    }
    
    //my methods
    func setUp() {
        initPicker()
        
        //set picker
        leftPicker.setSelectedItemIndex(data.runSetting)
        rightPicker.setSelectedItemIndex(data.walkSetting)
        postPickerLabel()
    }
    
    func initPicker() {
        var items = [WKPickerItem]()
        
        for minute in 1...10 {
            let picker = WKPickerItem()
            picker.title = "\(minute):00"
            items.append(picker)
        }
        leftPicker.setItems(items)
        rightPicker.setItems(items)
    }
    
    func postPickerLabel() {
        let runMsg = "run:\(data.runInterval)"
        let walkMsg = "walk:\(data.walkInterval)"
        
        self.leftPickerLabel.setText(runMsg)
        self.rightPickerLabel.setText(walkMsg)
    }
}





