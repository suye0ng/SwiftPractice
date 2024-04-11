//
//  modalViewController.swift
//  CustomTabbar
//
//  Created by 김수영 on 4/10/24.
//

import UIKit

// 라벨의 모양을 원형으로 만들기 위한 커스텀 라벨 클래스
class RoundLabel: UILabel {
    override func layoutSubviews() {
        super.layoutSubviews()
        self.layer.cornerRadius = self.frame.height / 2
        self.layer.masksToBounds = true
    }
    // 텍스트 패딩 설정
     var textPadding: UIEdgeInsets = UIEdgeInsets(top: 5, left: 10, bottom: 5, right: 10)
     
     override func drawText(in rect: CGRect) {
         let newRect = rect.inset(by: textPadding)
         super.drawText(in: newRect)
     }
     
     override var intrinsicContentSize: CGSize {
         let size = super.intrinsicContentSize
         let paddedWidth = size.width + textPadding.left + textPadding.right
         let paddedHeight = size.height + textPadding.top + textPadding.bottom
         return CGSize(width: paddedWidth, height: paddedHeight)
     }
     
 }

class modalViewController: UIViewController {
    
    @IBOutlet weak var lastNearLable: UILabel!
    @IBOutlet weak var lastStackView: UIStackView!
    @IBOutlet weak var lastBackgroundView: UIView!
    
    @IBOutlet weak var secondNearLable: UILabel!
    @IBOutlet weak var secondStackView: UIStackView!
    @IBOutlet weak var secondBackgroundView: UIView!
    
    @IBOutlet weak var firstNearLable: UILabel!
    @IBOutlet weak var firstStackView: UIStackView!
    @IBOutlet weak var firstBackgroundView: UIView!
    
    @IBOutlet weak var btnXMark: UIButton!
    @IBOutlet weak var mainNearLable: UILabel!
    @IBOutlet weak var btnPrevSearchBar: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        btnXMark.tintColor = .primary
        btnPrevSearchBar.tintColor = .gray900
        // 테스트를 위한 임시 데이터
            let dynamicData = ["1", "서해선", "신분당선"]
            updateStackView(with: dynamicData)
        }
        
    func updateStackView(with values: [String]) {
          // 기존에 스택뷰에 추가된 모든 뷰를 제거합니다.
          for arrangedSubview in firstStackView.arrangedSubviews {
              firstStackView.removeArrangedSubview(arrangedSubview)
              arrangedSubview.removeFromSuperview()
          }
          
          // 동적 데이터에 기반하여 라벨을 생성하고 스택뷰에 추가합니다.
          for value in values {
              let label = RoundLabel()
              label.text = value
              label.textColor = .black // 텍스트 색상 설정
              label.backgroundColor = .white // 라벨 배경색 설정
              label.heightAnchor.constraint(equalToConstant: 20).isActive = true
              
              // 라벨의 테두리 설정
              label.layer.borderColor = UIColor.gray500.cgColor // 테두리 색상 설정
              label.layer.borderWidth = 2 // 테두리 두께 설정
              
              firstStackView.addArrangedSubview(label)
          }
      }
        


    
    
    @IBAction func actXMark(_ sender: UIButton) {
        print("actXMark called")
        self.dismiss(animated: true, completion: nil)
        print("Dismiss completion")
        
    }
    @IBAction func actPrevSearchBar(_ sender: Any) {
        self.dismiss(animated: true)  { [weak self] in
            guard self != nil else { return }
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
}

