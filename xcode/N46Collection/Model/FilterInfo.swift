//
//  FilterInfo.swift
//  N46Collection
//
//  Created by Jiacheng Sun on 6/20/20.
//  Copyright © 2020 Jiacheng Sun. All rights reserved.
//

import Foundation

struct FilterInfo {
    enum StatusType: CaseIterable, Hashable, Identifiable {
        case gen1
        case gen2
        case gen3
        case gen4
        case abroad
        case elected
        case core
        case under
        case captain
        case present
        case past
        case all

        var id: UUID {
            UUID()
        }

        var name: String {
            switch self {
            case .gen1:
                return "1期生"
            case .gen2:
                return "2期生"
            case .gen3:
                return "3期生"
            case .gen4:
                return "4期生"
            case .abroad:
                return "交換留学生"
            case .elected:
                return "選抜メンバー"
            case .core:
                return "十一福神"
            case .under:
                return "アンダー"
            case .captain:
                return "キャプテン"
            case .present:
                return "現メンバー"
            case .past:
                return "元メンバー"
            case .all:
                return "全部メンバー"
            }
        }
    }

    enum RankType: CaseIterable, Hashable, Identifiable {
        case age
        case height
        case name

        var id: UUID {
            UUID()
        }

        var name: String {
            switch self {
            case .age:
                return "年齢"
            case .height:
                return "身長"
            case .name:
                return "五十音順"
            }
        }
    }

    enum RankOrder: CaseIterable, Hashable, Identifiable {
        case low
        case high

        var id: UUID {
            UUID()
        }

        var name: String {
            switch self {
            case .low:
                return "低い順番"
            case .high:
                return "高い順番"
            }
        }
    }
    var statusType: StatusType = .all

    var rankType: RankType = .name

    var rankOrder: RankOrder = .low

}
