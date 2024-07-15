//
//  WordCheckController.swift
//  ABC_Vision
//
//  Created by Wylan L Neely on 7/13/24.
//

import Foundation


struct WordCheckController {
    
    let CorrectWords: [String] = [
    "Banana",
    "Camera",
    "Carrot",
    "Carrots",
    "Donut",
    "Earth",
    "Gun",
    "Moon",
    "Orange",
    "Pizza",
    "President",
    "Presidents",
    "Rock",
    "Ship",
    "Sun"
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
    
}
