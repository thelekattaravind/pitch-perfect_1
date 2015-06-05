//
//  RecordSoundViewController.swift
//  Pitch Perfect
//
//  Created by Aravind on 5/25/15.
//  Copyright (c) 2015 Aravind. All rights reserved.
//

import UIKit
import AVFoundation




class RecordSoundViewController: UIViewController, AVAudioRecorderDelegate {

    var recordedAudio:RecordedAudio!
    var audioRecorder:AVAudioRecorder!

    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        Tlabel.hidden=false
        stopRecord.hidden=true
        Rlabel.hidden=true
        recordButton.enabled=true

    }

    @IBOutlet weak var Tlabel: UILabel!
    @IBOutlet weak var recordButton: UIButton!
    @IBOutlet weak var stopRecord: UIButton!
    @IBOutlet weak var Rlabel: UILabel!

    @IBAction func stopRecord(sender: UIButton) {
        Rlabel.hidden=true
        stopRecord.hidden=true
        audioRecorder.stop()
        var audioSession = AVAudioSession.sharedInstance()
        audioSession.setActive(false, error: nil)
    }
    
    @IBAction func recordAudio(sender: UIButton) {
        Rlabel.hidden=false
        stopRecord.hidden=false
        recordButton.enabled=false
        Tlabel.hidden=true
        let dirPath = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)[0] as! String
        var currentDateTime = NSDate()
        var formatter = NSDateFormatter()
        formatter.dateFormat = "ddMMyyyy-HHmmss"
        var recordingName = formatter.stringFromDate(currentDateTime)+".wav"
        var pathArray = [dirPath, recordingName]
        let filePath = NSURL.fileURLWithPathComponents(pathArray)
        var session = AVAudioSession.sharedInstance()
        session.setCategory(AVAudioSessionCategoryPlayAndRecord, error: nil)
        session.overrideOutputAudioPort(AVAudioSessionPortOverride.Speaker, error: nil)
        audioRecorder = AVAudioRecorder(URL: filePath, settings: nil, error: nil)
        audioRecorder.delegate=self
        audioRecorder.meteringEnabled = true
        audioRecorder.prepareToRecord()
        audioRecorder.record()
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if (segue.identifier=="stopRecording"){
            let playsoundsVC:PlaySoundsViewController = segue.destinationViewController as! PlaySoundsViewController
            let data = sender as! RecordedAudio
            playsoundsVC.receivedAudio = data
        }
    }
    
    func audioRecorderDidFinishRecording(recorder: AVAudioRecorder!, successfully flag: Bool) {
        if(flag){
            recordedAudio = RecordedAudio(title: recorder.url.lastPathComponent!,filePathURL: recorder.url!)
            self.performSegueWithIdentifier("stopRecording", sender: recordedAudio)
        }else{
            recordButton.enabled=true
            stopRecord.hidden=true
        }
    }
}

