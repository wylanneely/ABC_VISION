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
    "Rock",
    "Ship",
    "Sun"
    ]
    
    func checkWordisCorrect(word:String)->Bool{
        for w in CorrectWords {
            if word.lowercased() == w.lowercased() {
                return true
            }
        }
        
        return false
    }
    
}
