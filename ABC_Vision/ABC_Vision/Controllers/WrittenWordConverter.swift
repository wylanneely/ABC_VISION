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
        "Ball": "Ball",
        "Banana": "Banana",
        "Bear": "Bear",
        "Bed": "Bed",
        "Bird": "Bird",
        "Book": "Book",
        "Box": "Box",
        "Camera": "Camera",
        "Car": "Car",
        "Carrot": "Carrot",
        "Carrots": "Carrots",
        "Cat": "Cat",
        "Chair": "Chair",
        "Chicken": "Chicken",
        "City": "City",
        "Clock": "Clock",
        "Coat": "Coat",
        "Corn": "Corn",
        "Cow": "Cow",
        "Dog": "Dog",
        "Dolphin": "Dolphin",
        "Donut": "Donut",
        "Door": "Door",
        "Duck": "Duck",
        "Earth": "Earth",
        "Egg": "Egg",
        "Farm": "Farm",
        "Fish": "Fish",
        "Flower": "Flower",
        "Girl": "Girl",
        "Gun": "Gun",
        "Jesus": "Jesus",
        "Milk": "Milk",
        "Money": "Money",
        "Moon": "Moon",
        "MoonOrbitsEarth": "MoonOrbitsEarth",
        "Orange": "Orange",
        "Orbits": "Orbits",
        "Pig": "Pig",
        "Pizza": "Pizza",
        "President": "President",
        "Presidents": "Presidents",
        "Rabbit": "Rabbit",
        "Rock": "Rock",
        "Rooster": "Rooster",
        "Shark": "Shark",
        "Sheep": "Sheep",
        "Ship": "Ship",
        "Shoes": "Shoes",
        "Squirrel": "Squirrel",
        "Stick": "Stick",
        "Sun": "Sun",
        "Trump": "President",
        "Tree":"Tree",
        "Watch":"Watch",
        "Whale":"Whale"
    ]
    
    func getFileNameFrom(_ word: String) -> String {
       if let filename = WordToFileDictionary[word] {
            return filename
       } else {
           return ""
       }
    }
    
    //MARK: - SenteceCreators
    
    func stringToSentenceArray(_ word: String) -> [String] {
        return word.split(separator: " ").map { String($0) }
    }
}
