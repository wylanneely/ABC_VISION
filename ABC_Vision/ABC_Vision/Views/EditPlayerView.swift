//
//  EditPlayerView.swift
//  ABC_Vision
//
//  Created by Wylan L Neely on 9/24/24.
//

import UIKit

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
    }
    @IBAction func helpButtonTapped(_ sender: Any) {
    }
    
    // MARK: - Navigation
     
     
    @IBAction func dismissButtonTapped(_ sender: Any) {
        self.dismiss(animated: true)
    }
    

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    

}
