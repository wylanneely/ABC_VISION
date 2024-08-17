//
//  SelectPlayerViewController.swift
//  ABC_Vision
//
//  Created by Wylan L Neely on 8/2/24.
//

import UIKit

class SelectPlayerViewController: UIViewController {
    
    
    var loadedPlayers: [Player] {
        return GameController.shared.players
    }
    var player1: Player?
    var player2: Player?
    var player3: Player?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //setUpLoadedPlayers()
        loadPlayersIntoButtons()
        loadPlayers()
    }
    

    func loadPlayers() {
        var i = 0
        
        for player in loadedPlayers {
            if i == 0 {
                player1 = player
            }
            if i == 1 {
                player2 = player
            }
            if i == 2 {
                player3 = player
            }
                i = i + 1
        }
    }

    func loadPlayersIntoButtons() {
        
        let playerButtons = [playerButton1,playerButton2,playerButton3]
        
        for (index, player) in loadedPlayers.enumerated() {
            guard index < playerButtons.count else { break }
            let button = playerButtons[index]
            button?.setTitle(player.nickname, for: .normal) // Set the title to the player's nickname
            // Optionally, you can set other properties like background color or image
        }
    }
    
    //MARK: - Outlets
    @IBOutlet weak var playerButton1: UIButton!
    @IBOutlet weak var playerButton2: UIButton!
    @IBOutlet weak var playerButton3: UIButton!
    
    
    
    
    //MARK: - Actions
    @IBAction func player1ButtonTapped(_ sender: Any) {
        if let player1 = player1 {
            transitionToHome(withPlayer: player1)
        } else {
            createPlayerTransistion()
        }
    }
    
    @IBAction func player2ButtonTapped(_ sender: Any) {
        if let player2 = player2 {
            transitionToHome(withPlayer: player2)
        } else {
            createPlayerTransistion()
        }
    }
    
    @IBAction func player3ButtonTapped(_ sender: Any) {
        if let player3 = player3 {
            transitionToHome(withPlayer: player3)
        } else {
            createPlayerTransistion()
        }
    }
    
    
    func createPlayerTransistion(){
        self.performSegue(withIdentifier: "toCreatePlayer", sender: self)
    }
    
    // MARK: - Navigation
    
    func transitionToHome(withPlayer: Player) {
        guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
              let window = windowScene.windows.first else {
            return
        }
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        if let homeViewController = storyboard.instantiateViewController(withIdentifier: "HomeViewController") as? HomeViewController {
            homeViewController.currentPlayer = withPlayer
            window.rootViewController = homeViewController
            UIView.transition(with: window,
                              duration: 0.5,
                              options: [.transitionFlipFromRight],
                              animations: nil,
                              completion: nil)
        }
    }

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    

}
