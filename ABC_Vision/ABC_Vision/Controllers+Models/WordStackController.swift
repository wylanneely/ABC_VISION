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
    
    lazy var planetStack: WordStack = WordStack(name: "Planets", words: planets)
    lazy var animalStack: WordStack = WordStack(name: "Animals", words: animals)
    lazy var foodsStack: WordStack = WordStack(name: "Foods", words: foods)
    
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
            cheeseWord,
            cornWord,
            donutWord,
            eggWord,
            milkWord,
            orangeWord,
            pizzaWord,
        ]               //  order of Array important
        wordListsArray = [animals,planets,foods]
    }
    
    //MARK: - Freesyle
    
    let freeStyleImage = UIImage(named: "FreeStylePencil")
    
    //MARK: - Animals
    let animalsCompleteImage = UIImage(named: "animalsComplete")
    let animalsInCompleteImage = UIImage(named: "animalNcomplete")
    //automate image with function that checks if each Wordstack is complete and returns correct image
    
    let animalsName = "Animals"
    var animals: [Word]
    
    var bearWord = Word(name: bearWN)
    var birdWord = Word(name: birdWN)
    var catWord = Word(name: catWN)
    var chickenWord = Word(name: chickenWN)
    var cowWord = Word(name: cowWN)
    var dogWord = Word(name: dogWN)
    var dolphinWord = Word(name: dolphinWN)
    var duckWord = Word(name: duckWN)
    var fishWord = Word(name: fishWN)
    var horseWord = Word(name: horseWN)
    var pigWord = Word(name: pigWN)
    var rabbitWord = Word(name: rabbitWN)
    var sharkWord = Word(name: sharkWN)
    var sheepWord = Word(name: sheepWN)
    var squirrelWord = Word(name: squirrelWN)
    var whaleWord = Word(name: whaleWN)
    
    static private let bearWN: String = NSLocalizedString("bearWN", comment: "")
    static private let birdWN: String = NSLocalizedString("birdWN", comment: "")
    static private let catWN: String = NSLocalizedString("catWN", comment: "")
    static private let chickenWN: String = NSLocalizedString("chickenWN", comment: "")
    static private let cowWN: String = NSLocalizedString("cowWN", comment: "")
    static private let dogWN: String = NSLocalizedString("dogWN", comment: "")
    static private let dolphinWN: String = NSLocalizedString("dolphinWN", comment: "")
    static private let duckWN: String = NSLocalizedString("duckWN", comment: "")
    static private let fishWN: String = NSLocalizedString("fishWN", comment: "")
    static private let horseWN: String = NSLocalizedString("horseWN", comment: "")
    static private let pigWN: String = NSLocalizedString("pigWN", comment: "")
    static private let rabbitWN: String = NSLocalizedString("rabbitWN", comment: "")
    static private let sharkWN: String = NSLocalizedString("sharkWN", comment: "")
    static private let sheepWN: String = NSLocalizedString("sheepWN", comment: "")
    static private let squirrelWN: String = NSLocalizedString("squirrelWN", comment: "")
    static private let whaleWN: String = NSLocalizedString("whaleWN", comment: "")

    
    //MARK: - Foods
    
    let foodsCompleteImage = UIImage(named: "foodComplete")
    let foodsInCompleteImage = UIImage(named: "foodsINcomplete")
    
    let foodsName = "Foods"
    var foods:[Word]
    
    var appleWord = Word(name: appleWN)
    var bananaWord = Word(name: bannanaWN)
    var carrotWord = Word(name: carrotWN)
   // var carrotsWord = Word(name: "Carrots")
    var cornWord = Word(name: cornWN)
    var donutWord = Word(name: donutWN)
    var eggWord = Word(name: eggWN)
    var milkWord = Word(name: milkWN)
    var orangeWord = Word(name: orangeWN)
  //  var riceWord = Word(name: "Rice")
    var cheeseWord = Word(name: cheeseWN)
    var pizzaWord = Word(name: pizzaWN)
    
    static private let appleWN: String = NSLocalizedString("appleWN", comment: "")
    static private let bannanaWN: String = NSLocalizedString("bannanaWN", comment: "")
    static private let carrotWN: String = NSLocalizedString("carrotWN", comment: "")
    static private let cornWN: String = NSLocalizedString("cornWN", comment: "")
    static private let donutWN: String = NSLocalizedString("donutWN", comment: "")
    static private let eggWN: String = NSLocalizedString("eggWN", comment: "")
    static private let milkWN: String = NSLocalizedString("milkWN", comment: "")
    static private let orangeWN: String = NSLocalizedString("orangeWN", comment: "")
    static private let cheeseWN: String = NSLocalizedString("cheeseWN", comment: "")
    static private let pizzaWN: String = NSLocalizedString("pizzaWN", comment: "")
    
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

    var sunWord = Word(name: sunWN)
    var moonWord = Word(name: moonWN)
    var earthWord = Word(name: earthWN)
    var jupiterWord = Word(name: jupiterWN)
    var marsWord = Word(name: marsWN)
    var mercuryWord = Word(name: mercuryWN)
    var neptuneWord = Word(name: neptuneWN)
    var uranusWord = Word(name: uranusWN)
    var venusWord = Word(name: venusWN)
    var plutoWord = Word(name: plutoWN)
    var saturnWord = Word(name: saturnWN)
    
    static private let sunWN: String = NSLocalizedString("sunWN", comment: "")
    static private let moonWN: String = NSLocalizedString("moonWN", comment: "")
    static private let earthWN: String = NSLocalizedString("earthWN", comment: "")
    static private let jupiterWN: String = NSLocalizedString("jupiterWN", comment: "")
    static private let marsWN: String = NSLocalizedString("marsWN", comment: "")
    static private let mercuryWN: String = NSLocalizedString("mercuryWN", comment: "")
    static private let neptuneWN: String = NSLocalizedString("neptuneWN", comment: "")
    static private let uranusWN: String = NSLocalizedString("uranusWN", comment: "")
    static private let venusWN: String = NSLocalizedString("venusWN", comment: "")
    static private let plutoWN: String = NSLocalizedString("plutoWN", comment: "")
    static private let saturnWN: String = NSLocalizedString("saturnWN", comment: "")

    
   
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
