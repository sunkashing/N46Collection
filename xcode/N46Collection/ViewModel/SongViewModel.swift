//
//  SongViewModel.swift
//  N46Collection
//
//  Created by Jiacheng Sun on 12/24/20.
//  Copyright © 2020 Jiacheng Sun. All rights reserved.
//

import SwiftUI

class SongViewModel: ObservableObject {
    @Published var model: SongModel
    
    init() {
        model = createSongs()
//        model.filterMembers(filter: FilterInfo())
    }

    // MARK: - Access to the model

    var cards: [SongModel.Card] {
        model.displayCards
    }
    
    var singleCards: [SongModel.Card] {
        model.singleCards
    }
    
    var downloadSingleCards: [SongModel.Card] {
        model.downloadSingleCards
    }
    
    var albumCards: [SongModel.Card] {
        model.albumCards
    }
    
    var bestAlbumCards: [SongModel.Card] {
        model.bestAlbumCards
    }

    // MARK: - Intent(s)/

//    func filterMembers(filter: FilterInfo) {
//        model.filterMembers(filter: filter)
//    }
}


func createSongs() -> SongModel {
    let songs: [NogizakaSong] = getInfo()
    return SongModel(numsOfPairsOfCards: songs.count) { pairIndex in
        songs[pairIndex]
    }
}

func getInfo() -> [NogizakaSong] {
    let members = getNogizakaSongJsonData(forName: "nogizaka_songs")!
    return members
}
