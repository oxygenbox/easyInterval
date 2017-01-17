//
//  SettingsCell.swift
//  easyIntervals
//
//  Created by Michael Schaffner on 1/16/17.
//  Copyright © 2017 Michael Schaffner. All rights reserved.
//

import UIKit

class SettingsCell: UITableViewCell {
    
    @IBOutlet weak var bgView: UIView!
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var desc: UILabel!
    @IBOutlet weak var prefSwitch: UISwitch!
    
    var pref: Preference!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setUp(preference:Preference, switchSetting: Bool) {
        backgroundColor = UIColor.clear
        bgView.backgroundColor = UIColor.off
        bgView.layer.cornerRadius = 4
        bgView.clipsToBounds = true
        /*
        
        
        
        self.pref = preference
        self.title.text = preference.name
        self.desc.text = preference.desc
        prefSwitch.tag = preference.rawValue
        prefSwitch.isOn = switchSetting
        */
    }

}
