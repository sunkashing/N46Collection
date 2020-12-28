//
//  PlayerViewModel.swift
//  N46Collection
//
//  Created by Jiacheng Sun on 12/28/20.
//  Copyright © 2020 Jiacheng Sun. All rights reserved.
//

import Foundation
import AVKit

class PlayerViewModel: ObservableObject {
    let player: AVPlayer
    
    init(urlString: String) {
        let url = URL(string: urlString)
        self.player = AVPlayer(playerItem: AVPlayerItem(url: url!))
    }
    
    @Published var isPlaying: Bool = false {

        didSet {
            if isPlaying {
                play()
            } else {
                pause()
            }
        }
    }
        
    func play() {
        let currentItem = player.currentItem
        if currentItem?.currentTime() == currentItem?.duration {
            currentItem?.seek(to: .zero, completionHandler: nil)
        }
        
        player.play()
    }
    
    func pause() {
        player.pause()
    }
    
}
