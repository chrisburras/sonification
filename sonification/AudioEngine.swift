//
//  AudioEngine.swift
//  sonification
//
//  Created by Amit Enand on 3/7/19.
//  Copyright © 2019 Amit Enand. All rights reserved.
//

import Foundation
import AudioKit

// Create a class to handle the audio set up
class AudioEngine {
    
    // Declare your nodes as instance variables
    var player: AKPlayer!
    //var delay: AKDelay!
    //var reverb: AKReverb!
    var file: AKAudioFile!
    var pitchshifter: AKPitchShifter!
    var varispeed: AKVariSpeed!
    
    init() {
        // Set up a player to the loop the file's playback
        do {
            file = try AKAudioFile(readFileName: "yeezy.wav")
        } catch {
            AKLog("File Not Found")
            return
        }
        player = AKPlayer(audioFile: file)
        player.buffering = .always
        player.isLooping = true
        varispeed = AKVariSpeed(player)
        pitchshifter = AKPitchShifter(varispeed)
        AudioKit.output = pitchshifter
        do {
            try AudioKit.start()
        } catch {
            AKLog("AudioKit did not start!")
        }
    }
    func changePitch(y: Double){
        let screenSize: CGRect = UIScreen.main.bounds
        let screenHeight = Double(screenSize.height)
        let newPitch = ((y / screenHeight) * 10) - 8
        pitchshifter.shift = newPitch
    }
    func changeSpeed(x: Double){
        let screenSize: CGRect = UIScreen.main.bounds
        let screenWidth = Double(screenSize.width)
        let newSpeed = ((x / screenWidth) * 1) + 0.55
        print(pitchshifter.shift)
        varispeed.rate = newSpeed
    }
    func stopSound(){
        if player.isPlaying {
            player.stop()
        }
    }
    func startSound(){
        if !player.isPlaying{
            player.play()
        }
    }
}

// Create your engine and start the player


