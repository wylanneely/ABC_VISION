//
//  WordStackController.swift
//  ABC_Vision
//
//  Created by Wylan L Neely on 8/12/24.
//

import Foundation
import UIKit

struct WordStackController {
    
    init(){
        foods = [
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
    }
    //MARK: - Foods
    
    var foods:[Word]
    
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
    
    
    //MARK: - Updates
    
    func unlockWordWith(name:String){
        for wor in foods {
            if wor.name == name {
                wor.unlockComplete()
            }
        }
    
    }

}