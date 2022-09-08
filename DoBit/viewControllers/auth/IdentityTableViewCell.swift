//
//  IdentityTableViewCell.swift
//  DoBit
//
//  Created by 서민주 on 2021/07/19.
//

import UIKit

class IdentityTableViewCell: UITableViewCell {
    @IBOutlet weak var identityLabel: UILabel!
    @IBOutlet weak var selectedView: UIView!
    
    override class func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
    }
    
    func setUpElements() {
        selectedView.setCornerRoundedFilled(with: .appColor(.DarkGrey)) // TODO: C7C7C7
        identityLabel.font = .fontKorean()
    }
}
