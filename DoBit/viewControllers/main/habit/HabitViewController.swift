//
//  HabitViewController.swift
//  DoBit
//
//  Created by 서민주 on 2021/07/06.
//

import UIKit

class HabitViewController: UIViewController {
    @IBOutlet var viewModel: HabitViewModel!
    
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var habitTableView: UITableView!
    
    var toggleMap = [Int: (isDo: Bool, count: Int)]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        dateLabel.text = DateUtil.shared.formatDateStringWithDot(date: Date())
        
        habitTableView.delegate = self
        habitTableView.dataSource = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        viewModel.list {
            self.habitTableView.reloadData()
        }
        super.viewWillAppear(animated)
    }
}

extension HabitViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.habitCount()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "HabitTableViewCell", for: indexPath) as? HabitTableViewCell else {
            return UITableViewCell()
        }
        
        let habit = viewModel.habit(at: indexPath.row)
        
        cell.setLayout()
        
        cell.doTitleLabel.text = habit.doHabitName
        cell.doDescriptionLabel.text = habit.doHabitSummary
        
        cell.dontTitleLabel.text = habit.dontHabitName
        cell.dontDescriptionLabel.text = habit.dontHabitSummary
        
        let color: UIColor = .appColor(Colors(rawValue: habit.userIdentityColorName)!)
        if habit.isDoHabitCheck == "Y" {
            cell.doColorView.setCornerRoundedFilled(with: color)
        } else {
            cell.doColorView.setCornerRoundedEmpty()
        }
        
        if habit.isDontHabitCheck == "Y" {
            cell.dontColorView.setCornerRoundedFilled(with: color)
        } else {
            cell.dontColorView.setCornerRoundedEmpty()
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let cell = habitTableView.cellForRow(at: indexPath) as! HabitTableViewCell
        let habit = viewModel.habit(at: indexPath.row)
        let color: UIColor = .appColor(Colors(rawValue: habit.userIdentityColorName)!)
        
        if cell.doContainer.isTouched, let habitIdx = habit.doHabitIdx {
            cell.doContainer.isTouched = false
            cell.doColorView.toggleViewColor(with: color)
            viewModel.toggleView(isDohabit: true, habitIndex: habitIdx)
        } else if let habitIdx = habit.dontHabitIdx {
            cell.dontContainer.isTouched = false
            cell.dontColorView.toggleViewColor(with: color)
            viewModel.toggleView(isDohabit: false, habitIndex: habitIdx)
        }
    }
}
