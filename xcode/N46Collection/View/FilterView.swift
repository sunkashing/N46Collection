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
                        ForEach(FilterInfo.RankType.allCases, id: \.self) {
                            Text($0.name)
                        }
                    })
                        .pickerStyle(SegmentedPickerStyle())
                })

                Section(content: {
                    Picker("順番", selection: $filter.rankOrder, content: {
                        ForEach(FilterInfo.RankOrder.allCases, id: \.self) {
                            Text($0.name)
                        }
                    })
                        .pickerStyle(SegmentedPickerStyle())
                })

                Section(content: {
                    Picker("ラベル", selection: $filter.statusType, content: {
                        ForEach(FilterInfo.StatusType.allCases, id: \.self) {
                            Text($0.name)
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
