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
    
    var body: some View {
        Text(LocalizedStringKey(card.content.title))
//        Text("Hello")
    }
}

