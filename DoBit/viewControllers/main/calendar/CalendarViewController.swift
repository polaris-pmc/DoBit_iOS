//
//  CalendarViewController.swift
//  DoBit
//
//  Created by 서민주 on 2021/07/06.
//

import UIKit
import FSCalendar
import Charts

class CalendarViewController: UIViewController {
    @IBOutlet var viewModel: CalendarViewModel!
    
    @IBOutlet weak var calendar: FSCalendar!
    @IBOutlet weak var goalTableView: UITableView!
    
    let today = Date()
    var events: [Date] = []
    var currentPage: Date?
    var opened: Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        calendar.delegate = self
        calendar.dataSource = self
        goalTableView.delegate = self
        goalTableView.dataSource = self
        
        setTableViewStyle()
        setCalendarStyle()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        viewModel.list(year: today.year, month: today.month) {
            self.calendar.reloadData()
            self.goalTableView.reloadData()
        }
        super.viewDidAppear(animated)
    }
    
    func setTableViewStyle(rowHeight: Int = 41) {
        goalTableView.estimatedRowHeight = 41
        goalTableView.rowHeight = UITableView.automaticDimension
        
        goalTableView.tableHeaderView = UIView(frame: .zero)
        goalTableView.sectionHeaderHeight = 0
        goalTableView.tableFooterView = UIView(frame: .zero)
        goalTableView.sectionFooterHeight = 0
    }
    
    func setCalendarStyle() {
        let doBitBlack = UIColor.appColor(.DoBitBlack)
        calendar.layer.addBorder([.top, .bottom])
        calendar.locale = Locale(identifier: "ko_KR")
        calendar.appearance.headerDateFormat = "YYYY.MM"
        calendar.appearance.headerTitleColor = doBitBlack
        calendar.appearance.headerTitleFont = .systemFont(ofSize: 16, weight: .semibold)
        
        calendar.appearance.titleDefaultColor = doBitBlack
        calendar.appearance.titleWeekendColor = doBitBlack
        calendar.appearance.titleTodayColor  = doBitBlack
        calendar.appearance.titleOffset = CGPoint(x: 0, y: 10)
        calendar.appearance.titleFont = .systemFont(ofSize: 12, weight: .semibold)
        
        calendar.appearance.todayColor = doBitBlack
        calendar.appearance.weekdayTextColor = doBitBlack
        calendar.appearance.borderSelectionColor = doBitBlack
        
        calendar.appearance.eventDefaultColor = .appColor(.DoBitYellow)
        calendar.appearance.eventOffset = CGPoint(x: 0, y: -30)
        
        calendar.appearance.headerMinimumDissolvedAlpha = 0
    }
    
    @IBAction func prevTapped(_ sender: Any) {
        self.moveCurrentPage(moveUp: false)
    }
    
    @IBAction func nextTapped(_ sender: Any) {
        self.moveCurrentPage(moveUp: true)
    }
}

extension CalendarViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return viewModel.identityCount()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let cellData = viewModel.getCellData(idx: section)
        return cellData.opened ? 2 : 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.row == 0 {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "GoalSectionTableViewCell", for: indexPath) as? GoalSectionTableViewCell else {
                return UITableViewCell()
            }
            
            let data = viewModel.getCellData(idx: indexPath.section)
            cell.setLayout(background: data.color)
            if data.color == UIColor.appColor(.DoBitBlack) {
                cell.goalLabel.textColor = .white
            }
            cell.goalLabel.text = data.title
            
            return cell
        } else {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "GoalChartTableViewCell", for: indexPath) as? GoalChartTableViewCell else {
                return UITableViewCell()
            }
            
            let data = viewModel.getCellData(idx: indexPath.section)
            
            cell.setLayout(background: data.color)
            cell.setChart(values: data.sectionData, color: data.color)
            //            cell.goalLabel.text = data.sectionData[indexPath.row - 1]
            
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        tableView.deselectRow(at: indexPath, animated: true)
        
        if indexPath.row == 0 {
            if opened == indexPath.section {
                opened = nil
            } else if let section = opened {
                opened = indexPath.section
                viewModel.toggleSection(idx: section)
                tableView.reloadSections([section], with: .none)
            } else {
                opened = indexPath.section
            }
            
            viewModel.toggleSection(idx: indexPath.section)
            events = viewModel.getDates(idx: indexPath.section)
            calendar.reloadData()
            
            tableView.reloadSections([indexPath.section], with: .none)
            // TODO: selected section scroll to top
            //            tableView.scrollToRow(at: indexPath, at: .top, animated: true)
            //        } else {
            //            debugPrint("sectionData 선택")
        }
    }
}

extension CalendarViewController: FSCalendarDelegate, FSCalendarDataSource {
    func calendar(_ calendar: FSCalendar, numberOfEventsFor date: Date) -> Int {
        if self.events.contains(date) {
            return 1
        } else {
            return 0
        }
    }
    
    private func moveCurrentPage(moveUp: Bool) {
        
        let currentCalendar = Calendar.current
        
        var dateComponents = DateComponents()
        dateComponents.month = moveUp ? 1 : -1
        
        self.currentPage = currentCalendar.date(byAdding: dateComponents, to: self.currentPage ?? Date())
        self.calendar.setCurrentPage(self.currentPage!, animated: true)
        
        viewModel.list(year: self.currentPage!.year, month: self.currentPage!.month) {
            return
        }
    }
    
    func calendar(_ calendar: FSCalendar, shouldSelect date: Date, at monthPosition: FSCalendarMonthPosition) -> Bool {
        return false
    }
}

extension CalendarViewController: FSCalendarDelegateAppearance {
    func calendar(_ calendar: FSCalendar, appearance: FSCalendarAppearance, fillDefaultColorFor date: Date) -> UIColor? {
        return .appColor(.DoBitGrey)
    }
}
