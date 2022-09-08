//
//  GoalDetailViewController.swift
//  DoBit
//
//  Created by 서민주 on 2021/07/22.
//

import UIKit

class GoalDetailViewController: UIViewController {
    @IBOutlet var viewModel: GoalViewModel!
    
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var habitTableView: UITableView!
    @IBOutlet weak var deleteButton: UIButton!
    
    var indexPath: Int?
    var identityIdx: Int?
    var doHabitIdx: Int?
    var dontHabitIdx: Int?
    
    var isDoHabitAdded = (false, [String: Any]())
    var isDontHabitAdded = (false, [String: Any]())
    var isDoHabitUpdated = (false, [String: Any]())
    var isDontHabitUpdated = (false, [String :Any]())
    var isDoHabitDeleted: (Bool, Int?) = (false, nil)
    var isDontHabitDeleted: (Bool, Int?) = (false, nil)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        habitTableView.delegate = self
        habitTableView.dataSource = self
        
        habitTableView.layer.addBorder([.top, .bottom])
        
        if let idx = identityIdx {
            viewModel.detailIdentity(idx: idx) {
                self.titleTextField.text = self.viewModel.identity(of: "name") as? String
                
                if let doCell = self.habitTableView.cellForRow(at: IndexPath(row: 0, section: 0)) as? DoTableViewCell,
                   let dontCell = self.habitTableView.cellForRow(at: IndexPath(row: 1, section: 0)) as? DontTableViewCell {
                    
                    let doText = self.viewModel.identity(of: "do") as? String ?? ""
                    let dontText = self.viewModel.identity(of: "dont") as? String ?? ""
                    
                    doCell.doLabel.text = doText
                    dontCell.dontLabel.text = dontText
                    
                    // TODO: Color 정보도 setting
                }
            }
        }
        NotificationCenter.default.addObserver(self, selector: #selector(self.update),
                                               name: NSNotification.Name(rawValue: "updateHabit"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(self.add),
                                               name: NSNotification.Name(rawValue: "addHabit"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(self.remove),
                                               name: NSNotification.Name(rawValue: "deleteHabit"), object: nil)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    // MARK: - @objc func habit added, updated, deleted
    @objc func add(_ notification: Notification) {
        guard let isDo = notification.userInfo?["isDo"] as? Bool,
              let labelText = notification.userInfo?["text"] as? String,
              let params = notification.userInfo?["params"] as? [String: Any] else {
            return
        }
        
        if isDo {
            let cell = habitTableView.cellForRow(at: IndexPath(row: 0, section: 0)) as? DoTableViewCell
            cell?.doLabel.text = labelText
            isDoHabitAdded = (true, params)
        } else {
            let cell = habitTableView.cellForRow(at: IndexPath(row: 1, section: 0)) as? DontTableViewCell
            cell?.dontLabel.text = labelText
            isDontHabitAdded = (true, params)
        }
    }
    
    @objc func update(_ notification: Notification) {
        guard let isDo = notification.userInfo?["isDo"] as? Bool,
              let labelText = notification.userInfo?["text"] as? String,
              let params = notification.userInfo?["params"] as? [String: Any] else {
            return
        }
        
        if isDo {
            let cell = habitTableView.cellForRow(at: IndexPath(row: 0, section: 0)) as? DoTableViewCell
            cell?.doLabel.text = labelText
            isDoHabitUpdated = (true, params)
        } else {
            let cell = habitTableView.cellForRow(at: IndexPath(row: 1, section: 0)) as? DontTableViewCell
            cell?.dontLabel.text = labelText
            isDontHabitUpdated = (true, params)
        }
    }
    
    @objc func remove(_ notification: Notification) {
        guard let isDo = notification.userInfo?["isDo"] as? Bool else {
            return
        }
        
        if isDo {
            let cell = habitTableView.cellForRow(at: IndexPath(row: 0, section: 0)) as? DoTableViewCell
            cell?.doLabel.text = ""
            doHabitIdx = nil
            let habitIdx = notification.userInfo?["habitIdx"] as? Int
            isDoHabitDeleted = (true, habitIdx)
            isDoHabitAdded = (false, [:])
            isDoHabitUpdated = (false, [:])
        } else {
            let cell = habitTableView.cellForRow(at: IndexPath(row: 1, section: 0)) as? DontTableViewCell
            cell?.dontLabel.text = ""
            dontHabitIdx = nil
            let habitIdx = notification.userInfo?["habitIdx"] as? Int
            isDontHabitDeleted = (true, habitIdx)
            isDontHabitAdded = (false, [:])
            isDontHabitUpdated = (false, [:])
        }
    }
    
    // MARK: - IBActions
    @IBAction func completeTapped(_ sender: Any) {
        guard titleTextField.text != "" else {
            let alertView = AlertService.showAlert("필수 입력", "정체성 정의는 필수 입력 항목입니다.")
            showAlert(alertView)
            return
        }
            
        if let idx = identityIdx {
            viewModel.updateIdentity(idx: idx, title: titleTextField.text!, colorIdx: 9)
            habitManager(identityIdx: identityIdx!)
        } else {
            viewModel.addIdentity(name: titleTextField.text!) { identityIdx in
                self.habitManager(identityIdx: identityIdx)

                NotificationCenter.default.post(name: NSNotification.Name(rawValue: "insertIdentity"),
                                                object: nil,
                                                userInfo: ["identityName": self.titleTextField.text!])
                
            }
        }
        
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "updateIdentity"),
                                        object: nil, userInfo: ["row": indexPath as Any])
        
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func deleteTapped(_ sender: Any) {
        if let idx = identityIdx {
            viewModel.deleteIdentity(at: idx)
            
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "deleteIdentity"),
                                            object: nil, userInfo: ["row": indexPath!])
        }
        navigationController?.popViewController(animated: true)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        navigationItem.backBarButtonItem = UINavigationItem.backItem
        
