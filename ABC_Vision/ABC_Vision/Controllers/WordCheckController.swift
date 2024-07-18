//
//  WordCheckController.swift
//  ABC_Vision
//
//  Created by Wylan L Neely on 7/13/24.
//

import Foundation


struct WordCheckController {
    
    private let CorrectWords: [String] = [
    "Banana",
    "Camera",
    "Carrot",
    "Carrots",
    "Donut",
    "Earth",
    "Gun",
    "God",
    "Jesus",
    "Moon",
    "Orange",
    "Orbits",
    "Pizza",
    "President",
    "Presidents",
    "Rock",
    "Ship",
    "Sun",
    "Trump",
    "MoonOrbitsEarth",
    ]
    
    func checkWordisCorrect(_ word:String?)->Bool{
        guard let word = word else {return false}
        for w in CorrectWords {
            if word.lowercased() == w.lowercased() {
                return true
            }
        }
        return false
    }
    
    func checkIfWordIsSentence(_ word:String?)->Bool {
        if let word = word {
            let wordsArray = word.split(separator: " ")
            if wordsArray.count >= 2 {
                print("True Sentence")
                return true
            }
        }
        print("False Sentexe")
        return false
    }
    
}
