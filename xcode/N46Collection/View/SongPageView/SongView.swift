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
                    VStack(spacing: 15) {
                        ImageSwiperView(card: self.card, geometry: geometry)
                        VStack(alignment: .center, spacing: 5) {
                            Text(LocalizedStringKey(self.card.content.title))
                                .font(.title2)
                            Text(LocalizedStringKey(self.card.content.release_date))
                                .font(.headline)
                                .opacity(0.5)
                        }
                        
                        // MARK: - position section
                        Divider()
                            .padding(.vertical)
                        SongPositionView(card: self.card, memberViewModel: self.memberViewModel, geometry: geometry)
                        Divider()
                            .padding(.vertical)
                        SongListView(card: self.card, memberViewModel: self.memberViewModel, geometry: geometry)
                        
                        
                        
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
                        
                        ToolbarItem(placement: .navigationBarLeading) {
                            Image(systemName: String(card.content.order) + ".square.fill")
                                .foregroundColor(Color.purple)
                                .font(.title)
                        }
                    }
            }
            .navigationViewStyle(StackNavigationViewStyle())
        }
    }
}

struct SongListView: View {
    var card: SongModel.Card
    @StateObject var memberViewModel: MemberViewModel
    var geometry: GeometryProxy


    var body: some View {
        VStack(alignment: .center) {
            Text(LocalizedStringKey("収録楽曲"))
                .font(.title)
                .padding(.vertical)
            
            ForEach(self.card.content.songs.indices) { index in
                VStack(alignment: .leading) {
                    NavigationLink(destination: SongListDetailView(card: self.card, index: index, memberViewModel: self.memberViewModel, geometry: geometry)){
                        HStack(spacing: 15) {
                            Text(LocalizedStringKey(String(index + 1)))
                                .opacity(0.5)
                                .foregroundColor(.primary)
                            Text(LocalizedStringKey(self.card.content.songs[index].song_name))
                                .foregroundColor(.primary)
                            Spacer()
                            Image(systemName: "greaterthan")
                                .foregroundColor(.accentColor)
                        }
                    }
                    
                    Divider()
                }
                    .padding()
            }
        }
            .frame(maxHeight: .infinity)
    }
}


struct SongListDetailView: View {
    var card: SongModel.Card
    var index: Int
    @StateObject var memberViewModel: MemberViewModel
    var geometry: GeometryProxy


    var body: some View {
        ScrollView {
            VStack {
                // MARK: - center section
                SongSinglePositionView(members: self.card.content.songs[index].song_center, memberViewModel: self.memberViewModel, header: "センター", color: NogiColor.center, geometry: self.geometry)
                
                Divider()
                    .padding(.horizontal)
                
                // MARK: - member section
                SongSinglePositionView(members: self.card.content.songs[index].song_members, memberViewModel: self.memberViewModel, header: "メンバー", color: NogiColor.senbatsu, geometry: self.geometry)
                
            }
        }
            .navigationTitle(LocalizedStringKey(self.card.content.songs[index].song_name))
    }
}

struct SongSinglePositionView: View {
    var members: [String]
    @StateObject var memberViewModel: MemberViewModel
    let header: String
    let color: Color
    var geometry: GeometryProxy
    @State var vGridLayout = [GridItem(.adaptive(minimum: 70)), GridItem(.adaptive(minimum: 70))]
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(LocalizedStringKey(header))
                .font(.title2)
                .foregroundColor(color)
                .padding()
            LazyVGrid(columns: vGridLayout) {
                ForEach(self.members, id: \.self) { memberName in
                    MemberPositionView(memberName: memberName, member: memberViewModel.card(name: memberName))
                }
            }
        }
    }
}



struct SongPositionView: View {
    var card: SongModel.Card
    @StateObject var memberViewModel: MemberViewModel
    var geometry: GeometryProxy


    var body: some View {
        
        // MARK: - center section
        SongSinglePositionView(members: self.card.content.center, memberViewModel: self.memberViewModel, header: "センター", color: NogiColor.center, geometry: self.geometry)
        // MARK: - fukujin section
        
        Divider()
            .padding(.horizontal)
        
        SongSinglePositionView(members: self.card.content.fukujin, memberViewModel: self.memberViewModel, header: "福神", color: NogiColor.fukujin, geometry: self.geometry)
        
        
        // MARK: - senbatsu section
        
        Divider()
            .padding(.horizontal)

        SongSinglePositionView(members: self.card.content.senbatsu, memberViewModel: self.memberViewModel, header: "選抜", color: NogiColor.senbatsu, geometry: self.geometry)

        
        // MARK: - under section
        
        Divider()
            .padding(.horizontal)
        
        SongSinglePositionView(members: self.card.content.under, memberViewModel: self.memberViewModel, header: "アンダー", color: NogiColor.under, geometry: self.geometry)

    }
}




struct MemberPositionView: View {
    var memberName: String
    let member: MemberModel.Card?
//    @StateObject var memberViewModel: MemberViewModel


    var body: some View {
        ZStack {
            VStack {
                Image((self.member == nil) ? "default_member" : self.member!.content.member_info.picture_name)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .cornerRadius(5)
                    .frame(width: 70, height: 70)
                    
                Text(LocalizedStringKey(self.memberName))
                    .font(.footnote)
                    .lineLimit(1)
            }
            
            if self.member == nil || self.member!.content.member_info.status.contains("元メンバー") {
                VStack {
                    HStack(spacing: 5) {
                        Spacer()
                        Text(LocalizedStringKey("元"))
                            .foregroundColor(.white)
                            .padding(5)
                            .background(NogiColor.purple)
                            .clipShape(Circle())
                            .frame(width: 30, height: 30)
                        Text("")
                    }
                    Spacer()
                }
            }
        }
    }
}



struct ImageSwiperView: View {
    var card: SongModel.Card
    var geometry: GeometryProxy
    @State var tabIndex: Int = 0

    var body: some View {
        TabView(selection: self.$tabIndex) {
            ForEach(Array(self.card.content.cover_name.enumerated()), id: \.1) { index, cover in
                Image(cover)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: geometry.size.width * 0.8)
                    .clipped()
                    .cornerRadius(5)
                    .padding(.horizontal)
            }
        }
        .frame(width: geometry.size.width)
//        .cornerRadius(15)
        .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
        .animation(.easeOut)
    }
}


