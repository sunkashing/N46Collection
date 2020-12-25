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
//            MemberSearchView(view: MemberPageView())
            MemberPageView(memberViewModel: self.memberViewModel)
//                .ignoresSafeArea()
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
    }
}










struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
