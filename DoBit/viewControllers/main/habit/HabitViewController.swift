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
    private lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = UIColor(named: "DoBitBlack")
        imageView.layer.borderColor = UIColor.white.cgColor
        imageView.layer.borderWidth = 1.6
        imageView.layer.cornerRadius = 8
        imageView.layer.shadowColor = UIColor.gray.cgColor
        imageView.layer.shadowOpacity = 0.77
        imageView.layer.shadowRadius = 10
        imageView.layer.shadowPath = nil
        return imageView
    }()
    
    private lazy var titleLabel: UILabel = {
        let titleLabel = UILabel()
        titleLabel.text = "안녕하세요. DoBit 팀 입니다.\n지금까지 DoBit을 이용해주신 여러분들 정말 감사합니다.\n앱 운영에 발생하는 비용적인 문제를 대응하기에는\n 어렵다는 판단이 들어\n부득이하게 22년 12월 31일자로 DoBit \n서비스를 종료하게 되었습니다.\n\nDoBit 서비스를 지속적으로 제공하지 못하게 된 점\n 진심으로 사과드립니다.\n\n기타 문의사항이 있으시다면\n kipsong133@gmail.com 로 연락주시면\n 최선을 다해 도와드리겠습니다.\n다시 한 번 고개숙여 죄송하다는 말씀과 \n감사하다는 말씀드립니다."
        titleLabel.textAlignment = .center
        titleLabel.numberOfLines = 0
        titleLabel.font = UIFont(name: "SpoqaHanSansNeo-Regular", size: 14)
        titleLabel.textColor = .white
        return titleLabel
        
    }()
    var toggleMap = [Int: (isDo: Bool, count: Int)]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupLayout()
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
    
    func setupLayout() {
        let key = "isFirstOpen"
        let isFirstOpen = UserDefaults.standard.bool(forKey: key)
        guard !isFirstOpen else { return }
        UserDefaults.standard.setValue(true, forKey: key)
        
        [ imageView ].forEach { view.addSubview($0) }
        imageView.addSubview(titleLabel)
        
        let inset = 16.0
        
        imageView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(inset)
            make.centerY.equalTo(view.snp.centerY)
            make.height.equalTo(imageView.snp.width)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.center.equalTo(imageView.snp.center)
        }
        
        let dismissGesutre = UITapGestureRecognizer(target: self, action: #selector(dismissNoticeView))
        view.addGestureRecognizer(dismissGesutre)
        view.isUserInteractionEnabled = true
    }
    
    @objc
    func dismissNoticeView() {
        UIView.animate(withDuration: 0.77, delay: 0) {
            self.imageView.alpha = 0
        }
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
