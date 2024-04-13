//
//  mainTabBarController.swift
//  CustomTabbar
//
//  Created by 김수영 on 4/10/24.
//

import UIKit
import Alamofire
import Kingfisher

class mainTabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        DispatchQueue.main.async { [weak self] in
            if self?.isFirstEntry() == true {
                self?.presentmodal()
            }
        }
    }
    
    func isFirstEntry() -> Bool {
        // ViewController의 진입 여부를 확인
        let key = "ViewControllerFirstEntry"
        let firstEntry = UserDefaults.standard.bool(forKey: key)
        
        if !firstEntry {
            // 첫 진입이면, true
            UserDefaults.standard.set(true, forKey: key)
            return true
        }
        
        // 이미 진입한 적이 있으면 false 반환
        return false
    }
    
    func presentmodal() {
        // "modal"의 ID를 가진 뷰 컨트롤러를 스토리보드에서 가져옵니다.
        if let modalViewController = storyboard?.instantiateViewController(withIdentifier: "modal") {
        
            modalViewController.modalPresentationStyle = .formSheet
            
            // 현재 선택된 탭의 루트 뷰 컨트롤러에서 모달 뷰 컨트롤러를 표시합니다.
            // 이는 UITabBarController에서 모달을 올바르게 표시하기 위해 필요합니다.
            if let selectedViewController = self.selectedViewController {
                selectedViewController.present(modalViewController, animated: true, completion: nil)
            } else {
                // 현재 선택된 탭이 없는 경우, 기본적으로 UITabBarController에서 모달을 표시합니다.
                self.present(modalViewController, animated: true, completion: nil)
            }
        }
    }
}

