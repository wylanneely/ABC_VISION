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
        setUpLoadedPlayers()
        
        
    }
    

    func setUpLoadedPlayers(){
        if loadedPlayers.isEmpty {
            return
        } else {
            for player in loadedPlayers {
                if player1 == nil {
                    player1 = player
                }
                if player2 == nil {
                    player2 = player
                }
                if player3 == nil {
                    player3 = player
                }
            }
        }
    }
    func setButtonStates() {
        //TODO
    }
    
    
    //MARK: - Outlets
    @IBOutlet weak var playerButton1: UIButton!
    @IBOutlet weak var playerButton2: UIButton!
    @IBOutlet weak var playerButton3: UIButton!
    
    
    
    
    //MARK: - Actions
    @IBAction func player1ButtonTapped(_ sender: Any) {
        transitionToHome()
    }
    
    @IBAction func player2ButtonTapped(_ sender: Any) {
        transitionToHome()
    }
    
    @IBAction func player3ButtonTapped(_ sender: Any) {
        transitionToHome()
    }
    
    
    
    
    
    
    
    // MARK: - Navigation
    
    func transitionToHome() {
        guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
              let window = windowScene.windows.first else {
            return
        }
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        if let homeViewController = storyboard.instantiateViewController(withIdentifier: "HomeViewController") as? HomeViewController {
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