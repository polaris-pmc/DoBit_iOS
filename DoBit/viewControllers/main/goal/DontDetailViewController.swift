//
//  DontDetailViewController.swift
//  DoBit
//
//  Created by 서민주 on 2021/07/29.
//

import UIKit

class DontDetailViewController: UIViewController {
    @IBOutlet var viewModel: GoalViewModel!
    
    @IBOutlet weak var dontName: UITextField!
    @IBOutlet weak var dontAdvantage: UITextField!
    @IBOutlet weak var dontEnv: UITextField!
    @IBOutlet weak var dontRoutine1: UITextField!
    @IBOutlet weak var dontRoutine2: UITextField!
    @IBOutlet weak var dontRoutine3: UITextField!
    @IBOutlet weak var dontMotive1: UITextField!
    @IBOutlet weak var dontMotive2: UITextField!
    @IBOutlet weak var dontMotive3: UITextField!
    @IBOutlet weak var dontElse1: UITextField!
    @IBOutlet weak var dontElse2: UITextField!
    @IBOutlet weak var dontElse3: UITextField!
    
    var dontHabitIdx: Int?
    var params: [String: Any]?
    var allTextFields: [UITextField] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        allTextFields = [dontName, dontAdvantage, dontEnv,
                         dontRoutine1, dontRoutine2, dontRoutine3, dontMotive1, dontMotive2, dontMotive3, dontElse1, dontElse2, dontElse3]
        
        UITextField.connectAllTextFields(textFields: allTextFields)
        
        guard let habitIdx = dontHabitIdx else {
            if params != nil { self.fillTextFieldsWithParams() }
            return
        }
        viewModel.detailHabit(habitIdx: habitIdx, isDo: false) { isSuccess in
            if isSuccess {
                self.fillTextFields()
            }
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    @IBAction func completeTapped(_ sender: Any) {
        
        guard dontName.text != "" && dontAdvantage.text != "" && dontEnv.text != "" else {
            let alertView = AlertService.showAlert("필수 입력", "제어 습관, 이점, 환경은 필수 입력 항목입니다.")
            showAlert(alertView)
            return
        }
        let params = collectTexts()
        if dontHabitIdx != nil {
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "updateHabit"),
                                            object: nil,
                                            userInfo: ["isDo": false,
                                                       "text": dontName.text!,
                                                       "params": params])
        } else {
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "addHabit"),
                                            object: nil,
                                            userInfo: ["isDo": false,
                                                       "text": dontName.text!,
                                                       "params": params])
        }
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func deleteTapped(_ sender: Any) {
//        if let habitIdx = dontHabitIdx {
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "deleteHabit"),
                                            object: nil,
                                            userInfo: ["isDo": false,
                                                       "habitIdx": dontHabitIdx as Any])
//        }
        navigationController?.popViewController(animated: true)
    }
    
    func fillTextFields() {
        let dontHabit = self.viewModel.dontHabit!
        self.dontName.text = dontHabit.dontName
        self.dontAdvantage.text = dontHabit.dontAdvantage
        self.dontEnv.text = dontHabit.dontEnv
        
        if let routines = dontHabit.dontRoutine {
            switch routines.count {
            case 3:
                self.dontRoutine3.text = routines[2]
                fallthrough
            case 2:
                self.dontRoutine2.text = routines[1]
                fallthrough
            case 1:
                self.dontRoutine1.text = routines[0]
            default: ()
            }
        }
        if let motives = dontHabit.dontMotive {
            switch motives.count {
            case 3:
                self.dontMotive3.text = motives[2]
                fallthrough
            case 2:
                self.dontMotive2.text = motives[1]
                fallthrough
            case 1:
                self.dontMotive1.text = motives[0]
            default: ()
            }
        }
        if let elses = dontHabit.dontElse {
            switch elses.count {
            case 3:
                self.dontElse3.text = elses[2]
                fallthrough
            case 2:
                self.dontElse2.text = elses[1]
                fallthrough
            case 1:
                self.dontElse1.text = elses[0]
            default: ()
            }
        }
    }
    
    func fillTextFieldsWithParams() {
        let params = params!
        self.dontName.text = params["dontName"] as? String
        self.dontAdvantage.text = params["dontAdvantage"] as? String
        self.dontEnv.text = params["dontEnv"] as? String
        
        if let routines = params["dontRoutine"] as? [String] {
            switch routines.count {
            case 3:
                self.dontRoutine3.text = routines[2]
                fallthrough
            case 2:
                self.dontRoutine2.text = routines[1]
                fallthrough
            case 1:
                self.dontRoutine1.text = routines[0]
            default: ()
            }
        }
        if let motives = params["dontMotive"] as? [String] {
            switch motives.count {
            case 3:
                self.dontMotive3.text = motives[2]
                fallthrough
            case 2:
                self.dontMotive2.text = motives[1]
                fallthrough
            case 1:
                self.dontMotive1.text = motives[0]
            default: ()
            }
        }
        if let elses = params["dontElse"] as? [String] {
            switch elses.count {
            case 3:
                self.dontElse3.text = elses[2]
                fallthrough
            case 2:
                self.dontElse2.text = elses[1]
                fallthrough
            case 1:
                self.dontElse1.text = elses[0]
            default: ()
            }
        }
    }
    
    func collectTexts() -> [String: Any] {
        return ["dontName": dontName.text!,
                "dontAdvantage":dontAdvantage.text!,
                "dontEnv": dontEnv.text!,
                "dontRoutine": [dontRoutine1.text, dontRoutine2.text, dontRoutine3.text].compactMap{ $0 },
                "dontMotive": [dontMotive1.text, dontMotive2.text, dontMotive3.text].compactMap{ $0 },
                "dontElse": [dontElse1.text, dontElse2.text, dontElse3.text].compactMap{ $0 }] as [String : Any]
    }
}
