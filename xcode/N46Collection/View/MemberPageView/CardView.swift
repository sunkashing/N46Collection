//
//  CardView.swift
//  N46Collection
//
//  Created by Jiacheng Sun on 6/20/20.
//  Copyright © 2020 Jiacheng Sun. All rights reserved.
//

import SwiftUI

struct CardView: View {
    var card: MemberModel.Card
    @State var showingDetail = false
    @Binding var vGridLayout: [GridItem]
    @Namespace var namespace


    var body: some View {
        ZStack {
            VStack {
                Button(action: {
                    self.showingDetail.toggle()
                }, label: {
                    HStack {
                        Image(self.card.content.member_info.picture_name)
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .cornerRadius(15)
                            .frame(maxWidth: 170)
                        if self.vGridLayout.count != 2 {
                                VStack(alignment: .leading, spacing: 10) {
                                    Text(LocalizedStringKey(self.card.content.member_info.infos.kanji_name))
                                        .font(.title2)
                                        .fontWeight(.bold)
                                        .lineLimit(1)
                                    Divider()
                                    VStack(alignment: .leading, spacing: 5) {
                                        Text(LocalizedStringKey(self.card.content.member_info.infos.birthday))
                                            .lineLimit(1)
                                        Text(LocalizedStringKey(self.card.content.member_info.infos.blood_type))
                                            .lineLimit(1)
                                        Text(LocalizedStringKey(self.card.content.member_info.infos.constellation))
                                            .lineLimit(1)
                                        Text(LocalizedStringKey(self.card.content.member_info.infos.height))
                                            .lineLimit(1)
                                        Spacer()
                                        
                                        MemberColorView(card: self.card)
                                    }
                                }
                                    .padding()
                                Spacer()
                            }
                    }
                        .background(Color(.secondarySystemBackground))
                        .cornerRadius(15)
                })

                        .sheet(isPresented: self.$showingDetail, content: {
                            CardDetailView(card: self.card)
                        })
                        .buttonStyle(PlainButtonStyle())
                
                if self.vGridLayout.count == 2 {
                    Text(LocalizedStringKey(self.card.content.member_info.infos.kanji_name))
                        .fontWeight(.heavy)
                }
                
            }

            if self.card.content.member_info.status.contains("元メンバー") {
                VStack {
                    HStack {
                        Spacer()
                        Text(LocalizedStringKey("元"))
                            .foregroundColor(.white)
                            .fontWeight(.bold)
                            .padding(10)
                            .background(NogiColor.purple)
                            .clipShape(Capsule())
                            .frame(width: 40, height: 40)
                    }
                    Spacer()
                }
            }
        }
    }

    // MARK: - Drawing Constants

    let cornerRadius: CGFloat = 10.0
    let edgeLineWidth: CGFloat = 3
    let fontScaleFactor: CGFloat = 0.15
}

struct CardDetailView: View {
    @State var scale: CGFloat = 0.5
    var card: MemberModel.Card

    var body: some View {
        GeometryReader { geometry in
            ScrollView(.vertical, showsIndicators: false) {
                VStack(spacing: 30) {
                    Section(content: {
                        VStack(spacing: 5) {
                            HStack {
                                Text(LocalizedStringKey(self.card.content.member_info.infos.kanji_name))
                                    .font(.title)
                                    .fontWeight(.bold)
                                Spacer()
                            }
                            HStack {
                                Text(LocalizedStringKey(self.card.content.member_info.infos.hiragana_name))
                                    .font(.headline)
                                    .fontWeight(.bold)
                                Spacer()
                            }
                        }
                    })

                    Section(content: {
                        Image(self.card.content.member_info.picture_name)
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(minWidth: 0, maxWidth: geometry.size.width * 0.7, alignment: .center)
                            .cornerRadius(15)
                    })

                    Section(content: {
                        VStack(spacing: 15) {
                            HStack {
                                Text(LocalizedStringKey("誕生日"))
                                Spacer()
                                Text(LocalizedStringKey(self.card.content.member_info.infos.birthday))
                            }


                            HStack {
                                Text(LocalizedStringKey("血液型"))
                                Spacer()
                                Text(LocalizedStringKey(self.card.content.member_info.infos.blood_type))
                            }


                            HStack {
                                Text(LocalizedStringKey("星座"))
                                Spacer()
                                Text(LocalizedStringKey(self.card.content.member_info.infos.constellation))
                            }


                            HStack {
                                Text(LocalizedStringKey("身長"))
                                Spacer()
                                Text(LocalizedStringKey(self.card.content.member_info.infos.height))
                            }
                        }
                    })
                        .font(.headline)
                        .padding()
                        .background(Color(.secondarySystemBackground))
                        .cornerRadius(15)
                    
                    MemberColorView(card: self.card)


//                    Spacer()

                    Section(content: {
                        ScrollView(.horizontal, showsIndicators: false) {
                            HStack(spacing: 15) {
                                ForEach(0..<self.card.content.member_info.status.count) { index in
                                    Text(LocalizedStringKey(self.card.content.member_info.status[index]))
                                        .fontWeight(.heavy)
                                        .padding(.vertical)
                                        .padding(.horizontal)
                                        .background(Color.primary.opacity(0.1))
                                        .clipShape(Capsule())

                                }
                            }
                            .frame(width: geometry.size.width * 0.9)
                        }
//                            .frame(maxWidth: .infinity, maxHeight: .infinity)
                    })
                }
                    .padding(geometry.size.width * 0.05)
            }
        }
    }

}

struct MemberColorView: View {
    var card: MemberModel.Card

    var body: some View {
        HStack(alignment: .center, spacing: /*@START_MENU_TOKEN@*/nil/*@END_MENU_TOKEN@*/, content: {
            ForEach(self.card.content.member_info.infos.colors, id: \.self) { color in
                ZStack{
                    switch color {
                    case "red":
                        Circle().fill(NogiColor.red).frame(width: 30, height: 30, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                    case "yellow":
                        Circle().fill(NogiColor.yellow).frame(width: 30, height: 30, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                    case "cyan":
                        Circle().fill(NogiColor.yellow).frame(width: 30, height: 30, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                    case "green":
                        Circle().fill(NogiColor.green).frame(width: 30, height: 30, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                    case "blue":
                        Circle().fill(NogiColor.blue).frame(width: 30, height: 30, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                    case "pink":
                        Circle().fill(NogiColor.pink).frame(width: 30, height: 30, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                    case "purple":
                        Circle().fill(NogiColor.purple).frame(width: 30, height: 30, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                    case "white":
                        Circle().fill(NogiColor.white).frame(width: 30, height: 30, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                    case "black":
                        Circle().fill(NogiColor.black).frame(width: 30, height: 30, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                    case "orange":
                        Circle().fill(NogiColor.orange).frame(width: 30, height: 30, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                    case "chartreuse":
                        Circle().fill(NogiColor.chartreuse).frame(width: 30, height: 30, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                    default:
                        Circle().fill(NogiColor.white).frame(width: 30, height: 30, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                    }
                
                }
                .overlay(
                    Circle().stroke(lineWidth: 3)
                )
            }
        })
    }
}
