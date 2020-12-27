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
        VStack {
            // MARK: - single section
            SongSectionView(memberViewModel: self.memberViewModel, vGridLayout: self.$vGridLayout, type: "シングル", cards: self.songViewModel.singleCards)
            
            Divider()
                .padding()
            
            // MARK: - download single section
            SongSectionView(memberViewModel: self.memberViewModel, vGridLayout: self.$vGridLayout, type: "配信シングル", cards: self.songViewModel.downloadSingleCards)
            
            Divider()
                .padding()
            
            // MARK: - album section
            SongSectionView(memberViewModel: self.memberViewModel, vGridLayout: self.$vGridLayout, type: "アルバム", cards: self.songViewModel.albumCards)
            
            Divider()
                .padding()
            
            // MARK: - best album section
            SongSectionView(memberViewModel: self.memberViewModel, vGridLayout: self.$vGridLayout, type: "ベストアルバム", cards: self.songViewModel.bestAlbumCards)
        }
        
        
    }
}

struct SongSectionView: View {
    @StateObject var memberViewModel: MemberViewModel
    @Binding var vGridLayout: [GridItem]
    let type: String
    var cards: [SongModel.Card]
    

    var body: some View {
        Section {
            VStack(alignment: .leading) {
                HStack {
                    Text(LocalizedStringKey(self.type))
                        .font(.title2)
                    Spacer()
                    NavigationLink(LocalizedStringKey("すべて見る"), destination: SongAllView(memberViewModel: self.memberViewModel, vGridLayout: self.$vGridLayout, cards: self.cards, type: self.type))
                }
                    .padding(.horizontal)
                
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack {
                        if self.cards.count > 6 {
                            ForEach(cards[0..<7]) { card in
                                SongView(card: card, memberViewModel: self.memberViewModel)
                            }
                        } else {
                            ForEach(cards) { card in
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
    }
}

struct SongAllView: View {
    @StateObject var memberViewModel: MemberViewModel
    @Binding var vGridLayout: [GridItem]
    var cards: [SongModel.Card]
    let type: String
    
    var body: some View {
        ScrollView {
            LazyVGrid(columns: self.vGridLayout) {
                ForEach(self.cards) { card in
                    SongView(card: card, memberViewModel: self.memberViewModel).padding()
                }
            }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
        }
            .navigationTitle(LocalizedStringKey(self.type))
    }
}

