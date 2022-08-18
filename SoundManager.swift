//
//  SoundManager.swift
//  CubeTimerV3
//
//  Created by Daniel Madjar on 7/5/22.
//

import SwiftUI
import AVKit

class SoundManager {
    
    static let instance = SoundManager()
    
    var player: AVAudioPlayer?
    
    func playSound(note: String) {
        guard let url = Bundle.main.url(forResource: note, withExtension: ".mp4") else { return }
        
        do {
            player = try AVAudioPlayer(contentsOf: url)
            player?.play()
        } catch let error {
            print("Error playing sound. \(error.localizedDescription)")
        }
       
    }
}
