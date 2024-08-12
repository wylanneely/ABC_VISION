//
//  HomeViewController.swift
//  ABC_Vision
//
//  Created by Wylan L Neely on 8/1/24.
//

import UIKit

class HomeViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {

    var currentPlayer: Player?

    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpCollectionView()
        setPlayerProperties()
    }
    
    func setPlayerProperties(){
        if let player = currentPlayer {
            playerNameLabel.text = player.nickname
        }
    }
    
    @IBOutlet weak var playerNameLabel: UILabel!
    
    //MARK: - Collection View
    @IBOutlet weak var wordStackCollectionView: UICollectionView!
    
    func setUpCollectionView(){
        wordStackCollectionView.delegate = self
        wordStackCollectionView.dataSource = self
        let nib = UINib(nibName: "WordStackCollectionCell", bundle: nil)
        self.wordStackCollectionView.register(nib, forCellWithReuseIdentifier: "WordStackCollectionCell")
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 4
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = wordStackCollectionView.dequeueReusableCell(withReuseIdentifier: "WordStackCollectionCell", for: indexPath) as? WordStackCollectionCell else {
            return UICollectionViewCell()
        }
            return cell
    }
    
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
