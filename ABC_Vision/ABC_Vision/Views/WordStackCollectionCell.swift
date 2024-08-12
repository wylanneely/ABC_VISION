//
//  WordStackCollectionCell.swift
//  ABC_Vision
//
//  Created by Wylan L Neely on 8/12/24.
//

import UIKit

class WordStackCollectionCell: UICollectionViewCell {
    
    var wordStack: WordStack?

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    @IBOutlet weak var image: UIImageView!
    @IBOutlet weak var title: UILabel!
    
    func setUpWordStackVisuals(wordStack: WordStack?){
        self.wordStack = wordStack
        
    }
    
}
