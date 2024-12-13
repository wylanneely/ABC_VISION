//
//  ARWordHintCell.swift
//  ABC_Vision
//
//  Created by Wylan L Neely on 12/13/24.
//
    import UIKit

    class ARWordHintCell: UICollectionViewCell {

        @IBOutlet weak var wordLabel: UILabel!
        
        @IBOutlet weak var checkmarkImageView: UIImageView!
        
        var word: Word?
        
        override func awakeFromNib() {
            super.awakeFromNib()
            // Initialization code
        }
        
        func setUIStates(word: Word) {
            self.word = word
            wordLabel.text = word.name
            if word.isComplete {
                wordLabel.textColor = UIColor.abcGreen
                checkmarkImageView.tintColor = UIColor.abcGreen
            } else {
                wordLabel.textColor = UIColor.abcRed
                checkmarkImageView.tintColor = UIColor.opaqueABCRed
            }
        }
    }
