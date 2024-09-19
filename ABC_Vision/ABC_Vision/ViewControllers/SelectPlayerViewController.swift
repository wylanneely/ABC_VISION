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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //setUpLoadedPlayers()
        loadPlayers()
        loadPlayersIntoButtons()
        showHideButtons()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        animateCartoonCat()
    }
    
    var player1: Player?
    var player2: Player?
    var player3: Player?


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
            
            let attributes: [NSAttributedString.Key: Any] = [
                .font: UIFont(name: "Chalkboard SE Bold", size: 40) as Any, // Set the font and size
                .foregroundColor: UIColor.abcGreen // Optional: Set the text color
            ]
            
            let attributedTitle = NSAttributedString(string: player.nickname, attributes: attributes)
            button?.setAttributedTitle(attributedTitle, for: .normal)
            
            button?.imageView?.contentMode = .scaleToFill
            button?.setImage(UIImage(named: "SignInPencil"), for: .normal)
          //  button?.backgroundColor = .opaqueABCBlue
        }
    }
    
    func showHideButtons(){
        
        let players = [player1,player2,player3]
        var index = 0
        for player in players {
            if let p = player {
                index = index + 1
            }
        }
        switch index {
        case 0:
            playerButton2.isHidden = true
            playerButton3.isHidden = true
        case 1:
            playerButton3.isHidden = true
        default:
            return
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
    
    //MARK: - Animations
    
    @IBOutlet weak var cartoonCatImageView: UIImageView!
    
    
    func animateCartoonCat() {
        let originalPosition = cartoonCatImageView.frame.origin
        
        let viewWidth = self.view.frame.width
        let viewHeight = self.view.frame.height
        
        let topRight = CGPoint(x: viewWidth - cartoonCatImageView.frame.width, y: 0)
        let bottomLeft = CGPoint(x: 0, y: viewHeight - cartoonCatImageView.frame.height)
        let middleRight = CGPoint(x: viewWidth - cartoonCatImageView.frame.width, y: viewHeight / 2 - cartoonCatImageView.frame.height / 2)
        
        let duration = 10.0
        
        // Step 1: Move to top right
        UIView.animate(withDuration: duration, animations: {
            self.cartoonCatImageView.frame.origin = topRight
        }) { _ in
            // Step 2: Move to bottom left
            UIView.animate(withDuration: duration, animations: {
                self.cartoonCatImageView.frame.origin = bottomLeft
            }) { _ in
                // Step 3: Move to middle right
                UIView.animate(withDuration: duration, animations: {
                    self.cartoonCatImageView.frame.origin = middleRight
                }) { _ in
                    // Step 4: Move back to original position
                    UIView.animate(withDuration: duration, animations: {
                        self.cartoonCatImageView.frame.origin = originalPosition
                    }) { _ in
                        self.animateCartoonCat()
                    }
                }
            }
        }
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
