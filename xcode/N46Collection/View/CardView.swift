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
            Button(action: {
                print("Card is touched!")
                self.showingDetail.toggle()
            }, label: {
                    if self.vGridLayout.count == 2 {
                        VStack {
                            ZStack {
                                Image(self.card.content.member_info.picture_name)
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .cornerRadius(15)
                                    .frame(maxWidth: 170)
//                                    .matchedGeometryEffect(id: "image", in: self.namespace)
                            }
                            Text(self.card.content.member_info.infos.kanji_name)
                                .fontWeight(.bold)
//                                .matchedGeometryEffect(id: "name", in: self.namespace)
                        }
                    } else {
                        HStack {
                            ZStack {
                                Image(self.card.content.member_info.picture_name)
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .cornerRadius(15)
                                    .frame(maxWidth: 170)
//                                    .matchedGeometryEffect(id: "image", in: self.namespace)
                            }
                            VStack(alignment: .leading, spacing: 10) {
                                Text(self.card.content.member_info.infos.kanji_name)
                                    .font(.title)
                                    .fontWeight(.bold)
                                    .lineLimit(1)
//                                    .matchedGeometryEffect(id: "name", in: self.namespace)
                                VStack(alignment: .leading, spacing: 5) {
                                    Text(self.card.content.member_info.infos.birthday)
                                        .lineLimit(1)
                                    Text(self.card.content.member_info.infos.blood_type)
                                        .lineLimit(1)
                                    Text(self.card.content.member_info.infos.constellation)
                                        .lineLimit(1)
                                    Text(self.card.content.member_info.infos.height)
                                        .lineLimit(1)
                                }
                                Spacer()
                            }
                                .padding()
                            Spacer()
                        }
                            .background(Color(.secondarySystemBackground))
                            .cornerRadius(15)
                    }
                })

                    .sheet(isPresented: self.$showingDetail, content: {
                        CardDetailView(card: self.card)
                    })
                    .buttonStyle(PlainButtonStyle())

            if self.card.content.member_info.status.contains("元メンバー") {
                VStack {
                    HStack {
                        Spacer()
                        Text("元")
                            .fontWeight(.bold)
                            .padding(10)
                            .background(Color(.systemPurple))
                            .clipShape(Circle())
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
            ScrollView {
                VStack(spacing: 30) {
                    Section(content: {
                        VStack(spacing: 5) {
                            HStack {
                                Text(self.card.content.member_info.infos.kanji_name)
                                    .font(.title)
                                    .fontWeight(.bold)
                                Spacer()
                            }
                            HStack {
                                Text(self.card.content.member_info.infos.hiragana_name)
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
                                Text("誕生日")
                                Spacer()
                                Text(self.card.content.member_info.infos.birthday)
                            }


                            HStack {
                                Text("血液型")
                                Spacer()
                                Text(self.card.content.member_info.infos.blood_type)
                            }


                            HStack {
                                Text("星座")
                                Spacer()
                                Text(self.card.content.member_info.infos.constellation)
                            }


                            HStack {
                                Text("身長")
                                Spacer()
                                Text(self.card.content.member_info.infos.height)
                            }
                        }
                    })
                        .font(.headline)
                        .padding()
                        .background(Color(.secondarySystemBackground))
                        .cornerRadius(15)


                    Spacer()

                    Section(content: {
                        HStack(spacing: 15) {
                            ForEach(0..<self.card.content.member_info.status.count) { index in
                                Text(self.card.content.member_info.status[index])
                                    .font(.subheadline)
                                    .padding(5)
                                    .overlay(
                                        RoundedRectangle(cornerRadius: geometry.size.width * 0.01)
                                            .stroke(lineWidth: geometry.size.width * 0.003)
                                    )
                                    .lineLimit(1)
                            }
                        }
                    })
                }
                    .padding(geometry.size.width * 0.05)
    //                .scaleEffect(self.scale)
    //                .scaleOnAppear {
    //                    self.scale = 1
    //                }
    //                .scaleOnDisappear {
    //                    self.scale = 0.5
    //                }
            }
        }
    }

}



//struct CardView_Previews: PreviewProvider {
//    static var previews: some View {
//        CardView(card: MemberViewModel().cards[0], )
//    }
//}
