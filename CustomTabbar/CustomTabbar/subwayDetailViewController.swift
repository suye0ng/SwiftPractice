//
//  subwayDetailViewController.swift
//  SSubbs
//
//  Created by 김수영 on 4/12/24.
//

import UIKit
import Alamofire
import Kingfisher

class subwayDetailViewController: UIViewController, UITableViewDelegate, UITableViewDataSource  {
    
    
    @IBOutlet weak var routeTableView: UITableView!
    @IBOutlet weak var TimeSelectButten: UIButton!
    @IBOutlet weak var starButton: UIButton!
    @IBOutlet weak var travelTimeLabel: UILabel!
    @IBOutlet weak var timeTitleLabel: UILabel!
    
    
    // 이 클로저는 사용자가 시간을 선택했을 때 호출됩니다.
    
    let routes = ["노선 1", "노선 2", "노선 3", "노선 4", "노선 5"]
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        routeTableView.dataSource = self
        routeTableView.delegate = self
        
        travelTimeLabel.text = "약 30분"
        
        // Do any additional setup after loading the view.
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // 섹션당 행의 수를 routes 배열의 길이로 설정
        return routes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // 셀을 생성하고 구성
        let cell = tableView.dequeueReusableCell(withIdentifier: "metroRoute", for: indexPath)
        cell.textLabel?.text = routes[indexPath.row]
        if let viewToRound = cell.viewWithTag(99) {
            // 뷰의 너비와 높이 중 더 작은 값을 찾아서 그 절반 값을 cornerRadius로 설정합니다.
            let size = min(viewToRound.frame.width, viewToRound.frame.height)
            viewToRound.layer.cornerRadius = size / 2
            
            // 뷰의 경계가 둥글게 처리되도록 합니다.
            viewToRound.clipsToBounds = true
        }
        return cell
    }
    
    @IBAction func actStarButton(_ sender: Any) {
        if let button = sender as? UIButton {
            button.isSelected = !button.isSelected // 버튼의 선택 상태를 반전시킵니다.
            
            // 선택 상태에 따라 버튼의 이미지 변경
            if button.isSelected {
                button.setImage(UIImage(named: "Star rate"), for: .normal)
                // 변경된 상태 저장 로직 (예: UserDefaults 사용)
            } else {
                button.setImage(UIImage(named: "Star border"), for: .normal)
                // 변경된 상태 저장 로직 (예: UserDefaults 사용)
            }
        }
    }
    @IBAction func actTimeSelectButton(_ sender: Any) {
        if let timePickerViewController = storyboard?.instantiateViewController(withIdentifier: "TimePickerViewController") {
            // 모달 뷰의 사이즈 조정 
            if #available(iOS 15.0, *) {
                timePickerViewController.modalPresentationStyle = .pageSheet
                if let sheetController = timePickerViewController.sheetPresentationController {
                    // 모달의 높이 설정
                    sheetController.detents = [.medium(), .large()]
                    // 모달 상단에 'grabber' 표시
                    sheetController.prefersGrabberVisible = true
                }
            } else {
                // iOS 15 미만에서는 이전 방식을 사용
                timePickerViewController.modalPresentationStyle = .pageSheet
                timePickerViewController.preferredContentSize = CGSize(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height / 2)
            }
            
            // TimePickerViewController에 onTimeSelected 클로저 설정이 필요한 경우 여기에 구현
            
            present(timePickerViewController, animated: true, completion: nil)
        }
    }
}
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

