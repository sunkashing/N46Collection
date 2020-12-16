//
//  MemberModel.swift
//  N46Collection
//
//  Created by Jiacheng Sun on 6/29/20.
//  Copyright © 2020 Jiacheng Sun. All rights reserved.
//

import Foundation

struct MemberModel {
    private(set) var cards: [Card]

    var displayCards: [Card] {
        cards.filter {
            !$0.isHidden
        }
    }

    mutating func choose(card: Card) {
        //        print("\(card) is chosen!")
        let index = self.cards.firstIndex(matching: card)
        cards[index!].flipFace()
    }

    mutating func hide(card: Card) {
        //        print("\(card) is hide!")
        let index = self.cards.firstIndex(matching: card)
        cards[index!].hide()
    }

    mutating func display(card: Card) {
        //        print("\(card) is displayed!")
        let index = self.cards.firstIndex(matching: card)
        cards[index!].display()
    }

    mutating func sortCard(by: (Card, Card) -> Bool) {
        cards.sort(by: by)
    }


    mutating func filterMembers(filter: FilterInfo) {
        for card in self.cards {
            if filter.statusType != FilterInfo.StatusType.all {
                if !card.content.member_info.status.contains(filter.statusType.name) {
                    if filter.statusType == FilterInfo.StatusType.present {
                        if card.content.member_info.status.contains("元メンバー") {
                            self.hide(card: card)
                        } else {
                            self.display(card: card)
                        }
                    } else {
                        self.hide(card: card)
                    }
                } else {
                    self.display(card: card)
                }
            } else {
                self.display(card: card)
            }
        }

        if filter.rankOrder == FilterInfo.RankOrder.low {
            // MARK: - Sort from low to high
            if filter.rankType == FilterInfo.RankType.name {
                self.sortCard(by: {
                    $0.content.member_info.infos.hiragana_name < $1.content.member_info.infos.hiragana_name
                })
            } else if filter.rankType == FilterInfo.RankType.age {
                self.sortCard(by: {
                    
                    return $0.content.member_info.infos.birthday > $1.content.member_info.infos.birthday
                })
            } else {
                self.sortCard(by: {
                    $0.content.member_info.infos.height < $1.content.member_info.infos.height
                })
            }
        } else {
            // MARK: - Sort from high to low
            if filter.rankType == FilterInfo.RankType.name {
                self.sortCard(by: {
                    $0.content.member_info.infos.hiragana_name > $1.content.member_info.infos.hiragana_name
                })
            } else if filter.rankType == FilterInfo.RankType.age {
                self.sortCard(by: {
                    $0.content.member_info.infos.birthday < $1.content.member_info.infos.birthday
                })
            } else {
                self.sortCard(by: {
                    $0.content.member_info.infos.height > $1.content.member_info.infos.height
                })
            }

        }
    }

    init(numsOfPairsOfCards: Int, cardContentFactory: (Int) -> NogizakaMember) {
        self.cards = [Card]()
        for pairIndex in 0..<numsOfPairsOfCards {
            let content = cardContentFactory(pairIndex)
            self.cards.append(Card(content: content, id: pairIndex))
        }

    }


    struct Card: Identifiable {
        var isFaceUp: Bool = true
        var isMatched: Bool = false
        var isHidden = false

        var content: NogizakaMember
        var id: Int

        mutating func flipFace() {
            isFaceUp.toggle()
        }

        mutating func hide() {
            isHidden = true
        }

        mutating func display() {
            isHidden = false
        }
    }
}
