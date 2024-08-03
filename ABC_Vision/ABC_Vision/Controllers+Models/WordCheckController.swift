//
//  WordCheckController.swift
//  ABC_Vision
//
//  Created by Wylan L Neely on 7/13/24.
//

import Foundation


struct WordCheckController {
    
    private let CorrectWords: [String] = [
        "Apple",
        "Ball",
        "Banana",
        "Bear",
        "Bed",
        "Bird",
        "Book",
        "Boy",
        "Camera",
        "Car",
        "Carrot",
        "Carrots",
        "Cat",
        "Chair",
        "Chicken",
        "City",
        "Clock",
        "Coat",
        "Corn",
        "Cow",
        "Dog",
        "Dolphin",
        "Donut",
        "Door",
        "Duck",
        "Earth",
        "Egg",
        "Farm",
        "Fish",
        "Flower",
        "Girl",
        "God",
        "Gun",
        "Jesus",
        "Jupiter",
        "Mars",
        "Mercury",
        "Milk",
        "Money",
        "Moon",
        "MoonOrbitsEarth",
        "Neptune",
        "Orange",
        "Orbits",
        "Pluto",
        "Pig",
        "Pizza",
        "President",
        "Presidents",
        "Rabbit",
        "Rock",
        "Rooster",
        "Saturn",
        "Shark",
        "Sheep",
        "Ship",
        "Shoes",
        "Squirrel",
        "Stick",
        "Sun",
        "Tree",
        "Trump",
        "Venus",
        "Watch",
        "Whale"
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
