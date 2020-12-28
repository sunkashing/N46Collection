import SwiftUI
import AVKit

struct SongPlayView: View {
    @ObservedObject var playerViewModel: PlayerViewModel
    
    init(urlString: String) {
        self.playerViewModel = PlayerViewModel(urlString: urlString)
    }
    
   
    var body: some View {
        Button(action: {
            self.playerViewModel.isPlaying.toggle()
        }, label: {
            Image(systemName: self.playerViewModel.isPlaying ? "pause.circle.fill" : "play.circle.fill")
        })
    }
    
}


