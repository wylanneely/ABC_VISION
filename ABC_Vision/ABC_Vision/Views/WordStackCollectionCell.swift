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
              self.contentView.backgroundColor = .blue
              titleLabel.textColor = .white
          } else {
              // Update the cell's appearance for the normal state
              self.contentView.backgroundColor = .white
              titleLabel.textColor = .black
          }
      }
      
}
