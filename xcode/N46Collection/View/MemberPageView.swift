//
//  MemberPageView.swift
//  N46Collection
//
//  Created by Jiacheng Sun on 6/18/20.
//  Copyright © 2020 Jiacheng Sun. All rights reserved.
//

import SwiftUI

struct MemberPageView: View {
    @StateObject var memberViewModel: MemberViewModel = MemberViewModel()
    @State var filter: FilterInfo = FilterInfo()
    @State var showingDetail: Bool = false
    @State var vGridLayout = [GridItem(.adaptive(minimum: 170)), GridItem(.adaptive(minimum: 170))]

    var body: some View {
        NavigationView {
            ScrollView {
                VStack {
                    
                    HStack {
                        Spacer()
                        Button(action: {
                            withAnimation(.easeOut) {
                                if self.vGridLayout.count == 2 {
                                    vGridLayout = [GridItem(.flexible(minimum: 250))]
                                }
                            }
                        }) {
                            Image(systemName: self.vGridLayout.count == 1 ?
                                "rectangle.grid.1x2.fill" : "rectangle.grid.1x2")
                        }

                        Divider()

                        Button(action: {
                            withAnimation(.easeOut) {
                                if self.vGridLayout.count == 1 {
                                    vGridLayout = [GridItem(.adaptive(minimum: 170)), GridItem(.adaptive(minimum: 170))]
                                }
                            }
                        }) {
                            Image(systemName: self.vGridLayout.count == 2 ?
                                    "square.grid.2x2.fill" : "square.grid.2x2")
                        }
                    }
                        .font(.title)
                        .padding()

                    MemberPageContentView(memberViewModel: self.memberViewModel, vGridLayout: self.$vGridLayout)
                        .navigationTitle(LocalizedStringKey(filter.statusType.name))
                        .toolbar {
//                            ToolbarItem(placement: .navigationBarLeading) {
//                                NaviagationBarProfileButtonView()
//                            }
//                            ToolbarItem(placement: .na) {
//
//                            }
                            
                            ToolbarItem(placement: .navigationBarTrailing) {
                                NaviagationBarFilterButtonView(showingDetail: self.$showingDetail)
                            }
                        }

                }
            }
        }
            .sheet(isPresented: self.$showingDetail) {
                FilterView(showingDetail: self.$showingDetail, filter: self.$filter, memberViewModel: self.memberViewModel)
            }
            .navigationViewStyle(StackNavigationViewStyle())
    }

}

struct TestView: View {
    var body: some View {
        Text("")
    }
}

struct MemberPageContentView: View {
    @StateObject var memberViewModel: MemberViewModel
    @Binding var vGridLayout: [GridItem]

    var body: some View {
        LazyVGrid(columns: vGridLayout) {
            ForEach(self.memberViewModel.cards) { card in
                CardView(card: card, vGridLayout: self.$vGridLayout)
                .padding()
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
//        .padding()
    }
}

struct NaviagationBarProfileButtonView: View {
    var body: some View {
        Button(action: {
//            print("Profile button is touched!")
        }, label: {
            Image(systemName: "person.circle")
                .font(.system(size: 25))
        })
            .frame(minWidth: 30, maxWidth: .infinity, minHeight: 30)
    }

}

struct NaviagationBarFilterButtonView: View {
    @Binding var showingDetail: Bool

    var body: some View {
        Button(action: {
            print("Filter button is touched!")
            self.showingDetail.toggle()
        }, label: {
            Image(systemName: "line.horizontal.3.decrease")
                .font(.system(size: 25))
        })
            .frame(minWidth: 30, maxWidth: .infinity, minHeight: 30)
    }

}






struct PageView_Previews: PreviewProvider {
    static var previews: some View {
        MemberPageView()
    }
}
