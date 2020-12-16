//
//  animation.swift
//  N46Collection
//
//  Created by Jiacheng Sun on 6/21/20.
//  Copyright © 2020 Jiacheng Sun. All rights reserved.
//

import SwiftUI

extension View {
    func scaleOnAppear(using animation: Animation = Animation.easeInOut(duration: 0.5), _ action: @escaping () -> Void) -> some View {
        return onAppear {
            withAnimation(animation) {
                action()
            }
        }
    }

    func scaleOnDisappear(using animation: Animation = Animation.easeInOut(duration: 0.5), _ action: @escaping () -> Void) -> some View {
        return onDisappear {
            withAnimation(animation) {
                action()
            }
        }
    }
}

