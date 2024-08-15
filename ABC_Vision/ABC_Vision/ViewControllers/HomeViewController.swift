//
//  HomeViewController.swift
//  ABC_Vision
//
//  Created by Wylan L Neely on 8/1/24.
//

import UIKit

class HomeViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {

    var currentPlayer: Player?
    
    var testWordStackController = WordStackController()

    
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
    
    func setUpCollectionView() {
        wordStackCollectionView.delegate = self
        wordStackCollectionView.dataSource = self
        
        // Register the cell nib
        let nib = UINib(nibName: "WordStackCollectionCell", bundle: nil)
        self.wordStackCollectionView.register(nib, forCellWithReuseIdentifier: "WordStackCollectionCell")
        
        // Customize the layout
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 10 // Space between rows
        layout.minimumInteritemSpacing = 10 // Space between items (cells)
        
        // Calculate item size
        let numberOfItemsPerRow: CGFloat = 2
        let interItemSpacing = layout.minimumInteritemSpacing * (numberOfItemsPerRow - 1)
        let totalPadding = interItemSpacing + 20 // Assuming 10 points padding on each side
        let availableWidth = wordStackCollectionView.frame.width - totalPadding
        let itemWidth = availableWidth / numberOfItemsPerRow
        
        // Set the item height to 1/3 of the screen height
        let itemHeight = UIScreen.main.bounds.height / 3
        
        // Set the item size
        layout.itemSize = CGSize(width: itemWidth, height: itemHeight)

        wordStackCollectionView.collectionViewLayout = layout
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 4
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = wordStackCollectionView.dequeueReusableCell(withReuseIdentifier: "WordStackCollectionCell", for: indexPath) as? WordStackCollectionCell else {
            return UICollectionViewCell()
        }
        //TEST
        switch indexPath.row {
        case 0:
            cell.image.image = testWordStackController.planetCompleteImage
            cell.title.text = testWordStackController.planetsName
                return cell
        case 1:
            cell.image.image = testWordStackController.animalsCompleteImage
            cell.title.text = testWordStackController.animalsName
                return cell
        case 2:
            cell.image.image = testWordStackController.foodsCompleteImage
            cell.title.text = testWordStackController.foodsName
            return cell
        default:
            return cell
        }
        
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
