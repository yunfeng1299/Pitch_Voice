//
//  RecordViewController.swift
//  Pitch_voice
//
//  Created by 夏琪 on 2017/5/4.
//  Copyright © 2017年 yunfeng. All rights reserved.
//

import UIKit
import AVFoundation

class RecordViewController: UIViewController {

    @IBOutlet weak var StartRecordBtn: UIButton!
    @IBOutlet weak var StatusLabel: UILabel!
    @IBOutlet weak var StopRecordBtn: UIButton!
    
    var audioRecorder:AVAudioRecorder!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        StopRecordBtn.isEnabled = false
        StatusLabel.text = "准备录音"
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func startRecording(_ sender: UIButton) {
        
        StopRecordBtn.isEnabled = true
        StartRecordBtn.isEnabled = false
        StatusLabel.text = "正在录音"
        
        let dirPath = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0] as String
        let recordName = "recordVoice.wav"
        let pathArr = [dirPath,recordName]
        let filePath = URL(string: pathArr.joined(separator: "/"))
        
        let session = AVAudioSession.sharedInstance()
        
        try! session.setCategory(AVAudioSessionCategoryPlayAndRecord, with: .defaultToSpeaker)
        
        try! audioRecorder = AVAudioRecorder(url: filePath!, settings: [:])
        audioRecorder.delegate = self
        audioRecorder.isMeteringEnabled = true
        audioRecorder.prepareToRecord()
        audioRecorder.record()
        
        
        
        
    }

    @IBAction func stopRecording(_ sender: UIButton) {
        
        StartRecordBtn.isEnabled = true
        StopRecordBtn.isEnabled = false
        StatusLabel.text = "录音完成"
        
        audioRecorder.stop()
        let audiosession = AVAudioSession.sharedInstance()
        try! audiosession.setActive(false)
        
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "stopRecording" {
            
            let playSoundsVc = segue.destination as! PlaySoundsViewController
            let audioRecordUrl = sender as! NSURL
            playSoundsVc.audioRecordURL = audioRecordUrl
       
        }
    }
}

extension RecordViewController: AVAudioRecorderDelegate {
    
    func audioRecorderDidFinishRecording(_ recorder: AVAudioRecorder, successfully flag: Bool) {
        if flag {
            performSegue(withIdentifier: "stopRecording", sender: audioRecorder.url)
            print(audioRecorder.url)
        } else {
            
            print("录音不成功")
        }
        
    }
    
    
}

