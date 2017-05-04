//
//  PlaySoundsViewController.swift
//  Pitch_voice
//
//  Created by 夏琪 on 2017/5/4.
//  Copyright © 2017年 yunfeng. All rights reserved.
//

import UIKit
import AVFoundation

class PlaySoundsViewController: UIViewController {
    
    var audioRecordURL:NSURL!
    
    @IBOutlet weak var slowBtn: UIButton!
    @IBOutlet weak var fastBtn: UIButton!
    @IBOutlet weak var echoBtn: UIButton!
    @IBOutlet weak var reverbBTn: UIButton!
    @IBOutlet weak var lowPitchBtn: UIButton!
    @IBOutlet weak var highPitchBtn: UIButton!
    @IBOutlet weak var stopBtn: UIButton!
    
    var recordedAudioURL:URL!
    var audioFile:AVAudioFile?
    var audioEngine:AVAudioEngine!
    var audioPlayerNode: AVAudioPlayerNode!
    var stopTimer: Timer!
    
    enum ButtonType: Int {
        case slow = 0, fast, chipmunk, vader, echo, reverb
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        setupAudio()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        configureUI(.notPlaying)
    }

    @IBAction func playsoundsChick(_ sender: UIButton) {
        
        switch(ButtonType(rawValue: sender.tag)!) {
        case .slow:
            playSound(rate: 0.5)
        case .fast:
            playSound(rate: 1.5)
        case .chipmunk:
            playSound(pitch: 1000)
        case .vader:
            playSound(pitch: -1000)
        case .echo:
            playSound(echo: true)
        case .reverb:
            playSound(reverb: true)
        }
        
        configureUI(.playing)
        
    }

    @IBAction func stopSoundsChick(_ sender: UIButton) {
        
        stopAudio()
    }
   
}
