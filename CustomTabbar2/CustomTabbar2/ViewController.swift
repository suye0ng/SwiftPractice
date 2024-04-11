//
//  ViewController.swift
//  CustomTabbar2
//
//  Created by 김수영 on 4/10/24.
//

import UIKit

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        DispatchQueue.main.async { [weak self] in
               if self?.isFirstEntry() == true {
                   self?.presentSecondViewController()
               }
           }
       }
       
       func isFirstEntry() -> Bool {
           // UserDefaults에서 해당 ViewController의 진입 여부를 확인합니다.
           let key = "ViewControllerFirstEntry"
           let firstEntry = UserDefaults.standard.bool(forKey: key)
           
           if !firstEntry {
               // 첫 진입이면, 'true'로 설정하여 저장합니다.
               UserDefaults.standard.set(true, forKey: key)
               UserDefaults.standard.synchronize()
               return true // 첫 진입이므로 true 반환
           }
           
           // 이미 진입한 적이 있으면 false 반환
           return false
       }
       
       func presentSecondViewController() {
           // "SecondViewController"의 ID를 가진 뷰 컨트롤러를 스토리보드에서 가져옵니다.
          if let secondViewController = storyboard?.instantiateViewController(withIdentifier: "SecondViewController") {
               // 모달 프레젠테이션 스타일 설정 (선택 사항)
              secondViewController.modalPresentationStyle = .automatic// 또는 다른 스타일
               // 모달 뷰 컨트롤러를 표시합니다.
               present(secondViewController, animated: true, completion: nil)
           }
       }
    @IBAction func actXMark(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func actBtnSearch(_ sender: UIButton) {
        self.dismiss(animated: true)  { [weak self] in
            guard self != nil else { return }
        
        }
    }
}
