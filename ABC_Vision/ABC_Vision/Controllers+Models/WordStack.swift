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

struct Word: Codable {
    let name: String
    var isComplete: Bool
    
    init(name: String) {
        self.name = name
        self.isComplete = false
    }
    
    mutating func unlockComplete()  {
        self.isComplete = false
    }
}

//MARK: - Foods
let foods:[Word] = [
    appleWord,
    bananaWord,
    carrotWord,
    carrotsWord,
    cornWord,
    cornWord,
    donutWord,
    eggWord,
    milkWord,
    orangeWord,
    pizzaWord
]
var appleWord = Word(name: "Apple")
var bananaWord = Word(name: "Banana")
var carrotWord = Word(name: "Carrot")
var carrotsWord = Word(name: "Carrots")
var cornWord = Word(name: "Corn")
var donutWord = Word(name: "Donut")
var eggWord = Word(name: "Egg")
var milkWord = Word(name: "Milk")
var orangeWord = Word(name: "Orange")
var pizzaWord = Word(name: "Pizza")


//MARK: Space
let planets: [Word] = [
    sunWord,
    moonWord,
    earthWord,
    jupiterWord,
    marsWord,
    mercuryWord,
    neptuneWord,
    uranusWord,
    venusWord,
    plutoWord,
    saturnWord
]

var sunWord = Word(name: "Sun")
var moonWord = Word(name: "Moon")
var earthWord = Word(name: "Earth")
var jupiterWord = Word(name: "Jupiter")
var marsWord = Word(name: "Mars")
var mercuryWord = Word(name: "Mercury")
var neptuneWord = Word(name: "Neptune")
var uranusWord = Word(name: "Uranus")
var venusWord = Word(name: "Venus")
var plutoWord = Word(name: "Pluto")
var saturnWord = Word(name: "Saturn")


