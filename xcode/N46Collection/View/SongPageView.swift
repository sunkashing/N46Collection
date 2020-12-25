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
//    @State var filter: FilterInfo = FilterInfo()
//    @State var showingDetail: Bool = false
    @State var vGridLayout = [GridItem(.adaptive(minimum: 170)), GridItem(.adaptive(minimum: 170))]

    var body: some View {
        NavigationView {
            ScrollView {
                SongPageContentView(songViewModel: self.songViewModel, vGridLayout: self.$vGridLayout)
//                Text("hello")
            }
        }
    }
}


struct SongPageContentView: View {
    @StateObject var songViewModel: SongViewModel
    @Binding var vGridLayout: [GridItem]

    var body: some View {
        LazyVGrid(columns: self.vGridLayout) {
            ForEach(self.songViewModel.cards) { card in
                SongView(card: card).padding()
//                Text("Hello")
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}

