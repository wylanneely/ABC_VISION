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
//    var WordHintLabelDelegate: WordHintLabelChangeDelegate?
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func setUIStates(word: Word){
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
//
//    override func setSelected(_ selected: Bool, animated: Bool) {
//        super.setSelected(selected, animated: animated)
//        if let w = word {
//            WordHintLabelDelegate?.setWordAssistLabel(word: w.name, isComplete: w.isComplete)
//        }
//    }
    
//    override var isSelected: Bool {
//          didSet {
//              if let w = word {
//                  WordHintLabelDelegate?.setWordAssistLabel(word: w.name, isComplete: w.isComplete)
//              }
//          }
//      }
      

}
//
//protocol WordHintLabelChangeDelegate {
//    func setWordAssistLabel(word:String,isComplete:Bool)
//}
