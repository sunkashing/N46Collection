//
//  FilterView.swift
//  N46Collection
//
//  Created by Jiacheng Sun on 6/20/20.
//  Copyright © 2020 Jiacheng Sun. All rights reserved.
//

import SwiftUI


struct FilterView: View {
    @Binding var showingDatail: Bool
    @Binding var filter: FilterInfo
    @StateObject var memberViewModel: MemberViewModel

    var body: some View {
        NavigationView {
            VStack(spacing: 30) {

                Section(content: {
                    Picker("ランク", selection: $filter.rankType, content: {
                        ForEach(FilterInfo.RankType.allCases) { rank in
                            Text(rank.name).tag(rank)
                        }
                    })
                        .pickerStyle(SegmentedPickerStyle())
                })

                Section(content: {
                    Picker("順番", selection: $filter.rankOrder, content: {
                        ForEach(FilterInfo.RankOrder.allCases) { order in
                            Text(order.name).tag(order)
                        }
                    })
                        .pickerStyle(SegmentedPickerStyle())
                })

                Section(content: {
                    Picker("ラベル", selection: $filter.statusType, content: {
                        ForEach(FilterInfo.StatusType.allCases) { status in
                            Text(status.name).tag(status)
                        }
                    })
                        .pickerStyle(DefaultPickerStyle())
                })

                Spacer()
            }
                .padding()
                .navigationBarTitle(Text("フィルタ"), displayMode: .inline)
                .navigationBarItems(trailing: Button(action: {
                    withAnimation(.easeInOut) {
                        self.memberViewModel.filterMembers(filter: self.filter)
                        self.showingDatail.toggle()
                    }
                }) {
                    Text("完了")
                        .fontWeight(.bold)
                })
        }
            .navigationViewStyle(StackNavigationViewStyle())
    }
}








//
//struct FilterView_Previews: PreviewProvider {
//    @State var showingDetail = true
//    static var previews: some View {
//        FilterView(showingDatail: $showingDetail)
//    }
//}
