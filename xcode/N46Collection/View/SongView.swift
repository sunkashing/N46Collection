//
//  SongView.swift
//  N46Collection
//
//  Created by Jiacheng Sun on 12/24/20.
//  Copyright © 2020 Jiacheng Sun. All rights reserved.
//

import SwiftUI

struct SongView: View {
    var card: SongModel.Card
    @State var showingDetail = false
    
    var body: some View {
        VStack(alignment: .leading) {
            Button(action: {
                self.showingDetail.toggle()
            }, label: {
                Image(self.card.content.cover_name[0])
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .cornerRadius(5)
                    .frame(maxWidth: 170)
            })
            
            Text(LocalizedStringKey(card.content.title))
                .font(.footnote)
                .lineLimit(1)
            Text(LocalizedStringKey(card.content.release_date))
                .font(.caption)
                .opacity(0.5)
                .lineLimit(1)
        }
    }
        
//        Text("Hello")
    }


