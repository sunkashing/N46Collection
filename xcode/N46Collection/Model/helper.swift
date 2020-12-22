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

func getJsonData() -> [NogizakaMember]? {
    let jsonDecoder = JSONDecoder()
    let jsonData = readLocalFile(forName: "Nogizaka_members")
//    print(jsonData!)
    let modelObject = try? jsonDecoder.decode([NogizakaMember].self, from: jsonData!)
//    print(modelObject!)
    return modelObject
}

