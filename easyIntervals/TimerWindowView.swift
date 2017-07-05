


/*
 import AudioToolbox
 import AVFoundation
 import MediaPlayer
  import WatchConnectivity
 
 var musicPlayed = false
 var musicPaused = false
 
 lazy var musicPlayer: MPMusicPlayerController = {
 let player = MPMusicPlayerController.systemMusicPlayer()
 let everyThing = MPMediaQuery()
 let itemsFromGenericQuery = everyThing.items
 player.setQueue(with: everyThing)
 player.shuffleMode = MPMusicShuffleMode.songs
 return player
 }()
 
  //MARK:- Life cycle functions
 //---------------
 override func viewDidLoad() {
 super.viewDidLoad()
 
 setWatchSession()
 }
 
 
 //---------------
 @IBAction func musicPlayTapped()
 {
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
 
 //---------------
 @IBAction func musicFwdTapped()
 {
 musicPlayer.skipToNextItem()
 }
 
 //---------------
 @IBAction func musicBackTapped()
 {
 musicPlayer.skipToPreviousItem()
 }
 
 //---------------
 @IBAction func musicMenuTapped()
 {
 let mediaPicker = MPMediaPickerController(mediaTypes: MPMediaType.any)
 mediaPicker.delegate = self
 mediaPicker.allowsPickingMultipleItems = true
 mediaPicker.prompt = "Pick songs to play"
 present(mediaPicker, animated: true, completion: nil)
 }
 
 //MARK My Functions
 //---------------
 
 //---------------
 func initAudio()
 {
 let audioSession = AVAudioSession.sharedInstance()
 do {
 try audioSession.setCategory(AVAudioSessionCategoryPlayback)
 } catch _ {
 }
 do {
 try audioSession.setActive(true)
 } catch _ {
 }
 do {
 try audioSession.setMode(AVAudioSessionModeDefault)
 } catch _ {
 }
 var success: Bool
 do {
 try audioSession.setCategory(AVAudioSessionCategoryPlayback)
 success = true
 } catch _ {
 success = false
 }
 
 do {
 try audioSession.setCategory(AVAudioSessionCategoryPlayback, with:AVAudioSessionCategoryOptions.duckOthers)
 
 } catch let error as NSError {
 print("Could not set the audio session \(error)")
 }
 do {
 try audioSession.setActive(true)
 } catch _ {
 }
 if success {
 // println("Success")
 }else{
 print("InitAudio Fail")
 }
 self.registerMediaPlayerNotifications()
 }
 
 
 //CONTINUE
 //---------------
 func pauseWorkout()
 {

 
 setWatchState(phoneState: "pause")
 
 }
 
 }
 
 //---------------
 func resumeWorkout()
 {

    setWatchState(phoneState: "resume")
 }
 
 
 
 
 //MARK: Music
 func playMusic() {
 var doPlay = false
 //music is set to ON
 if prefs.audioOn {
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
 
 //------------
 func setMusicInterface()
 {
 
 if musicPlayer.playbackState == MPMusicPlaybackState.playing {
 musicButton.setImage(UIImage(named: "but_pause"), for: UIControlState())
 }else {
 musicButton.setImage(UIImage(named: "but_play"), for: UIControlState())
 }
 }
 
 
 func registerMediaPlayerNotifications()
 {
 /*
 let notificationCenter = NotificationCenter.default
 notificationCenter.addObserver(self, selector: #selector(CenterViewController.handle_NowPlayingItemChanged), name: NSNotification.Name.MPMusicPlayerControllerNowPlayingItemDidChange, object: self.musicPlayer)
 notificationCenter.addObserver(self, selector: #selector(CenterViewController.handle_PlaybackStateChanged), name: NSNotification.Name.MPMusicPlayerControllerPlaybackStateDidChange, object: self.musicPlayer)
 notificationCenter.addObserver(self, selector: #selector(CenterViewController.handle_VolumeChanged), name: NSNotification.Name.MPMusicPlayerControllerVolumeDidChange, object: self.musicPlayer)
 
 musicPlayer.beginGeneratingPlaybackNotifications()
 */
 }
 
 
 func handle_PlaybackStateChanged()
 {
 
 
 //---------------
 func handle_NowPlayingItemChanged(){
 
 }
 setMusicInterface()
 }
 
 func handle_VolumeChanged() {
 
 }
 
 //-------------
 func toggleMusicControlView()
 {
 var setting = musicViewBottomConstraint.constant
 if setting < 5 {
 setting = 5
 }else{
 setting =  -musicControlView.frame.height
 }
 UIView.animate(withDuration: 0.25, delay: 0.0, options: UIViewAnimationOptions.curveEaseOut, animations: { () -> Void in
 self.musicViewBottomConstraint.constant = setting
 self.view.layoutIfNeeded()
 }, completion: nil)
 self.setMusicInterface()
 }
 
 //---------------
 //MARK: Distance
 
 /*
 func startLocationTracking()
 {
 locationManager.startUpdatingLocation()
 }
 
 func stopLocationTracking()
 {
 locationManager.stopUpdatingLocation()
 }
 
 func locationManager(manager: CLLocationManager, didFailWithError error: NSError) {
 //  manager.stopUpdatingLocation()
 //if let e = error {
 // self.distanceLabel.text = e.description
 // }
 }
 
 func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
 // distanceLabel.text = "\(locations[0])"
 myLocations.append(locations[0] )
 
 if myLocations.count > 1 {
 let sourceIndex = myLocations.count - 1
 let destinationIndex =  myLocations.count - 2
 let dist = myLocations[sourceIndex].distanceFromLocation(myLocations[destinationIndex])
 
 if let wo = workout {
 wo.trackDistance(dist)
 }
 }
 } */
 }
 
 //MARK:- TitleDelegate methods
 extension CenterViewController: TitleDelegate
 {
 func titleLoaded() {
 requestPermissions()
 }
 
 //called when titleView sequence is complete
 func titleSequenceComplete()
 {
 workout = nil;
 runnerSequenceView.isHidden = false
 UIApplication.shared.isIdleTimerDisabled = true
 toggleInterface(true)
 startWorkOut()
 }
 }
 
 //MARK:- Workout delegate methods
 extension CenterViewController: WorkoutDelegate
 {
 //--------------------
 func intervalChanged()
 {
 var soundName:String?
 var slideWord = ""
 
 guard let work = workout else {
 return
 }
 
 slideWord = work.mode.rawValue
 
 
 switch work.mode {
 case .warmup:
 soundName = prefs.openingMessage
 self.showView(clock)
 self.showProgressView()
 case .cooldown:
 soundName = "whew, time to cooldown"
 self.showView(clock)
 case .speed:
 let msg = prefs.startSpeedMessage
 soundName = "speed, \(msg)"
 self.hideView(clock)
 case .recovery:
 let msg = prefs.startRecoverMessage
 soundName = "recovery, \(msg)";
 self.hideView(clock)
 default:
 break
 }
 
 //if sound is defined play it
 if let sn = soundName {
 sayThis(sn)
 }
 
 if slideWord != "" {
 runnerSequenceView.advanceAnimation(slideWord)
 }
 letterAnimationView.slideWordIn(slideWord)
 //MESSAGE WATCH
 updateWatch(mode: slideWord)
 }
 
 //----------
 func postHint(_ message: String) {
 hintButton.isEnabled = true
 hintAnimationView.triggerHint(message)
 }
 
 //--------------------
 func workOutComplete()
 {
 //allow phone to sleep
 UIApplication.shared.isIdleTimerDisabled = false
 
 if musicPlayer.playbackState == MPMusicPlaybackState.playing {
 self.musicPlayer.pause()
 }
 
 guard let workout = workout else {
 return
 }
 
 if workout.values.count > 0 {
 //Workout stopped by user
 sayThis("Workout ended")
 //MESSAGE WATCH
 } else {
 sayThis(prefs.closingMessage)
 //MESSAGE WATCH
 }
 
 toggleInterface(false)
 //stopLocationTracking()
 runnerSequenceView.complete()
 letterAnimationView.clearWord()
 hideView(progressView)
 hideView(clock)
 //MESSAGE WATCH
 updateWatch(mode: "complete")
 
 guard let containerVC = delegate else {
 return
 }
 containerVC.recapWorkout!(workout: workout)
 }
 
 //---------------
 func workOutTick(secondsElapsed: Int, countDown: Bool, vibrate: Bool, progress: ProgressValues)
 {
 if !clock.isHidden {
 clock.tick(secondsElapsed)
 }
 
 if !progressView.isHidden {
 progressView.update(progress: progress)
 }
 
 if countDown {
 let secs:String = "\(secondsElapsed)"
 sayThis(secs)
 if vibrate {
 AudioServicesPlaySystemSound(1352)
 }
 }
 }
 
 //MARK:- WATCH Methods
 func setWatchSession() {
 if WCSession.isSupported() {
 let session = WCSession.default()
 session.delegate = self
 session.activate()
 }
 }
 
 func updateWatch(mode: String) {
 let session = WCSession.default()
 
 if session.activationState == .activated {
 let modeData = ["mode": mode]
 session.transferUserInfo(modeData)
 }
 }
 
 func setWatchState(phoneState: String) {
 let session = WCSession.default()
 
 if session.activationState == .activated {
 let stateData = ["state": phoneState]
 session.transferUserInfo(stateData)
 }
 }
 
 func sendHint(setting: Hint) {
 let session = WCSession.default()
 let hintData = ["hint": setting.rawValue]
 session.transferUserInfo(hintData)
 }
 
 
 func sendDictionary(dict: [String: String]) {
 let session = WCSession.default()
 
 if session.activationState == .activated {
 let dictData = ["dict": dict]
 session.transferUserInfo(dictData)
 }
 }
 
 
 func handleWatchChange(watchState: String) {
 switch watchState {
 case SharedState.start.rawValue:
 if workout == nil {
 titleScreenView.goTapped()
 }
 case SharedState.pause.rawValue:
 if workout != nil {
 pauseWorkout()
 }
 case SharedState.resume.rawValue:
 if workout != nil {
 cancelAlertController.dismiss(animated: true, completion: {
 self.resumeWorkout()
 })
 }
 
 case "skip":
 guard  let wo = workout else {
 return
 }
 
 if wo.activeInterval!.isWarmUp {
 skipWarmup()
 }
 
 if wo.activeInterval!.isCoolDown {
 skipCooldown()
 }
 
 case SharedState.end.rawValue:
 guard  let wo = workout else {
 return
 }
 wo.quit()
 self.workout = nil
 UIApplication.shared.isIdleTimerDisabled = false
 case SharedState.reset.rawValue:
 guard let delegate = delegate else {
 return
 }
 delegate.toggleRightPanel!()
 
 if  !titleScreenView.isDescendant(of: self.view) {
 self.initTitle()
 }
 default:
 break
 }
 }
 
 
 //MARK:- MediaPicker Celegate
 extension CenterViewController: MPMediaPickerControllerDelegate {
 func mediaPicker(_ mediaPicker: MPMediaPickerController, didPickMediaItems mediaItemCollection: MPMediaItemCollection) {
 /*
 let mc = mediaItemCollection
 musicPlayer.setQueue(with: mc)
 playMusic()
 
 //mediaPicker.dismissViewControllerAnimated(true, completion: nil)
 
 mediaPicker.dismiss(animated: true) {
 self.runnerSequenceView.restartAnimation(self)
 }
 */
 }
 
 //---------------
 func mediaPickerDidCancel(_ mediaPicker: MPMediaPickerController) {
 // mediaPicker.dismissViewControllerAnimated(true, completion: nil)
 mediaPicker.dismiss(animated: true) {
 self.runnerSequenceView.restartAnimation(self)
 }
 }
 
 func handleAudioSessionInterruption(_ notification :Notification){
 
 }
 
 }
 
 extension CenterViewController: WCSessionDelegate {
 func session(_ session: WCSession, activationDidCompleteWith activationState: WCSessionActivationState, error: Error?) {
 if activationState == .activated {
 if session.isWatchAppInstalled {
 print("WATCH APP INSTALLED")
 }
 }
 }
 
 func sessionDidBecomeInactive(_ session: WCSession) {
 
 }
 
 func sessionDidDeactivate(_ session: WCSession) {
 WCSession.default().activate()
 }
 
 func session(_ session: WCSession, didReceiveUserInfo userInfo: [String : Any] = [:]) {
 if let watchState = userInfo["watchState"] as? String{
 DispatchQueue.main.async {
 self.handleWatchChange(watchState: watchState)
 }
 }
 
 if let hintState = userInfo["hint"] as? String {
 DispatchQueue.main.async {
 self.handleHintChange(hintState: hintState)
 }
 }
 }
 }
 
 
 
 
 
 
 
 
 

 */
