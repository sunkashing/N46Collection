//
//  SongView.swift
//  N46Collection
//
//  Created by Jiacheng Sun on 12/24/20.
//  Copyright © 2020 Jiacheng Sun. All rights reserved.
//

import SwiftUI

struct SongView: View {
    var card: SongModel.Card
    @State var showingDetail = false
    @StateObject var memberViewModel: MemberViewModel
    
    var body: some View {
        VStack(alignment: .leading) {
            Button(action: {
                self.showingDetail.toggle()
            }, label: {
                Image(self.card.content.cover_name[0])
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .cornerRadius(5)
                    .frame(maxWidth: 170, maxHeight: 170)
            })
            
            Text(LocalizedStringKey(card.content.title))
                .font(.footnote)
                .lineLimit(1)
            Text(LocalizedStringKey(card.content.release_date))
                .font(.caption)
                .opacity(0.5)
                .lineLimit(1)
        }
            .sheet(isPresented: self.$showingDetail) {
                SongDetailView(card: self.card, memberViewModel: self.memberViewModel, showingDetail: self.$showingDetail)
            }
    }
}

struct SongDetailView: View {
    var card: SongModel.Card
    @StateObject var memberViewModel: MemberViewModel
    @Binding var showingDetail: Bool
    
    var body: some View {
        GeometryReader { geometry in
            NavigationView {
                ScrollView(.vertical, showsIndicators: false) {
                    VStack(alignment: .center, spacing: 15) {
                        ImageSwiperView(card: self.card, geometry: geometry)
                        VStack(alignment: .center, spacing: 5) {
                            Text(LocalizedStringKey(self.card.content.title))
                                .font(.title2)
                            Text(LocalizedStringKey(self.card.content.release_date))
                                .font(.headline)
                                .opacity(0.5)
                        }
                        
                        // MARK: - center section
                        
                        Divider()
    //                        .padding()
                        
                        Section {
                            VStack(alignment: .center) {
                                Text(LocalizedStringKey("センター"))
                                    .font(.title3)
                                    .foregroundColor(NogiColor.center)
                                ScrollView(.horizontal, showsIndicators: false) {
                                    HStack {
                                        ForEach(self.card.content.center, id: \.self) { memberName in
                                            MemberPositionView(memberName: memberName, member: memberViewModel.card(name: memberName))
                                        }
                                    }
                                    .padding(.horizontal)
                                }
                                    .frame(maxWidth: .infinity)
                            }
                        }
                        // MARK: - fukujin section
                        
                        Divider()
    //                        .padding()
                        
                        Section {
                            VStack(alignment: .center) {
                                Text(LocalizedStringKey("福神"))
                                    .font(.title3)
                                    .foregroundColor(NogiColor.fukujin)
                                ScrollView(.horizontal, showsIndicators: false) {
                                    HStack {
                                        ForEach(self.card.content.fukujin, id: \.self) { memberName in
                                            MemberPositionView(memberName: memberName, member: memberViewModel.card(name: memberName))
                                        }
                                    }
                                    .padding(.horizontal)
                                }
                                    .frame(maxWidth: .infinity)
                            }
                        }
                        
                        // MARK: - senbatsu section
                        
                        Divider()
    //                        .padding()
                        
                        Section {
                            VStack(alignment: .center) {
                                Text(LocalizedStringKey("選抜"))
                                    .font(.title3)
                                    .foregroundColor(NogiColor.senbatsu)
                                ScrollView(.horizontal, showsIndicators: false) {
                                    HStack {
                                        ForEach(self.card.content.senbatsu, id: \.self) { memberName in
                                            MemberPositionView(memberName: memberName, member: memberViewModel.card(name: memberName))
                                        }
                                    }
                                    .padding(.horizontal)
                                }
                                    .frame(maxWidth: .infinity)
                            }
                        }
                        
                        // MARK: - under section
                        
                        Divider()
    //                        .padding()
                        
                        Section {
                            VStack(alignment: .center) {
                                Text(LocalizedStringKey("アンダー"))
                                    .font(.title3)
                                    .foregroundColor(NogiColor.under)
                                ScrollView(.horizontal, showsIndicators: false) {
                                    HStack {
                                        ForEach(self.card.content.under, id: \.self) { memberName in
                                            MemberPositionView(memberName: memberName, member: memberViewModel.card(name: memberName))
                                        }
                                    }
                                    .padding(.horizontal)

                                }
                                    .frame(maxWidth: .infinity)
    //                            .background(Color.blue)
                            }
                        }
                    }
                        .padding(.vertical)
                    
                }
                    .navigationTitle(LocalizedStringKey(self.card.content.title))
                    .toolbar{
                        ToolbarItem(placement: .navigationBarTrailing) {
                            Button(action: {
                               self.showingDetail.toggle()
                            }) {
                                Image(systemName: "multiply.circle.fill")
                            }
                        }
                    }
            }
            .navigationViewStyle(StackNavigationViewStyle())
        }
    }
}


struct MemberPositionView: View {
    var memberName: String
    let member: MemberModel.Card?
//    @StateObject var memberViewModel: MemberViewModel


    var body: some View {
        VStack {
            Image((self.member == nil) ? "nishinonanase" : self.member!.content.member_info.picture_name)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .clipShape(Circle())
                .frame(maxWidth: 90, maxHeight: 90)
                
            Text(LocalizedStringKey(self.memberName))
                .font(.footnote)
                .lineLimit(1)
        }
//        .background(Color.blue)
    }
}



struct ImageSwiperView: View {
    var card: SongModel.Card
    var geometry: GeometryProxy
    @State var tabIndex: Int = 0

    var body: some View {
        TabView(selection: self.$tabIndex) {
//            ForEach(self.card.content.cover_name.indices) { index in
//                Image(self.card.content.cover_name[index])
//                    .resizable()
//                    .aspectRatio(contentMode: .fit)
//                    .frame(width: self.tabIndex == index ? geometry.size.width * 0.8 : geometry.size.width * 0.7)
//                    .clipped()
//                    .cornerRadius(5)
//                    .padding(.horizontal)
//                    .tag(index)
//            }
            ForEach(Array(self.card.content.cover_name.enumerated()), id: \.1) { index, cover in
                Image(cover)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: geometry.size.width * 0.8)
//                    .frame(width: geometry.size.width * 0.8)
                    .clipped()
                    .cornerRadius(5)
                    .padding(.horizontal)
//                    .tag(index)
            }
        }
        .frame(width: geometry.size.width)
//        .cornerRadius(15)
        .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
        .animation(.easeOut)
    }
}


