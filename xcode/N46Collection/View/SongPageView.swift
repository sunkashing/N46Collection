//
//  SongPageView.swift
//  N46Collection
//
//  Created by Jiacheng Sun on 12/24/20.
//  Copyright © 2020 Jiacheng Sun. All rights reserved.
//

import SwiftUI

struct SongPageView: View {
    @StateObject var songViewModel: SongViewModel = SongViewModel()
    @StateObject var memberViewModel: MemberViewModel
//    @State var filter: FilterInfo = FilterInfo()
//    @State var showingDetail: Bool = false
    @State var vGridLayout = [GridItem(.adaptive(minimum: 170)), GridItem(.adaptive(minimum: 170))]

    var body: some View {
        NavigationView {
            ScrollView {
                SongPageContentView(songViewModel: self.songViewModel, memberViewModel: self.memberViewModel, vGridLayout: self.$vGridLayout)
            }
            .navigationTitle(LocalizedStringKey("歌曲"))
        }
        
        .navigationViewStyle(StackNavigationViewStyle())
    }
}


struct SongPageContentView: View {
    @StateObject var songViewModel: SongViewModel
    @StateObject var memberViewModel: MemberViewModel
    @Binding var vGridLayout: [GridItem]
    

    var body: some View {
        
        // MARK: - single section
        Section {
            VStack(alignment: .leading) {
                HStack {
                    Text(LocalizedStringKey("シングル"))
                        .font(.title2)
                    Spacer()
                    NavigationLink(LocalizedStringKey("すべて見る"), destination: SingleAllView(songViewModel: self.songViewModel, memberViewModel: self.memberViewModel, vGridLayout: self.$vGridLayout))
                }
                    .padding(.horizontal)
                
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack {

                        ForEach(self.songViewModel.cards[0..<7]) { card in
                            if card.content.type == "シングル" {
                                SongView(card: card, memberViewModel: self.memberViewModel)
                            }
                        }
                    }
                    .padding(.horizontal)
                }
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
            }
        }
            .padding(.vertical)
        
        Divider()
            .padding()
        
        
    }
}

struct SingleAllView: View {
    @StateObject var songViewModel: SongViewModel
    @StateObject var memberViewModel: MemberViewModel
    @Binding var vGridLayout: [GridItem]
    
    var body: some View {
        ScrollView {
            LazyVGrid(columns: self.vGridLayout) {
                ForEach(self.songViewModel.cards) { card in
                    SongView(card: card, memberViewModel: self.memberViewModel).padding()
                }
            }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
        }
    }
}

