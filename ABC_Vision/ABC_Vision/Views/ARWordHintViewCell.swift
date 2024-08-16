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

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
