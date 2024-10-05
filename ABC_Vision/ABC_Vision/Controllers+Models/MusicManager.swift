//
//  MusicManager.swift
//  ABC_Vision
//
//  Created by Wylan L Neely on 10/5/24.
//

import AVFoundation

class MusicPlayerManager {
    
    static let shared = MusicPlayerManager()
    
    var audioPlayer: AVAudioPlayer?
    
    private init() {} // This prevents others from creating an instance of this class

    func startBackgroundMusic() {
        let audioSession = AVAudioSession.sharedInstance()
        
        do {
            // Set up audio session to play audio even in silent mode
            try audioSession.setCategory(.playback, mode: .default, options: [.mixWithOthers])
            try audioSession.setActive(true)
        } catch {
            print("Failed to set audio session category or activate it.")
        }
        
        if let path = Bundle.main.path(forResource: "SpaceSong1", ofType: "wav") {
            let url = URL(fileURLWithPath: path)
            
            do {
                audioPlayer = try AVAudioPlayer(contentsOf: url)
                audioPlayer?.numberOfLoops = -1 // Loop indefinitely
                audioPlayer?.play()
            } catch {
                print("Error: Could not play the sound file.")
            }
        }
    }
    
    func stopBackgroundMusic() {
        audioPlayer?.stop()
    }
    
    func isPlaying() -> Bool {
        return audioPlayer?.isPlaying ?? false
    }
}
