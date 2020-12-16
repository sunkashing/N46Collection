//
//  Cardify.swift
//  N46Collection
//
//  Created by Jiacheng Sun on 6/18/20.
//  Copyright © 2020 Jiacheng Sun. All rights reserved.
//

import SwiftUI

struct Cardify: ViewModifier {

    @ViewBuilder
    func body(content: Content) -> some View {
        ZStack {
            content
        }
    }

    // MARK: - Drawing Constants

    private let cornerRadius: CGFloat = 10.0
    private let edgeLineWidth: CGFloat = 3
    private let fontScaleFactor: CGFloat = 0.75
}

extension View {
    func cardify() -> some View {
        self.modifier(Cardify())
    }
}
