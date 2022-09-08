//
//  GoalSectionTableViewCell.swift
//  DoBit
//
//  Created by 서민주 on 2021/07/16.
//

import UIKit

class GoalSectionTableViewCell: UITableViewCell {
    
    @IBOutlet weak var goalLabel: UILabel!
    @IBOutlet weak var dropDownButton: UIButton!
    
    override class func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func setLayout(background: UIColor) {
        goalLabel.font = .fontKorean()
        dropDownButton.setColor()
        backgroundColor = background
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
}
