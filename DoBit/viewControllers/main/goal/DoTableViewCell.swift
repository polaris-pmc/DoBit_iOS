//
//  DoTableViewCell.swift
//  DoBit
//
//  Created by 서민주 on 2021/07/29.
//

import UIKit

class DoTableViewCell: UITableViewCell {
    
    @IBOutlet weak var doLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}
