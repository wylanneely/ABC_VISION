//
//  WrittenWordToFileConverter.swift
//  ABC_Vision
//
//  Created by Wylan L Neely on 7/15/24.
//

import Foundation

struct WrittenWordToFileConverter {
    
    private let WordToFileDictionary: [String: String] = [
        "Banana":"Banana",
        "Camera":"Camera",
        "Carrot" : "Carrot",
        "Carrots": "Carrots",
        "Donut":"Donut",
        "Earth":"Earth",
        "Gun":"Gun",
        "God":"Jesus",
        "Jesus":"Jesus",
        "Moon":"Moon",
        "Orange":"Orange",
        "Pizza":"Pizza",
        "President":"President",
        "Presidents":"Presidents",
        "Rock":"Rock",
        "Ship":"Ship",
        "Sun":"Sun",
        "Trump":"President"
    ]
    
    func getFileNameFrom(_ word: String) -> String {
       if let filename = WordToFileDictionary[word] {
            return filename
       } else {
           return ""
       }
    }
}
