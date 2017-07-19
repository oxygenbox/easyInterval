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
    func displayMediaLibraryError()
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
        checkMediaLibraryAccess()
        
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

    func checkMediaLibraryAccess() {
        print("testAccess")
        switch MPMediaLibrary.authorizationStatus() {
        case .notDetermined:
            MPMediaLibrary.requestAuthorization({(newPermissionStatus: MPMediaLibraryAuthorizationStatus) in
                if newPermissionStatus == .authorized {
                    self.openMediaPicker()
                }
            })
        case .denied, .restricted:
            if let d  = self.delegate {
                d.displayMediaLibraryError()
            }
        default:
            self.openMediaPicker()
        }
    }
    
    func openMediaPicker(){
        print("Open Picker")
        if let delegate = delegate {
            delegate.openMediaPicker()
        }
    }
    
    
    
}


/*
 func exampleMethod() {
 if #available(iOS 9.3, *) {
 let authorizationStatus = MPMediaLibrary.authorizationStatus()
 switch authorizationStatus {
 case .NotDetermined:
 // Show the permission prompt.
 MPMediaLibrary.requestAuthorization({[weak self] (newAuthorizationStatus: MPMediaLibraryAuthorizationStatus) in
 // Try again after the prompt is dismissed.
 self?.exampleMethod()
 })
 case .Denied, .Restricted:
 // Do not use MPMediaQuery.
 return
 default:
 // Proceed as usual.
 break
 }
 }
 // Do stuff with MPMediaQuery here...
 }
 */


