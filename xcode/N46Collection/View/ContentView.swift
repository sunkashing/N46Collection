//
//  ContentView.swift
//  N46Collection
//
//  Created by Jiacheng Sun on 5/19/20.
//  Copyright © 2020 Jiacheng Sun. All rights reserved.
//

import SwiftUI

struct ContentView: View {

    var body: some View {

        TabView {
            MemberPageView()
                .tabItem {
                    Image(systemName: "person.3")
                        .font(.headline)
                    Text("メンバー")
                }

            Text("news")
                .tabItem {
                    Image(systemName: "bell")
                        .font(.headline)
                    Text("ニュース")
                }
        }
            .accentColor(Color(.systemPurple))
    }
}










struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}