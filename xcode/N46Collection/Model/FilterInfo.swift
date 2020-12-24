//
//  FilterInfo.swift
//  N46Collection
//
//  Created by Jiacheng Sun on 6/20/20.
//  Copyright © 2020 Jiacheng Sun. All rights reserved.
//

import Foundation
import SwiftUI

struct FilterInfo {
    enum StatusType: CaseIterable, Hashable, Identifiable {
        case all
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

        var id: UUID {
            UUID()
        }

        var name: String {
            switch self {
            case .all:
                return "全部メンバー"
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
        
            }
        }
    }
    
    enum ColorType: CaseIterable, Hashable, Identifiable {
        case all
        case red
        case yellow
        case cyan
        case green
        case blue
        case pink
        case purple
        case white
        case black
        case orange
        case chartreuse

        var id: UUID {
            UUID()
        }

        var color: Color {
            switch self {
            case .all:
                return Color(.secondarySystemBackground)
            case .red:
                return Color(.sRGB, red: 1, green: 0, blue: 0)
            case .yellow:
                return Color.yellow
            case .cyan:
                return Color(UIColor.cyan)
            case .green:
                return Color(.sRGB, red: 0, green: 1, blue: 0)
            case .blue:
                return Color(.sRGB, red: 0, green: 0, blue: 1)
            case .pink:
                return Color(.sRGB, red: 1, green: 0.4, blue: 0.7)
            case .purple:
                return Color(.sRGB, red: 0.5, green: 0, blue: 0.5)
            case .white:
                return Color.white
            case .black:
                return Color.black
            case .orange:
                return Color.orange
            case .chartreuse:
                return Color.init(red: 0.5, green: 1, blue: 0)
            }
        }
        
        var name: String {
            switch self {
            case .all:
                return "all"
            case .red:
                return "red"
            case .yellow:
                return "yellow"
            case .cyan:
                return "cyan"
            case .green:
                return "green"
            case .blue:
                return "blue"
            case .pink:
                return "pink"
            case .purple:
                return "purple"
            case .white:
                return "white"
            case .black:
                return "black"
            case .orange:
                return "orange"
            case .chartreuse:
                return "chartreuse"
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
    
    var colorType: ColorType = .all

}
