//
//  WordStack.swift
//  ABC_Vision
//
//  Created by Wylan L Neely on 8/1/24.
//

import Foundation


struct WordStack: Codable {
    
    let name: String
    let words: [Word]
    
    init(name: String, words: [Word]) {
        self.name = name
        self.words = words
     //   self.isWordComplete = Dictionary(uniqueKeysWithValues: words.map { ($0, false) })
    }
}


class Word: Codable {
    let name: String
    var isComplete: Bool
    
    init(name: String) {
        self.name = name
        self.isComplete = false
    }
    
    func unlockComplete()  {
        self.isComplete = true
    }
}

