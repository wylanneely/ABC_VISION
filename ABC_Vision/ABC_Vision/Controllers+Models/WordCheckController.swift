//
//  WordCheckController.swift
//  ABC_Vision
//
//  Created by Wylan L Neely on 7/13/24.
//

import Foundation


struct WordCheckController {
    
    private let language = LanguageChecker().language

    
    private let CorrectWords: [String] = [
        "Apple",
       // "Ball",
        "Banana",
        "Bear",
      //  "Bed",
        "Bird",
        "Book",
       // "Boy",
        "Bunny",
       // "Camera",
       // "Car",
        "Carrot",
        "Carrots",
        "Cat",
       // "Chair",
        "Chicken",
        "Cheese",
       // "City",
        "Clock",
       // "Coat",
        "Corn",
        "Cow",
        "Dog",
        "Dolphin",
        "Donut",
       // "Door",
        "Duck",
        "Earth",
        "Egg",
        "Elephant",
        "Fish",
        "Flower",
      //  "Girl",
        "God",
        "Gun",
        "Horse",
        "Jesus",
        "Jet",
        "Jupiter",
        "Kangaroo",
        "Mars",
        "Mercury",
        "Milk",
       // "Money",
        "Moon",
       // "MoonOrbitsEarth",
        "Neptune",
        "Orange",
      //  "Orbits",
        "Pluto",
        "Pig",
        "Pizza",
        "President",
      //  "Presidents",
        "Rabbit",
      //  "Rice",
       // "Rock",
      //  "Rooster",
        "Saturn",
        "Shark",
        "Sheep",
        "Ship",
       // "Shoes",
        "Squirrel",
     //   "Stick",
        "Sun",
        "Tree",
        "Trump",
        "Uranus",
        "Venus",
        "Watch",
        "Whale"
    ]
    
    private let russianCorrectWords: [String] = ["Яблоко", "Банан", "Медведь", "Птица", "Книга", "Кролик", "Морковь", "Морковки", "Кошка", "Курица", "Сыр", "Часы", "Кукуруза", "Корова", "Собака", "Дельфин", "Пончик", "Утка", "Земля", "Яйцо", "Рыба", "Цветок", "Бог", "Оружие", "Лошадь", "Иисус", "Реактивный самолет", "Юпитер", "Марс", "Меркурий", "Молоко", "Луна", "Нептун", "Апельсин", "Плутон", "Свинья", "Пицца", "Президент", "Кролик", "Сатурн", "Акула", "Овца", "Корабль", "Белка", "Солнце", "Дерево", "Трамп", "Уран", "Венера", "Часы", "Кит"
    ]
    
    
    func checkWordisCorrect(_ word:String?)->Bool{
        guard let word = word else {return false}
        switch language {
        case "English":
            for w in CorrectWords {
                if word.lowercased() == w.lowercased() {
                    return true
                }
            }
            return false
        case "Russian":
            for w in russianCorrectWords {
                if word.lowercased() == w.lowercased() {
                    return true
                }
            }
            return false
        default :
            for w in CorrectWords {
                if word.lowercased() == w.lowercased() {
                    return true
                }
            }
            return false
        }
    }
    
    func checkIfWordIsSentence(_ word:String?)->Bool {
        if let word = word {
            let wordsArray = word.split(separator: " ")
            if wordsArray.count >= 2 {
                print("True Sentence")
                return true
            }
        }
        print("False Sentence")
        return false
    }
    
    
    
    
}
