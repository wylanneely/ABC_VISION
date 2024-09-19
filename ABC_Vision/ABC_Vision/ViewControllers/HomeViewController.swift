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
    var wordsCatagory: String?

    override func viewDidLoad() {
        super.viewDidLoad()
        setUpCollectionView()
        setPlayerProperties()
        DispatchQueue.main.async {
            self.selectFirstItem()
        }
    }
    
    func setPlayerProperties(){
        if let player = currentPlayer {
            playerNameLabel.text = player.nickname
        }
    }
    
    func selectFirstItem() {
        let firstIndexPath = IndexPath(row: 0, section: 0)
        wordStackCollectionView.selectItem(at: firstIndexPath, animated: true, scrollPosition: .top)
        collectionView(wordStackCollectionView, didSelectItemAt: firstIndexPath)
    }
    
    @IBOutlet weak var playerNameLabel: UILabel!
    
    //MARK: - Collection View
    @IBOutlet weak var wordStackCollectionView: UICollectionView!
    
    func setUpCollectionView() {
        wordStackCollectionView.delegate = self
        wordStackCollectionView.dataSource = self
        
        // Register the cell nib
        let nib = UINib(nibName: "WordStackCollectionCell", bundle: nil)
        wordStackCollectionView.register(nib, forCellWithReuseIdentifier: "WordStackCollectionCell")
        
        // Customize the layout
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 10 // Space between rows
        layout.minimumInteritemSpacing = 10 // Space between items (cells)
        
        // Set number of items per row (each cell will take 2 cells worth of space)
        let numberOfItemsPerRow: CGFloat = 2
        
        // Calculate item width by dividing screen width in half (for 2 cells across the width)
        let totalPadding = layout.minimumInteritemSpacing * (numberOfItemsPerRow - 1)
        let availableWidth = wordStackCollectionView.frame.width - totalPadding
        let itemWidth = availableWidth / numberOfItemsPerRow
        
        // Multiply by 2 to make each cell take 2 columns (the entire width)
        let fullWidthItemWidth = itemWidth * 2 + layout.minimumInteritemSpacing
        
        // Set the item height (you can adjust this as needed)
        let itemHeight = UIScreen.main.bounds.height / 3
        
        // Set the item size (full width cell)
        layout.itemSize = CGSize(width: fullWidthItemWidth, height: itemHeight)
        
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
            //Planets
        case 0:
            cell.imageView.image = testWordStackController.planetCompleteImage
            cell.titleLabel.text = testWordStackController.planetsName
            cell.contentView.backgroundColor = UIColor.opaqueABCBlue
            return cell
        case 1:
            //animals
            cell.imageView.image = testWordStackController.animalsCompleteImage
            cell.titleLabel.text = testWordStackController.animalsName
            cell.contentView.backgroundColor = UIColor.opaqueABCBlue

            return cell
        case 2:
            //foods
            cell.imageView.image = testWordStackController.foodsCompleteImage
            cell.titleLabel.text = testWordStackController.foodsName
           cell.contentView.backgroundColor = UIColor.opaqueABCBlue
 //TODO: - update to make real tap feature with color tmrw
            return cell
        default:
            cell.contentView.backgroundColor = UIColor.opaqueABCBlue
            return cell
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let selectedCell = collectionView.cellForItem(at: indexPath) as? WordStackCollectionCell {
            selectedCell.isSelected = true
            // Additional logic can be handled here if needed
            wordsCatagory =  selectedCell.titleLabel.text
        }
        
        // Deselect any previously selected cell
//        if let selectedItems = collectionView.indexPathsForSelectedItems {
//            for selectedIndexPath in selectedItems where selectedIndexPath != indexPath {
//                collectionView.deselectItem(at: selectedIndexPath, animated: false)
//                if let deselectedCell = collectionView.cellForItem(at: selectedIndexPath) as? WordStackCollectionCell {
//                    deselectedCell.isSelected = false
//                }
//            }
//        }
    }

    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toTextRead" {
               if let destinationVC = segue.destination as? TextCaptureViewController {
                   destinationVC.testWordCategory = wordsCatagory // Replace with your actual string variable
               }
           }
    }
    

}
