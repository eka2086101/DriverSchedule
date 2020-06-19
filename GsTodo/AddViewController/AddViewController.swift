//
//  AddViewController.swift
//  GsTodo
//
//  Created by NaokiKameyama on 2020/05/6.
//  Copyright © 2020 NaokiKameyama. All rights reserved.
//

import UIKit
import MapKit
#warning("ここに PKHUD を import しよう！")
import PKHUD

class AddViewController: UIViewController,UITextFieldDelegate{
    
    @IBOutlet weak var titleTextField: UITextField!
    
    @IBOutlet weak var memoTextView: UITextView!

    @IBOutlet weak var inputText: UITextField!
  
    @IBOutlet weak var dispMap: MKMapView!
        
    
    @IBOutlet weak var picker: UIDatePicker!
    
    
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        
        if let searchKey = textField.text{
            print(searchKey)
            
            let geocoeder = CLGeocoder()
            
            geocoeder.geocodeAddressString(searchKey, completionHandler: { (placemarks,error) in
                
                if let unwrapPlacemarks = placemarks{
                    
                    if let firstPlacemark = unwrapPlacemarks.first{
                        
                        if let location = firstPlacemark.location{
                            
                            let targetCoordinate = location.coordinate
                            
                            print(targetCoordinate)
                            
                            let pin = MKPointAnnotation()
                            
                            pin.coordinate = targetCoordinate
                            
                            pin.title = searchKey
                            
                            self.dispMap.addAnnotation(pin)
                            
                            self.dispMap.region = MKCoordinateRegion(center:targetCoordinate,latitudinalMeters: 500.0,longitudinalMeters: 500.0)
                        }
                        
                    }
                }
                
            })

    }
        return true
    }
    // TaskListViewControllerからコピーしたtasks
    var tasks: [Task] = []

  
    override func viewDidLoad() {
        super.viewDidLoad()
        setupMemoTextView()
        setupNavigationBar()
        
        inputText.delegate = self
        
        


       }
    

    // MARK: - UISetup
    private func setupMemoTextView() {
        memoTextView.layer.borderWidth = 1
        memoTextView.layer.borderColor = UIColor.lightGray.cgColor
        memoTextView.layer.cornerRadius = 3
    }
    
    private func setupNavigationBar() {
        title = "新規追加"
        let rightButtonItem = UIBarButtonItem(title: "保存", style: .plain, target: self, action: #selector(tapSaveButton))
        navigationItem.rightBarButtonItem = rightButtonItem
    }
    
    
    // MARK: - Other Method
    @objc func tapSaveButton() {
        print("Saveボタンを押したよ！")
        
        let datetime = picker.date
        
        
        
        guard let title = titleTextField.text else {
            return
        }
        
        guard let search = inputText.text else {
            return
        }

        #warning("titleが空白のときのエラー処理")
        // titleが空白のときのエラー処理
        if title.isEmpty {
            print(title, "👿titleが空っぽだぞ〜")
            HUD.flash(.labeledError(title: nil, subtitle: "👿 タイトルが入力されていません！！！"), delay: 1)
            // showAlert("👿 タイトルが入力されていません！！！")
            return // return を実行すると、このメソッドの処理がここで終了する。
        }

        #warning("tasksにtaskを追加する処理")
        // tasksにAddする処理
        let task = Task(title: title, memo: memoTextView.text,date:datetime ,search:search)
        tasks.append(task)
        UserDefaultsRepository.saveToUserDefaults(tasks)

        HUD.flash(.success, delay: 0.3)
        // 前の画面に戻る
        navigationController?.popViewController(animated: true)
    }

    #warning("アラートを表示するメソッド")
    // アラートを表示するメソッド
    func showAlert(_ text: String){
        let alertController = UIAlertController(title: "エラー", message: text , preferredStyle: UIAlertController.Style.alert)
        let action = UIAlertAction(title: "OK", style: UIAlertAction.Style.default)
        alertController.addAction(action)
        present(alertController, animated: true, completion: nil)
    }
    
}
