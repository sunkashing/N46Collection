//
//  helper.swift
//  N46Collection
//
//  Created by Jiacheng Sun on 5/30/20.
//  Copyright © 2020 Jiacheng Sun. All rights reserved.
//

import Foundation


struct NogizakaMember: Codable {
    let member_name: String
    let member_info: Member

    struct Member: Codable {
        let picture_name: String
        let picture_url: URL
        let infos: Info
        let status: [String]

        struct Info: Codable {
            let kanji_name: String
            let hiragana_name: String
            let birthday: String
            let blood_type: String
            let constellation: String
            let height: String
            let colors: [String]
        }

    }  
}

struct NogizakaSong: Codable {
    let type: String
    let title: String
    let order: Int
    let release_date: String
    let cover_name: [String]
    let cover_url: [String]
    let center: [String]
    let fukujin: [String]
    let senbatsu: [String]
    let under: [String]
    
    let songs: [Song]
    struct Song: Codable {
        let song_name: String
        let song_center: [String]
        let song_members: [String]
    }
}


func readLocalFile(forName name: String) -> Data? {
    do {
        if let bundlePath = Bundle.main.path(forResource: name,
                                             ofType: "json"),
           
            let jsonData = try String(contentsOfFile: bundlePath).data(using: .utf8) {
            return jsonData
        }
    } catch {
        print(error)
    }

    return nil
}

func getNogizakaMemberJsonData(forName name: String) -> [NogizakaMember]? {
    let jsonDecoder = JSONDecoder()
    let jsonData = readLocalFile(forName: name)
    let modelObject = try? jsonDecoder.decode([NogizakaMember].self, from: jsonData!)
    return modelObject
}

func getNogizakaSongJsonData(forName name: String) -> [NogizakaSong]? {
    let jsonDecoder = JSONDecoder()
    let jsonData = readLocalFile(forName: name)
//    print(jsonData)
    let modelObject = try? jsonDecoder.decode([NogizakaSong].self, from: jsonData!)
    return modelObject
}

