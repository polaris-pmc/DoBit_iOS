//
//  GoalViewController.swift
//  DoBit
//
//  Created by 서민주 on 2021/07/06.
//

import UIKit
import SnapKit

class GoalViewController: UIViewController {
    @IBOutlet var viewModel: IdentityViewModel!
    
    @IBOutlet weak var nicknameLabel: UILabel!
    @IBOutlet weak var goalTableView: UITableView!
    @IBOutlet weak var addButton: UIButton!
    
   
    
    let refreshControl = UIRefreshControl()
    var updateInfo: (status: String, idx: Int)?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        goalTableView.delegate = self
        goalTableView.dataSource = self
        
        refreshControl.attributedTitle = NSAttributedString(string: "Pull to refresh")
        refreshControl.addTarget(self, action: #selector(self.refreshGoal(_:)), for: .valueChanged)
        goalTableView.addSubview(refreshControl)
        self.navigationController?.navigationBar.transparentNavigationBar()
        
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(self.update),
                                               name: NSNotification.Name(rawValue: "updateIdentity"),
                                               object: nil)
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(self.insert),
                                               name: NSNotification.Name(rawValue: "insertIdentity"),
                                               object: nil)
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(self.remove),
                                               name: NSNotification.Name(rawValue: "deleteIdentity"),
                                               object: nil)
        
        nicknameLabel.text = UserDefaults.standard.string(forKey: "nickname")
        setTableViewStyle()
        setupElements()

        viewModel.list { _ in
            self.goalTableView.reloadData()
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.setNavigationBarHidden(true, animated: true)
        super.viewWillAppear(animated)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        navigationController?.setNavigationBarHidden(false, animated: true)
        super.viewWillDisappear(animated)
    }
    
    @objc func insert(_ notification: Notification) {
//        guard let identityName = notification.userInfo?["identityName"] as? String else {
//            return
//        }
        
        viewModel.list { isSuccess in
            if isSuccess {
                self.goalTableView.beginUpdates()
                self.goalTableView.insertRows(at: [IndexPath(row: self.viewModel.identityCount() - 1, section: 0)], with: .none)
                self.goalTableView.endUpdates()
            }
        }
    }
    
    @objc func update(_ notification: Notification) {
        guard let row = notification.userInfo?["row"] as? Int else {
            return
        }
        viewModel.list { isSuccess in
            if isSuccess {
                self.goalTableView.beginUpdates()
                self.goalTableView.reloadRows(at: [IndexPath(row: row, section: 0)], with: .none)
                self.goalTableView.endUpdates()
            }
        }
    }
    
    @objc func remove(_ notification: Notification) {
        guard let row = notification.userInfo?["row"] as? Int else {
            return
        }
        goalTableView.beginUpdates()
        goalTableView.deleteRows(at: [IndexPath(row: row, section: 0)], with: .none)
        viewModel.deleteIdentity(at: row)
        goalTableView.endUpdates()
    }
    
    @objc func refreshGoal(_ sender: AnyObject) {
        viewModel.list { isSuccess in
            if isSuccess {
                self.goalTableView.reloadData()
                self.refreshControl.endRefreshing()                
            }
        }
    }
    
    func setupElements() {
        addButton.setFloatingButton()
    }
    
    func setTableViewStyle() {
        goalTableView.tableHeaderView = UIView(frame: .zero)
        goalTableView.sectionHeaderHeight = 0
        goalTableView.tableFooterView = UIView(frame: .zero)
        goalTableView.sectionFooterHeight = 0
    }
    
    @IBAction func addTapped(_ sender: Any) {
        performSegue(withIdentifier: "showDetailView", sender: nil)
    }
    @IBAction func logoutTapped(_ sender: Any) {
        UserDefaults.standard.removeObject(forKey: "jwt")
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let authNavController = storyboard.instantiateViewController(identifier: "AuthNavController")
        
        (UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate)?.changeRootViewController(authNavController)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if let indexPath = sender as? Int {
            let detailVC = segue.destination as! GoalDetailViewController
            
            let idx = viewModel.identityIdx(of: indexPath)
            detailVC.indexPath = indexPath
            detailVC.identityIdx = idx
        }

        navigationItem.backBarButtonItem = UINavigationItem.backItem
    }
}

extension GoalViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.identityCount()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "GoalTableViewCell", for: indexPath) as? GoalTableViewCell else {
            return UITableViewCell()
        }
        
        let goal = viewModel.identity(at: indexPath.row)
        let goalInfo = goal.identityInfo as! UserIdentityResponse
        
        cell.goalTitleLabel.text = goalInfo.userIdentityName
        cell.doLabel.text = goalInfo.doHabitName
        cell.dontLabel.text = goalInfo.dontHabitName
        cell.setLayout(color: goal.color)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        performSegue(withIdentifier: "showDetailView", sender: indexPath.row)
    }
}

