//
//  WrittenWordToFileConverter.swift
//  ABC_Vision
//
//  Created by Wylan L Neely on 7/15/24.
//

import Foundation

struct WrittenWordConverter {
    
    private let language = LanguageChecker().language
    
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
        "Cheese":"Cheese",
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
        "Egg": "Egg",
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
        "Presidents": "President",
        "Rabbit": "Rabbit",
       // "Rice":"Rice",
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
        "Uranus":"Uranus",
        "Venus":"Venus",
        "Watch":"Watch",
        "Whale":"Whale"
    ]
    
    private let russianWordToFileDictionary: [String: String] =  [
        "Яблоко": "Apple",
        "Банан": "Banana",
        "Медведь": "Bear",
        "Птица": "Bird",
        "Книга": "Book",
        "Кролик": "Rabbit",
        "Морковь": "Carrot",
        "Морковки": "Carrots",
        "Кошка": "Cat",
        "Курица": "Chicken",
        "Сыр": "Cheese",
        "Часы": "Watch",
        "Кукуруза": "Corn",
        "Корова": "Cow",
        "Собака": "Dog",
        "Дельфин": "Dolphin",
        "Пончик": "Donut",
        "Утка": "Duck",
        "Земля": "Earth",
        "Яйцо": "Egg",
        "Рыба": "Fish",
        "Цветок": "Flower",
        "Бог": "God",
        "Оружие": "Gun",
        "Лошадь": "Horse",
        "Иисус": "Jesus",
        "Реактивный самолет": "Jet",
        "Юпитер": "Jupiter",
        "Марс": "Mars",
        "Меркурий": "Mercury",
        "Молоко": "Milk",
        "Луна": "Moon",
        "Нептун": "Neptune",
        "Апельсин": "Orange",
        "Плутон": "Pluto",
        "Свинья": "Pig",
        "Пицца": "Pizza",
        "Президент": "President",
        "Сатурн": "Saturn",
        "Акула": "Shark",
        "Овца": "Sheep",
        "Корабль": "Ship",
        "Белка": "Squirrel",
        "Солнце": "Sun",
        "Дерево": "Tree",
        "Трамп": "Trump",
        "Уран": "Uranus",
        "Венера": "Venus",
        "Кит": "Whale"
    ]
    
    func getFileNameFrom(_ word: String) -> String {
        
        switch language {
        case "English":
            if let filename = WordToFileDictionary[word.capitalized] {
                return filename
           } else {
               return ""
           }
        case "Russian":
            if let filename = russianWordToFileDictionary[word.capitalized] {
                return filename
           } else {
               return ""
           }
        default:
            if let filename = WordToFileDictionary[word.capitalized] {
                return filename
           } else {
               return ""
           }
        }
    }
    
    //MARK: - "Pluto",Creators
    
    func stringToSentenceArray(_ word: String) -> [String] {
        return word.split(separator: " ").map { String($0) }
    }
}
