//
//  IdentityViewController.swift
//  DoBit
//
//  Created by 서민주 on 2021/07/16.
//

import UIKit

class IdentityViewController: UIViewController {
    @IBOutlet var viewModel: IdentityViewModel!
    
    @IBOutlet weak var nicknameLabel: UILabel!
    @IBOutlet weak var identityTableView: UITableView!
    @IBOutlet weak var identityTextField: UITextField!
    
    var selectedIdentities: [Int] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        identityTableView.delegate = self
        identityTableView.dataSource = self
        identityTextField.delegate = self
        
        viewModel.list(isExample: true) { _ in
            self.identityTableView.reloadData()
        }
        setupElements()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    func setupElements() {
        identityTableView.layer.masksToBounds = true
        // TODO: top, bottom border만 보이게
        identityTableView.layer.borderColor = UIColor.appColor(.DoBitBlack).cgColor
        identityTableView.layer.borderWidth = 1.0
        
        identityTextField.setBottomBorder()
        
        guard let nickname = UserDefaults.standard.string(forKey: "nickname") else {
            //            debugPrint("no nickname")
            return
        }
        nicknameLabel.text = nickname
    }
    
    @IBAction func prevTapped(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func startTapped(_ sender: Any) {
        guard !selectedIdentities.isEmpty else {
            showAlert(AlertService.showAlert("정체성 선택", "정체성을 하나 이상 선택해주세요"))
            return
        }
        
        viewModel.sendIdentity(selectedIdentities) { isSuccess in
            if isSuccess {
                self.performSegue(withIdentifier: "showGoalView", sender: nil)
            }
        }
    }
}

extension IdentityViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.identityCount()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "IdentityTableViewCell", for: indexPath) as? IdentityTableViewCell else {
            return UITableViewCell()
        }
        
        cell.setUpElements()
        
        let identity = viewModel.identity(at: indexPath.row)
        let identityInfo = identity.identityInfo as! IdentityResponse
        
        cell.identityLabel.text = identityInfo.identityName
        
        if let isSelected = identity.selected, isSelected {
            cell.identityLabel.textColor = .appColor(.DoBitBlack)
            cell.selectedView.backgroundColor = .appColor(.DoBitBlack)
        } else {
            cell.identityLabel.textColor = .appColor(.DarkGrey)
            cell.selectedView.backgroundColor = .appColor(.DarkGrey)
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        viewModel.toggleSelected(indexOf: indexPath.row)
        let selectedIdentityInfo = viewModel.identity(at: indexPath.row).identityInfo as! IdentityResponse
        selectedIdentities.append(selectedIdentityInfo.identityIdx)
        
        let cell: IdentityTableViewCell = identityTableView.cellForRow(at: indexPath) as! IdentityTableViewCell
        
        cell.identityLabel.toggleTextColor()
        cell.selectedView.toggleBackgroundColor()
    }
}

extension IdentityViewController {
    override func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if let text = textField.text {
            viewModel.makeIdentity(name: text) {
                
                let newIdentityIdx = self.viewModel.identityCount() - 1
                let newIdentityIndexPath = IndexPath.init(row: newIdentityIdx, section: 0)
                
                self.identityTableView.beginUpdates()
                self.identityTableView.insertRows(at: [newIdentityIndexPath], with: .automatic)
                self.identityTableView.endUpdates()
                self.identityTableView.scrollToRow(at: IndexPath.init(row: newIdentityIdx, section: 0), at: .bottom, animated: true)
                
                self.identityTextField.text = ""
                self.identityTextField.resignFirstResponder()
            }
        }
        return true
    }
}
