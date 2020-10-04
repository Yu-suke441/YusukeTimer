//
//  ViewController.swift
//  YusukeTimer
//
//  Created by Yusuke Murayama on 2020/10/03.
//

import UIKit

class ViewController: UIViewController {

    // タイマーの変数を作成
    var timer : Timer?
    
    // カウント（経過時間）の変数を作成
    var count = 0
    
    //　設定値を扱うキーを設定
    let settingKey = "timer_value"
    
    @IBOutlet weak var countDownLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        //　UserDefaultsのインスタンスを生成
        let settings = UserDefaults.standard
        // UserDefaultsに初期値を登録
        settings.register(defaults: [settingKey:10])
    }
    
    // 画面の更新をする(戻り値:remainCount:残り時間)
    func displayUpdate() -> Int {
        
        // UserDefaultsのインスタンスを生成
        let settings = UserDefaults.standard
        
        // 取得した秒数をtimerValueに渡す
        let timerValue = settings.integer(forKey: settingKey)
        
        // 残り時間(remainCount)を生成
        let remainCount = timerValue - count
        
        // remainCount(残り時間)をラベルに表示
        countDownLabel.text = "残り\(remainCount)秒"
        
        // 残り時間を戻り値に設定
        return remainCount
    }
    
    //　経過時間の処理
    @objc func timerInterrupt(_ timer:Timer?) {
        // count(経過時間)を+1していく
        count += 1;
        // remainCount(残り時間)が0以下の時、タイマーを止める
        if displayUpdate() <= 0 {
            // 初期化処理
            count = 0
            // タイマー停止
            timer?.invalidate()
            
            
            // カスタマイズ編: ダイアログを作成
            let alertController = UIAlertController(title: "終了", message: "タイマー終了時間です", preferredStyle:.actionSheet)
            // ダイアログに表示させるOKボタンを作成
            let defaultAction = UIAlertAction(title: "OK", style: .default, handler: nil)
            // アクションを追加
            alertController.addAction(defaultAction)
            // ダイアログを追加
            present(alertController, animated: true, completion: nil)
        }
        
        
    }

    @IBAction func settingButtonAction(_ sender: Any) {
        timerAction()
        
        //画面遷移を行う
        performSegue(withIdentifier: "goSetting", sender: nil)
    }
    
    @IBAction func startButtonAction(_ sender: Any) {
        timerAction()
        
        // タイマーをスタート
        timer = Timer.scheduledTimer(timeInterval: 1.0,
                                     target: self,
                                     selector: #selector(self.timerInterrupt(_:)),
                                     userInfo: nil,
                                     repeats: true)
    }
    @IBAction func stopButtonAction(_ sender: Any) {
       timerAction()
        
    }
    
    // 画面切り替えのタイミングを行う処理を行う
    override func viewDidAppear(_ animated: Bool) {
        //　カウント(経過時間)をゼロにする
        count = 0
        //　タイマーの表示を確認
        _ = displayUpdate()
    }
    
    func timerAction() {
        // timerをアンラップしてnowTimerに代入
        if let nowTimer = timer {
            // もしタイマーが実行中だったら停止
            if nowTimer.isValid == true {
                // タイマー停止
                nowTimer.invalidate()
            }
        }
    }
}

