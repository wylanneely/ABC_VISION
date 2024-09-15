//
//  WordStackController.swift
//  ABC_Vision
//
//  Created by Wylan L Neely on 8/12/24.
//

import Foundation
import UIKit

struct WordStackController {
    
    var wordListsArray: [[Word]]
    
    init(){
       planets = [
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
        
        animals = [
            bearWord,
            birdWord,
            catWord,
            chickenWord,
            cowWord,
            dogWord,
            dolphinWord,
            duckWord,
            fishWord,
            horseWord,
            pigWord,
            rabbitWord,
          //  roosterWord,
            sharkWord, 
            sheepWord,
            squirrelWord,
            whaleWord
        ]
        
        foods = [
            appleWord,
            bananaWord,
            carrotWord,
      //      carrotsWord,
            cornWord,
            donutWord,
          //  eggWord,
            milkWord,
            orangeWord,
            pizzaWord
        ]               //  order of Array important
        wordListsArray = [planets,animals,foods]
    }
    
    //MARK: - Freesyle
    
    let freeStyleImage = UIImage(named: "FreeStylePencil")
    
    //MARK: - Animals
    let animalsCompleteImage = UIImage(named: "animalsComplete")
    let animalsInCompleteImage = UIImage(named: "animalNcomplete")
    //automate image with function that checks if each Wordstack is complete and returns correct image
    
    let animalsName = "Animals"
    var animals: [Word]
    
    var bearWord = Word(name: "Bear")
    var birdWord = Word(name: "Bird")
    var catWord = Word(name: "Cat")
    var chickenWord = Word(name: "Chicken")
    var cowWord = Word(name: "Cow")
    var dogWord = Word(name: "Dog")
    var dolphinWord = Word(name: "Dolphin")
    var duckWord = Word(name: "Duck")
    var fishWord = Word(name: "Fish")
    var horseWord = Word(name: "Horse")
    var pigWord = Word(name: "Pig")
    var rabbitWord = Word(name: "Rabbit")
   // var roosterWord = Word(name: "Rooster")
    var sharkWord = Word(name: "Shark")
    var sheepWord = Word(name: "Sheep")
    var squirrelWord = Word(name: "Squirrel")
    var whaleWord = Word(name: "Whale")
    
    //MARK: - Foods
    
    let foodsCompleteImage = UIImage(named: "foodComplete")
    let foodsInCompleteImage = UIImage(named: "foodsINcomplete")
    
    let foodsName = "Foods"
    var foods:[Word]
    
    var appleWord = Word(name: "Apple")
    var bananaWord = Word(name: "Banana")
    var carrotWord = Word(name: "Carrot")
   // var carrotsWord = Word(name: "Carrots")
    var cornWord = Word(name: "Corn")
    var donutWord = Word(name: "Donut")
 //   var eggWord = Word(name: "Egg")
    var milkWord = Word(name: "Milk")
    var orangeWord = Word(name: "Orange")
    var pizzaWord = Word(name: "Pizza")
    
    var isFoodsComplete: Bool {
        for f in foods {
            if !f.isComplete {
                return false
            }
        }
        return true
    }
    
    //MARK: Planets
    
    var planets: [Word]
    let planetsName = "Planets"
    
    let planetCompleteImage = UIImage(named: "planetsComplete")
    let planetIncompleteImage = UIImage(named: "planetsINcomplete")

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

    var isPlanetsComplete: Bool {
        for p in planets {
            if !p.isComplete {
                return false
            }
        }
        return true
    }
    
    
    //MARK: - Update
    
    func unlockWordWith(name:String){
        for wor in foods {
            if wor.name == name {
                wor.unlockComplete()
            }
        }
    
    }

}
