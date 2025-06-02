//
//  WordStackCollectionCell.swift
//  ABC_Vision
//
//  Created by Wylan L Neely on 8/12/24.
//

import UIKit

class WordStackCollectionCell: UICollectionViewCell {
    
    var wordStack: WordStack?
    var isUnlocked: Bool = true

    override func awakeFromNib() {
        super.awakeFromNib()
        self.contentView.layer.borderWidth = 1.0
             self.contentView.layer.borderColor = UIColor.lightGray.cgColor
    }

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    
    func setUpWordStackVisuals(wordStack: WordStack?){
        self.wordStack = wordStack
    }
    
    override var isSelected: Bool {
          didSet {
              updateUIForSelectionState()
          }
      }
      
      private func updateUIForSelectionState() {
          if isSelected {
              // Update the cell's appearance for the selected state
              if isUnlocked {
                  self.contentView.backgroundColor = UIColor.opaqueABCGreen
                  titleLabel.textColor = .white
              } else {
                  self.contentView.backgroundColor = UIColor.opaqueABCRed
                  titleLabel.textColor = .black
              }
          } else {
              if isUnlocked {
                  self.contentView.backgroundColor = UIColor.opaqueABCBlue
                  titleLabel.textColor = .black
              } else {
                  self.contentView.backgroundColor = UIColor.opaqueABCRed
                  titleLabel.textColor = .black
              }
          }
      }
      
}
