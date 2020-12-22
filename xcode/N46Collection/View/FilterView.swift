//
//  FilterView.swift
//  N46Collection
//
//  Created by Jiacheng Sun on 6/20/20.
//  Copyright © 2020 Jiacheng Sun. All rights reserved.
//

import SwiftUI


struct FilterView: View {
    @Binding var showingDetail: Bool
    @Binding var filter: FilterInfo
    @StateObject var memberViewModel: MemberViewModel

    var body: some View {
        NavigationView {
            ScrollView {
                VStack(spacing: 30) {
                    Section(content: {
                        HStack {
                            Text(LocalizedStringKey("並べ替え"))
                            Picker("並べ替え", selection: $filter.rankType, content: {
                                ForEach(FilterInfo.RankType.allCases, id: \.self) {
                                    Text(LocalizedStringKey($0.name))
                                }
                            })
                                .pickerStyle(SegmentedPickerStyle())
                                .scaledToFit()
                            
                            Picker("順序", selection: $filter.rankOrder, content: {
                                ForEach(FilterInfo.RankOrder.allCases, id: \.self) {
                                    if ($0 == FilterInfo.RankOrder.low) {
                                        Image(systemName: "arrow.up.circle.fill")
                                    } else {
                                        Image(systemName: "arrow.down.circle.fill")
                                    }
                                }
                            })
                                .pickerStyle(SegmentedPickerStyle())
                                .scaledToFit()
                        }
                    
                    })
                    
                    
                    
                    Divider()

                    Section(content: {
                        VStack {
                            Text(LocalizedStringKey("メンバーラベル"))
//                            Picker(LocalizedStringKey("ラベル"), selection: $filter.statusType, content: {
//                                ForEach(FilterInfo.StatusType.allCases, id: \.self) {
//                                    Text(LocalizedStringKey($0.name))
//                                }
//                            })
//                                .pickerStyle(DefaultPickerStyle())
//                                .scaledToFit()
//                        }
                            StatusView(filter: self.$filter)
                        }
                    })
                    
                    Divider()
                    
                    Section(content: {
                        VStack {
                            Text(LocalizedStringKey("メンバーカラー"))
//                            Picker(LocalizedStringKey("メンバーカラー"), selection: $filter.colorType, content: {
//                                    ForEach(FilterInfo.ColorType.allCases, id: \.self) {
//                                        if $0 == FilterInfo.ColorType.all {
//                                            Text(LocalizedStringKey("全部カラー"))
//                                        } else {
//                                            Circle().fill($0.color)
//                                        }
//
//                                    }
//                            })
//                                .pickerStyle(DefaultPickerStyle())
//                                .scaledToFit()
                            ColorView(filter: self.$filter)
                            
                        }
                    })
                }
                .padding()
            }
            
                .navigationTitle(LocalizedStringKey("フィルタ"))
                .toolbar{
                    ToolbarItem(placement: .navigationBarTrailing) {
                        Button(action: {
                            withAnimation(.easeInOut) {
                                self.showingDetail.toggle()
                                self.memberViewModel.filterMembers(filter: self.filter)
                            }
                        }) {
                            Text(LocalizedStringKey("完了"))
                                .fontWeight(.bold)
                        }
                    }
                }
        }
            .navigationViewStyle(StackNavigationViewStyle())
    }
}



struct StatusView: View {
    @Binding var filter: FilterInfo


    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack {
                ForEach(FilterInfo.StatusType.allCases) { status in
                    Button(action: {
                        self.filter.statusType = self.filter.statusType == status ? FilterInfo.StatusType.all : status
                    }, label: {
                        Text(LocalizedStringKey(status.name))
                            .padding(.horizontal, 20)
                            .padding(.vertical, 10)
                            .background(self.filter.statusType == status ? NogiColor.purple : Color(.secondarySystemBackground))
                    })
                        .buttonStyle(PlainButtonStyle())
                        .clipShape(Capsule())
                        .animation(.easeInOut(duration: 0.9))
                }
            }
            .padding(.horizontal)
        }
    }
    
}


struct ColorView: View {
    @Binding var filter: FilterInfo


    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack {
                ForEach(FilterInfo.ColorType.allCases) { color in
                    Button(action: {
                        self.filter.colorType = self.filter.colorType == color ? FilterInfo.ColorType.all : color
                    }, label: {
                        if (color == FilterInfo.ColorType.all) {
                            Text(LocalizedStringKey("全"))
                                .padding(.horizontal, 20)
                                .padding(.vertical, 10)
                                .background(color.color)
                                .overlay(
                                    Circle()
                                        .stroke(lineWidth: 5)
                                        .fill(Color.primary)
                                        .opacity(color == self.filter.colorType ? 1 : 0)
                                )
                                
                        } else {
                            Text("")
                                .padding(.horizontal, 20)
                                .padding(.vertical, 10)
                                .background(color.color)
                                .overlay(
                                    Circle()
                                        .stroke(lineWidth: 5)
                                        .fill(Color.primary)
                                        .opacity(color == self.filter.colorType ? 1 : 0)
                                )
                        }
                        
                    })
                        .buttonStyle(PlainButtonStyle())
                        .clipShape(Circle())
                        .animation(.easeInOut(duration: 0.2))
                }
            }
            .padding(.horizontal)
        }
    }
    
}



//
//struct FilterView_Previews: PreviewProvider {
//    @State var showingDetail = true
//    static var previews: some View {
//        FilterView(showingDatail: $showingDetail)
//    }
//}
