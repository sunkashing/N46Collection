//
//  ContentView.swift
//  N46Collection
//
//  Created by Jiacheng Sun on 5/19/20.
//  Copyright © 2020 Jiacheng Sun. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    @StateObject var memberViewModel: MemberViewModel = MemberViewModel()

    var body: some View {

        TabView {
            MemberPageView(memberViewModel: self.memberViewModel)
                .tabItem {
                    Image(systemName: "person.3")
                        .font(.headline)
                    Text(LocalizedStringKey("メンバー"))
                }

            SongPageView(memberViewModel: self.memberViewModel)
                .tabItem {
                    Image(systemName: "tv.music.note")
                        .font(.headline)
                    Text(LocalizedStringKey("歌曲"))
                }

            Text("news")
                .tabItem {
                    Image(systemName: "bell")
                        .font(.headline)
                    Text(LocalizedStringKey("ニュース"))
                }
        }
        .accentColor(Color(.systemPurple))
        
        
        
//        SongPlayView(urlString: "https://audio-ssl.itunes.apple.com/itunes-assets/AudioPreview114/v4/93/87/e7/9387e703-ed13-77a8-760b-4e9100719878/mzaf_12268154826110021361.plus.aac.p.m4a").navigationBarTitle("Music Player")
    }
}










struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
