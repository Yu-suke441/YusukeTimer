//
//  SettingViewController.swift
//  YusukeTimer
//
//  Created by Yusuke Murayama on 2020/10/03.
//

import UIKit

class SettingViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate{
    
    // UIPickerViewに表示するデータをArrayで作成
    let settingArray : [Int] = [10,20,30,40,50,60]
    
    // 設定値を覚えるキーを設定
    let settingKey = "timer_value"
    

    @IBOutlet weak var timerSettingPicker: UIPickerView!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        // timerSettingPickerのデリゲートとデータソースの通知先を設定
        timerSettingPicker.delegate = self
        timerSettingPicker.dataSource = self
        
        // UserDefaultの取得
        let settings = UserDefaults.standard
        let timerValue = settings.integer(forKey: settingKey)
        
        // Pickerの選択を合わせる
        for row in 0..<settingArray.count {
            if settingArray[row] == timerValue {
                timerSettingPicker.selectRow(row, inComponent: 0, animated: true)
            }
        }
    }
    
    @IBAction func decisionButtonAction(_ sender: Any) {
        _ = navigationController?.popViewController(animated: true)
    }
    
    // UIPickerViewの列数を設定
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    // UIPikerViewの行数を取得
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return settingArray.count
    }
    
    // UIPickerViewの表示する内容を設定
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return String(settingArray[row])
    }
    
    // picker選択時に実行
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        // UserDefaultsの設定
        let settings = UserDefaults.standard
        settings.setValue(settingArray[row], forKey: settingKey)
        settings.synchronize()
    }
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
