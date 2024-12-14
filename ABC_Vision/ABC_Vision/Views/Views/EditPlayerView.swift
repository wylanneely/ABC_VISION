//
//  EditPlayerView.swift
//  ABC_Vision
//
//  Created by Wylan L Neely on 9/24/24.
//

import UIKit
import AVKit

class EditPlayerView: UIViewController {
    
    var currentPlayer: Player?
    
    @IBOutlet weak var playerNameLabel: UILabel!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        playerNickNameLabel.text = currentPlayer?.nickname
        // Do any additional setup after loading the view.
    }

    @IBOutlet weak var playerNickNameLabel: UILabel!
    
    
    @IBAction func deleteButtonTapped(_ sender: Any) {
        presentDeleteConfirmationAlert()
    }
    @IBAction func helpButtonTapped(_ sender: Any) {
        playIntroVideo()
    }
    
    func playIntroVideo() {
          // Get the video file URL from the app bundle
          if let videoPath = Bundle.main.path(forResource: "ABSeeHowTo", ofType: "mp4") {
              let videoURL = URL(fileURLWithPath: videoPath)
              
              let player = AVPlayer(url: videoURL)
              let playerViewController = AVPlayerViewController()
              playerViewController.player = player
              playerViewController.videoGravity = .resizeAspectFill
              // Present the video player
              self.present(playerViewController, animated: true) {
                  playerViewController.player?.play()
              }
          }
      }
    //MARK: - Alert
    
    func presentDeleteConfirmationAlert() {
        // Create the alert controller
        let alertController = UIAlertController(
            title: "Are you sure?",
            message: "Are you sure you would like to delete?",
            preferredStyle: .alert
        )
        
        let deleteAction = UIAlertAction(
            title: "Delete",
            style: .destructive
        ) { _ in
            // Handle delete action
            if let player = self.currentPlayer {
                GameController.shared.removePlayer(withNickname: player.nickname)
                self.returnToSelectPlayerVC()
            }
        }
        
        let cancelAction = UIAlertAction(
            title: "Cancel",
            style: .cancel
        ) { _ in
            // Handle cancel action
        }
        
        alertController.addAction(deleteAction)
        alertController.addAction(cancelAction)
        
        self.present(alertController, animated: true, completion: nil)
    }
    
    // MARK: - Navigation
   
    func returnToSelectPlayerVC(){
        guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
              let window = windowScene.windows.first else {
            return
        }
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        if let SelectPlayerVC = storyboard.instantiateViewController(withIdentifier: "SelectPlayerVC") as? SelectPlayerViewController {
            window.rootViewController = SelectPlayerVC
            UIView.transition(with: window,
                              duration: 0.5,
                              options: [.transitionFlipFromRight],
                              animations: nil,
                              completion: nil)
        }
    }
     
    @IBAction func dismissButtonTapped(_ sender: Any) {
        self.dismiss(animated: true)
    }
    

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    

}
