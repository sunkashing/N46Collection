//
//  Array+Identifiable.swift
//  N46Collection
//
//  Created by Jiacheng Sun on 5/28/20.
//  Copyright © 2020 Jiacheng Sun. All rights reserved.
//

import Foundation


extension Array where Element: Identifiable {
    func firstIndex(matching item: Element) -> Int? {
        for index in 0..<self.count {
            if self[index].id == item.id {
                return index
            }
        }
        return nil
    }
}