        if segue.identifier == "showDoPlus" {
            let nextView = segue.destination as! DoDetailViewController
            if isDoHabitUpdated.0 {
                nextView.params = isDoHabitUpdated.1
            } else if identityIdx != nil {
                let doIdx = viewModel.identity(of: "doIdx") as? Int
                nextView.doHabitIdx = doIdx
            }
            nextView.params = isDoHabitAdded.1
            
        } else if segue.identifier == "showDontPlus" {
            let nextView = segue.destination as! DontDetailViewController
            if isDontHabitUpdated.0 {
                nextView.params = isDontHabitUpdated.1
            } else if identityIdx != nil {
                let dontIdx = viewModel.identity(of: "dontIdx") as? Int
                nextView.dontHabitIdx = dontIdx
            }
            nextView.params = isDontHabitAdded.1
        }
    }
    
    func habitManager(identityIdx: Int) {
        if isDoHabitAdded.0 {
            viewModel.makeHabit(identityIdx: identityIdx, isDo: true, params: isDoHabitAdded.1) {
                self.doHabitIdx = self.viewModel.identity(of: "doIdx") as? Int
            }
        }
        
        if isDontHabitAdded.0 {
            viewModel.makeHabit(identityIdx: identityIdx, isDo: false, params: isDontHabitAdded.1) {
                self.dontHabitIdx = self.viewModel.identity(of: "dontIdx") as? Int
            }
        }
        
        if isDoHabitUpdated.0 { viewModel.updateHabit(isDo: true, params: isDoHabitUpdated.1) }
        
        if isDontHabitUpdated.0 { viewModel.updateHabit(isDo: false, params: isDontHabitUpdated.1) }

        if isDoHabitDeleted.0, let habitIdx = isDoHabitDeleted.1 {
            viewModel.deleteHabit(habitIdx: habitIdx, isDo: true)
        }
        
        if isDontHabitDeleted.0, let habitIdx = isDontHabitDeleted.1 {
            viewModel.deleteHabit(habitIdx: habitIdx, isDo: false)
        }
    }
    
    // TODO: color views border radius & selected item border
}

extension GoalDetailViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "DoTableViewCell") as! DoTableViewCell
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "DontTableViewCell") as! DontTableViewCell
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        if indexPath.row == 0 {
            performSegue(withIdentifier: "showDoPlus", sender: nil)
        } else {
            performSegue(withIdentifier: "showDontPlus", sender: nil)
        }
    }
}
