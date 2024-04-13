//
//  subwayViewController.swift
//  CustomTabbar
//
//  Created by 김수영 on 4/10/24.
//

import UIKit
import Alamofire
import Kingfisher


    
    class subwayViewController: UIViewController {
        
        @IBOutlet weak var searchBar: UISearchBar!
        override func viewDidLoad() {
            super.viewDidLoad()
            
            
            view.backgroundColor = .white
            
            // Do any additional setup after loading the view.
        }
        
        func searchBarVisible() {
            // 검색창을 보이게 함
            searchBar.isHidden = false
            // 검색창에 포커스를 설정하여 키보드를 표시함
            searchBar.becomeFirstResponder()
        }
        
        func modalDidDismiss() {
            // 검색창을 보이게 하고 포커스를 설정하는 메서드 호출
            searchBarVisible()
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
    

