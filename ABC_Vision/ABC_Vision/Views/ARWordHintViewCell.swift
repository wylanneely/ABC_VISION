//
//  ARWordHintViewCell.swift
//  ABC_Vision
//
//  Created by Wylan L Neely on 8/15/24.
//

import UIKit

class ARWordHintViewCell: UITableViewCell {

    @IBOutlet weak var wordLabel: UILabel!
    @IBOutlet weak var checkmarkImageView: UIImageView!
    
    var word: Word?
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func setUIStates(word: Word){
        wordLabel.text = word.name
        if word.isComplete {
            wordLabel.textColor = UIColor.abcGreen
            checkmarkImageView.tintColor = UIColor.abcGreen
        } else {
            wordLabel.textColor = UIColor.abcRed
            checkmarkImageView.tintColor = UIColor.abcRed
        }
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
