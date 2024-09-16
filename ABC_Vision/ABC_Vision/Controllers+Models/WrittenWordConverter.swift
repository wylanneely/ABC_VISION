//
//  WrittenWordToFileConverter.swift
//  ABC_Vision
//
//  Created by Wylan L Neely on 7/15/24.
//

import Foundation

struct WrittenWordConverter {
    
    //MARK: - FileNames
    
    private let WordToFileDictionary: [String: String] = [
        "Apple": "Apple",
      //  "Ball": "Ball",
        "Banana": "Banana",
        "Bear": "Bear",
      //  "Bed": "Bed",
        "Bird": "Bird",
        "Book": "Book",
       // "Boy": "Boy",
        "Bunny":"Rabbit",
       // "Camera": "Camera",
       // "Car": "Car",
        "Carrot": "Carrot",
        "Carrots": "Carrot",
        "Cat": "Cat",
      //  "Chair": "Chair",
        "Chicken": "Chicken",
        //"City": "City",
      //  "Clock": "Clock",
      //  "Coat": "Coat",
        "Corn": "Corn",
        "Cow": "Cow",
        "Dog": "Dog",
        "Dolphin": "Dolphin",
        "Donut": "Donut",
       // "Door": "Door",
        "Duck": "Duck",
        "Earth": "Earth",
        //"Egg": "Egg",
        //"Farm": "Farm",
        "Fish": "Fish",
        "Flower": "Flower",
      //  "Girl": "Girl",
        "Gun": "Gun",
        "Horse": "Horse",
        "Jesus": "Jesus",
        "Jet": "Jet",
        "Jupiter":"Jupiter",
        "Mars":"Mars",
        "Mercury":"Mercury",
        "Milk": "Milk",
       // "Money": "Money",
        "Moon": "Moon",
        //"MoonOrbitsEarth": "MoonOrbitsEarth",
        "Neptune":"Neptune",
        "Orange": "Orange",
       // "Orbits": "Orbits",
        "Pluto":"Pluto",
        "Pig": "Pig",
        "Pizza": "Pizza",
        "President": "President",
       // "Presidents": "Presidents",
        "Rabbit": "Rabbit",
        //"Rock": "Rock",
        //"Rooster": "Rooster",
        "Saturn":"Saturn",
        "Shark": "Shark",
        "Sheep": "Sheep",
      //  "Shoes": "Shoes",
        "Squirrel": "Squirrel",
     //   "Stick": "Stick",
        "Sun": "Sun",
        "Trump": "President",
        "Tree":"Tree",
        "Uranus":"Uranus"
        "Venus":"Venus",
        "Watch":"Watch",
        "Whale":"Whale"
    ]
    
    func getFileNameFrom(_ word: String) -> String {
        if let filename = WordToFileDictionary[word.capitalized] {
            return filename
       } else {
           return ""
       }
    }
    
    //MARK: - "Pluto",Creators
    
    func stringToSentenceArray(_ word: String) -> [String] {
        return word.split(separator: " ").map { String($0) }
    }
}
