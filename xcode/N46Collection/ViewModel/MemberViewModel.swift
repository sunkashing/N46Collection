//
//  MemberViewModel.swift
//  N46Collection
//
//  Created by Jiacheng Sun on 6/29/20.
//  Copyright © 2020 Jiacheng Sun. All rights reserved.
//

import SwiftUI

class MemberViewModel: ObservableObject {
    @Published var model: MemberModel

    init() {
        model = createMembers()
        model.filterMembers(filter: FilterInfo())
    }

    // MARK: - Access to the model

    var cards: [MemberModel.Card] {
        model.displayCards
    }

    // MARK: - Intent(s)

    func choose(card: MemberModel.Card) {
        model.choose(card: card)
    }

    func filterMembers(filter: FilterInfo) {
        model.filterMembers(filter: filter)
    }

}

func createMembers() -> MemberModel {
    let members: [NogizakaMember] = getInfo()
    return MemberModel(numsOfPairsOfCards: members.count) { pairIndex in
        members[pairIndex]
    }
}

func getInfo() -> [NogizakaMember] {
    let members = getJsonData()!
    return members
}
