//
//  MusicControls.swift
//  easyIntervals
//
//  Created by Michael Schaffner on 6/8/17.
//  Copyright © 2017 Michael Schaffner. All rights reserved.
//

import Foundation
import  UIKit
import  MediaPlayer


protocol MusicControlDelegate {
    func hideMusicControls()
    func openMediaPicker()
}

class MusicControls: UIView {
    var delegate: MusicControlDelegate?
    var musicPlayed = false
    var musicPaused = false
    
    lazy var musicPlayer: MPMusicPlayerController = {
        let player = MPMusicPlayerController.systemMusicPlayer()
       
        let everyThing = MPMediaQuery.songs()
        let itemsFromGenericQuery = everyThing.items
        player.setQueue(with: everyThing)
        player.shuffleMode = MPMusicShuffleMode.songs
        player.prepareToPlay()
        return player
    }()
    
    /*
     ]
 
 */
    
    
    
    
    @IBOutlet var buttons: [RoundButton]!
    @IBOutlet var playPauseButton: PlainButton!
    
    //MARK:- LIFECYCLE
    override func didMoveToSuperview() {
        super.didMoveToSuperview()
        backgroundColor = UIColor.clear
    
    }
    
    @IBAction func closeTapped(_ sender: UIButton) {
        hide()
    }
    
    @IBAction func nextTapped(_ sender: UIButton) {
        musicPlayer.skipToNextItem()
    }
    
    @IBAction func previousTapped(_ sender: UIButton) {
        musicPlayer.skipToPreviousItem()
    }
    
    @IBAction func playPauseTapped(_ sender: UIButton) {
       toggleMusic()
    }
    
    @IBAction func chooseTapped(_ sender: UIButton) {
        if let delegate = delegate {
            delegate.openMediaPicker()
        }
    }
    
    
    //MARK :- Methods
    func hide() {
        if let del = delegate {
            del.hideMusicControls()
        } else {
            isHidden = true
        }
    }
    
    func toggleMusic() {
        if musicPlayer.playbackState == MPMusicPlaybackState.playing {
            musicPaused = true
            musicPlayed = false
            musicPlayer.pause()
        }else{
            
            musicPlayed = true
            musicPaused = false
            playMusic()
        }
        setMusicInterface()
    }
    
    func  setMusicInterface() {
        if musicPlayer.playbackState == MPMusicPlaybackState.playing {
            playPauseButton.setImage(UIImage(named: "but_play"), for: UIControlState())
        }else {
            playPauseButton.setImage(UIImage(named: "but_pause"), for: UIControlState())
        }
    }
    
    //MARK: Music
    func playMusic() {
        var doPlay = false
        //music is set to ON
        if data.musicOn {
            if !self.musicPaused {
                doPlay = true
            }
        } else {
            // music set to  OFF
            if self.musicPlayed {
                doPlay = true
            }
        }
        
        if self.musicPlayed {
            doPlay = true
        }
        
        if doPlay {
            musicPlayer.play()
        }
    }

    
    
}


/*
 
 
 
 
 
 
 
 
 @IBAction func buttonPressed(_ sender: AnyObject) {
 MPMediaLibrary.requestAuthorization { (status) in
 if status == .authorized {
 self.runMediaLibraryQuery()
 } else {
 self.displayMediaLibraryError()
 }
 }
 }
 
 func runMediaLibraryQuery() {
 let query = MPMediaQuery.songs()
 if let items = query.items, let item = items.first {
 NSLog("Title: \(item.title)")
 }
 }
 
 func displayMediaLibraryError() {
 var error: String
 switch MPMediaLibrary.authorizationStatus() {
 case .restricted:
 error = "Media library access restricted by corporate or parental settings"
 case .denied:
 error = "Media library access denied by user"
 default:
 error = "Unknown error"
 }
 
 let controller = UIAlertController(title: "Error", message: error, preferredStyle: .alert)
 controller.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
 present(controller, animated: true, completion: nil)
 }
 */


