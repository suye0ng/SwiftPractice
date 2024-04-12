//
//  TimePickerViewController.swift
//  SSubbs
//
//  Created by 김수영 on 4/12/24.
//

import UIKit

class TimePickerViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {

    
    @IBOutlet weak var timePicker: UIPickerView!
    
    var onTimeSelected: ((String) -> Void)?
    let times = ["09:00", "10:00", "11:00", "12:00", "13:00", "14:00", "15:00"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        timePicker.delegate = self
        timePicker.dataSource = self

        // Do any additional setup after loading the view.
    }
    

    // UIPickerViewDataSource
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 4
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return times.count
    }
    
    // UIPickerViewDelegate
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return times[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        // 사용자가 시간을 선택했을 때 onTimeSelected 클로저를 호출합니다.
        let selectedTime = times[row]
        onTimeSelected?(selectedTime)
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
