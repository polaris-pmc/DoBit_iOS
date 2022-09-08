//
//  DoDetailViewController.swift
//  DoBit
//
//  Created by 서민주 on 2021/07/29.
//

import UIKit

class DoDetailViewController: UIViewController {
    @IBOutlet var viewModel: GoalViewModel!
    
    @IBOutlet weak var doName: UITextField!
    @IBOutlet weak var doWhen: UITextField!
    @IBOutlet weak var doWhere: UITextField!
    @IBOutlet weak var doStart: UITextField!
    @IBOutlet weak var doRoutine1: UITextField!
    @IBOutlet weak var doRoutine2: UITextField!
    @IBOutlet weak var doRoutine3: UITextField!
    @IBOutlet weak var doEnv1: UITextField!
    @IBOutlet weak var doEnv2: UITextField!
    @IBOutlet weak var doEnv3: UITextField!
    @IBOutlet weak var doNext1: UITextField!
    @IBOutlet weak var doNext2: UITextField!
    @IBOutlet weak var doNext3: UITextField!
    @IBOutlet weak var doElse1: UITextField!
    @IBOutlet weak var doElse2: UITextField!
    @IBOutlet weak var doElse3: UITextField!
    
    var doHabitIdx: Int?
    var params: [String: Any]?
    var allTextFields: [UITextField] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        allTextFields = [doName, doWhen, doWhere, doStart,
                         doRoutine1, doRoutine2, doRoutine3,
                         doEnv1, doEnv2, doEnv3,
                         doNext1, doNext2, doNext3,
                         doElse1, doElse2, doElse3]
        
        UITextField.connectAllTextFields(textFields: allTextFields)
        
        guard let habitIdx = doHabitIdx else {
            if params != nil { self.fillTextFieldsWithParams() }
            return
        }
        viewModel.detailHabit(habitIdx: habitIdx, isDo: true) { isSuccess in
            if isSuccess {
                self.fillTextFields()
            }
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    @IBAction func completeTapped(_ sender: Any) {
        
        guard doName.text != "" && doWhen.text != "" && doWhere.text != "" && doStart.text != "" else {
            let alertView = AlertService.showAlert("필수 입력", "작은 습관, 언제, 어디서, 시작하기는 필수 입력 항목입니다.")
            showAlert(alertView)
            return
        }
        let params = collectTexts()
        if doHabitIdx != nil {
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "updateHabit"),
                                            object: nil,
                                            userInfo: ["isDo": true,
                                                       "text": doName.text!,
                                                       "params": params])
        } else {
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "addHabit"),
                                            object: nil,
                                            userInfo: ["isDo": true,
                                                       "text": doName.text!,
                                                       "params": params])
        }
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func deleteTapped(_ sender: Any) {
//        if let habitIdx = doHabitIdx {
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "deleteHabit"),
                                            object: nil,
                                            userInfo: ["isDo": true,
                                                       "habitIdx": doHabitIdx as Any])
//        }
        navigationController?.popViewController(animated: true)
    }
    
    func fillTextFields() {
        let doHabit = self.viewModel.doHabit!
        self.doName.text = doHabit.doName
        self.doWhen.text = doHabit.doWhen
        self.doWhere.text = doHabit.doWhere
        self.doStart.text = doHabit.doStart
        
        if let routines = doHabit.doRoutine {
            switch routines.count {
            case 3:
                self.doRoutine3.text = routines[2]
                fallthrough
            case 2:
                self.doRoutine2.text = routines[1]
                fallthrough
            case 1:
                self.doRoutine1.text = routines[0]
            default: ()
            }
        }
        if let env = doHabit.doEnv {
            switch env.count {
            case 3:
                self.doEnv3.text = env[2]
                fallthrough
            case 2:
                self.doEnv2.text = env[1]
                fallthrough
            case 1:
                self.doEnv1.text = env[0]
            default: ()
            }
        }
        if let nexts = doHabit.doNext {
            switch nexts.count {
            case 3:
                self.doNext3.text = nexts[2]
                fallthrough
            case 2:
                self.doNext2.text = nexts[1]
                fallthrough
            case 1:
                self.doNext1.text = nexts[0]
            default: ()
            }
        }
        if let elses = doHabit.doElse {
            switch elses.count {
            case 3:
                self.doElse3.text = elses[2]
                fallthrough
            case 2:
                self.doElse2.text = elses[1]
                fallthrough
            case 1:
                self.doElse1.text = elses[0]
            default: ()
            }
        }
    }
    
    func fillTextFieldsWithParams() {
        let params = params!
        self.doName.text = params["doName"] as? String
        self.doWhen.text = params["doWhen"] as? String
        self.doWhere.text = params["doWhere"] as? String
        self.doStart.text = params["doStart"] as? String
        
        if let routines = params["doRoutine"] as? [String] {
            switch routines.count {
            case 3:
                self.doRoutine3.text = routines[2]
                fallthrough
            case 2:
                self.doRoutine2.text = routines[1]
                fallthrough
            case 1:
                self.doRoutine1.text = routines[0]
            default: ()
            }
        }
        if let env = params["doEnv"] as? [String] {
            switch env.count {
            case 3:
                self.doEnv3.text = env[2]
                fallthrough
            case 2:
                self.doEnv2.text = env[1]
                fallthrough
            case 1:
                self.doEnv1.text = env[0]
            default: ()
            }
        }
        if let nexts = params["doNext"] as? [String] {
            switch nexts.count {
            case 3:
                self.doNext3.text = nexts[2]
                fallthrough
            case 2:
                self.doNext2.text = nexts[1]
                fallthrough
            case 1:
                self.doNext1.text = nexts[0]
            default: ()
            }
        }
        if let elses = params["doElse"] as? [String] {
            switch elses.count {
            case 3:
                self.doElse3.text = elses[2]
                fallthrough
            case 2:
                self.doElse2.text = elses[1]
                fallthrough
            case 1:
                self.doElse1.text = elses[0]
            default: ()
            }
        }
    }
    
    func collectTexts() -> [String: Any] {
        return ["doName": doName.text!,
                "doWhen": doWhen.text!,
                "doWhere": doWhere.text!,
                "doStart": doStart.text!,
                "doRoutine": [doRoutine1.text, doRoutine2.text, doRoutine3.text].compactMap{ $0 },
                "doEnv": [doEnv1.text, doEnv2.text, doEnv3.text].compactMap{ $0 },
                "doNext": [doNext1.text, doNext2.text, doNext3.text].compactMap{ $0 },
                "doElse": [doElse1.text, doElse2.text, doElse3.text].compactMap{ $0 }] as [String : Any]
    }
}
