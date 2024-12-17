//
//  MusicManager.swift
//  ABC_Vision
//
//  Created by Wylan L Neely on 10/5/24.
//

import AVFoundation

class MusicPlayerManager: NSObject, AVAudioPlayerDelegate {
    
    static let shared = MusicPlayerManager()
    
    var audioPlayer: AVAudioPlayer?
    
    override private init() {}
    
    func startBackgroundMusic() {
        let audioSession = AVAudioSession.sharedInstance()
        
        do {
            // Set up audio session to play audio even in silent mode
            try audioSession.setCategory(.playback, mode: .default, options: [.mixWithOthers])
            try audioSession.setActive(true)
        } catch {
            print("Failed to set audio session category or activate it.")
        }
        
        if let path = Bundle.main.path(forResource: "SpaceSong2", ofType: "wav") {
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
    
    func playSoundFileNamed(name: String) {
        playSoundWith(name: name)
    }
    
    private func playSoundWith(name: String) {
        do {
            try AVAudioSession.sharedInstance().setCategory(.playback, mode: .default)
            try AVAudioSession.sharedInstance().setActive(true)
        } catch {
            print("Failed to set audio session category:", error)
        }
        if let soundURL = Bundle.main.url(forResource: name, withExtension: "mp3") {
            do {
                audioPlayer = try AVAudioPlayer(contentsOf: soundURL)
                audioPlayer?.prepareToPlay()
                audioPlayer?.play()
            } catch {
                print("Error: Could not load sound file.")
            }
        } else {
            print("Error: Sound file not found.")
        }
    }
    
    
    func playSoundWithWavFile(name: String) {
        do {
            try AVAudioSession.sharedInstance().setCategory(.playback, mode: .default)
            try AVAudioSession.sharedInstance().setActive(true)
        } catch {
            print("Failed to set audio session category:", error)
        }
        if let soundURL = Bundle.main.url(forResource: name, withExtension: "wav") {
            do {
                audioPlayer = try AVAudioPlayer(contentsOf: soundURL)
                audioPlayer?.prepareToPlay()
                audioPlayer?.play()
            } catch {
                print("Error: Could not load sound file.")
            }
        } else {
            print("Error: Sound file not found.")
        }
    }
    
    //Completion Area
    

   func playSoundWithCompletion(name: String, completion: @escaping () -> Void) {
            do {
                try AVAudioSession.sharedInstance().setCategory(.playback, mode: .default)
                try AVAudioSession.sharedInstance().setActive(true)
            } catch {
                print("Failed to set audio session category:", error)
            }
            if let soundURL = Bundle.main.url(forResource: name, withExtension: "mp3") {
                do {
                    audioPlayer = try AVAudioPlayer(contentsOf: soundURL)
                    audioPlayer?.prepareToPlay()
                    audioPlayer?.play()
                    completion()
                } catch {
                    print("Error: Could not load sound file.")
                }
            } else {
                print("Error: Sound file not found.")
            }
        }

    func audioPlayerDidFinishPlaying(_ player: AVAudioPlayer, successfully flag: Bool) {
            // Only call the completion handler if it's set
         //   self.completionHandler?()
            
            // After the completion is called, clear the handler to avoid retain cycles
        
    }
}
