//
//  SettingViewController.swift
//  easyIntervals
//
//  Created by Michael Schaffner on 1/13/17.
//  Copyright © 2017 Michael Schaffner. All rights reserved.
//

import UIKit

class OLDSettingViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var table: UITableView!
    
    //MARK: - variables
    var preferences: [Preference] =  [ .audio, .vibrate, .cadence, .music, .workout]
    
    override func viewDidLoad() {
        super.viewDidLoad()

       //table.estimatedRowHeight = 100.0
       // table.rowHeight = UITableViewAutomaticDimension
        
        table.estimatedRowHeight = 300
        table.rowHeight = UITableViewAutomaticDimension
    }

    override func viewDidAppear(_ animated: Bool) {
       // table.reloadData()
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return preferences.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! SettingTableViewCell
        let pref = preferences[indexPath.row]
        cell.name.text  = pref.name
        cell.descriptionA.text = "Hey"
        cell.descriptionA.text = "There is some text"
        switch pref {
        case .audio:
            cell.switch.isOn = data.audioOn
        case .vibrate:
            cell.switch.isOn = data.vibrateOn
        case .cadence:
            cell.switch.isOn = data.cadenceOn
        case .music:
            cell.switch.isOn = data.musicOn
        case .workout:
            cell.switch.isOn = data.workoutOn
        default:
            break
        }
        
        cell.slider.isHidden = true
       // cell.slider.removeFromSuperview()
        return cell
        
    }
    
    /*
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
 */
    
    // func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
     //   return UITableViewAutomaticDimension
  // }
    

}
