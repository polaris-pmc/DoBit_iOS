//
//  GoalTableViewCell.swift
//  DoBit
//
//  Created by 서민주 on 2021/07/16.
//

import UIKit

class GoalTableViewCell: UITableViewCell {
    
    @IBOutlet weak var colorView: UIView!
    @IBOutlet weak var goalTitleLabel: UILabel!
    @IBOutlet weak var doLabel: UILabel!
    @IBOutlet weak var dontLabel: UILabel!
    @IBOutlet weak var habitStackView: UIStackView!
    @IBOutlet weak var doStackView: UIStackView!
    @IBOutlet weak var dontStackView: UIStackView!
    @IBOutlet weak var defaultLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        doLabel.text = nil
        dontLabel.text = nil
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func setLayout(color: UIColor = .appColor(.DoBitBlack)) {
        colorView.backgroundColor = color
        colorView.setCornerRoundedFilled(with: color)
        
        if !(doLabel.text?.isEmpty ?? true) || !(dontLabel.text?.isEmpty ?? true) {
            defaultLabel.isHidden = true
            doStackView.isHidden = false
            dontStackView.isHidden = false
        } else {
            doStackView.isHidden = true
            dontStackView.isHidden = true
            defaultLabel.isHidden = false
        }
    }
}
