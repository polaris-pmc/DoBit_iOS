//
//  GoalNavigationController.swift
//  DoBit
//
//  Created by 서민주 on 2021/07/24.
//

import UIKit

class GoalNavigationController: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.transparentNavigationBar()
        navigationBar.layer.borderColor = UIColor.appColor(.DoBitGrey).cgColor
    }
}
