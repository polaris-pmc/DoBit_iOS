//
//  HabitTableViewCell.swift
//  DoBit
//
//  Created by 서민주 on 2021/07/26.
//

import UIKit

class HabitTableViewCell: UITableViewCell {
    
    @IBOutlet weak var doTitleLabel: UILabel!
    @IBOutlet weak var doDescriptionLabel: UILabel!
    @IBOutlet weak var doColorView: UIView!
    @IBOutlet weak var doContainer: DoContainer!
    
    @IBOutlet weak var dontTitleLabel: UILabel!
    @IBOutlet weak var dontDescriptionLabel: UILabel!
    @IBOutlet weak var dontColorView: UIView!
    @IBOutlet weak var dontContainer: DontContainer!
    
    override class func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func setLayout() {
        selectionStyle = .none
        
        doTitleLabel.font = .fontKorean(size: .subtitle)
        doDescriptionLabel.font = .fontKorean()
        doDescriptionLabel.textColor = .appColor(.DarkGrey)
        doColorView.setCornerRoundedEmpty()
        
        dontTitleLabel.font = .fontKorean(size: .subtitle)
        dontDescriptionLabel.font = .fontKorean()
        dontDescriptionLabel.textColor = .appColor(.DarkGrey)
        dontColorView.setCornerRoundedEmpty()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        var responder: UIResponder! = self
        
        while responder.next != nil {
            responder = responder.next
            if responder is HabitViewController {
                let vc = responder as! HabitViewController
                let indexPath = vc.habitTableView.indexPath(for: self)
                
                vc.tableView(vc.habitTableView, didSelectRowAt: indexPath!)
            }
        }
        
        super.touchesBegan(touches, with: event)
    }
}

class DoContainer: UIView {
    var isTouched: Bool = false
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.isTouched = true
        self.next?.touchesBegan(touches, with: event)
    }
}

class DontContainer: UIView {
    var isTouched: Bool = false
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.isTouched = true
        self.next?.touchesBegan(touches, with: event)
    }
}
