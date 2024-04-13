import UIKit
import Alamofire
import CoreLocation

// 원형 라벨 커스텀
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

// 모달 뷰 컨트롤러의 델리게이트 프로토콜
protocol ModalViewControllerDelegate: AnyObject {
    func modalDidDismiss()
}

class modalViewController: UIViewController {
    
    // 델리게이트 프로퍼티
    weak var delegate: ModalViewControllerDelegate?
    
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
        btnPrevSearchBar.tintColor = .blue
        
        // 테스트를 위한 임시 데이터
        let dynamicData = ["1", "서해선", "신분당선"]
        updateStackView(with: dynamicData)
        
        // 가장 근처에 있는 지하철 역 가져와서 보여주기
        fetchNearbySubwayStationAndUpdateUI()
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
            label.layer.borderColor = UIColor.gray.cgColor // 테두리 색상 설정
            label.layer.borderWidth = 2 // 테두리 두께 설정
            
            firstStackView.addArrangedSubview(label)
        }
    }
    
    func fetchNearbySubwayStationAndUpdateUI() {
        // 반경 내 근처 지하철 역을 가져오는 메서드 호출
        let locationManager = LocationManager.shared
        locationManager.startUpdatingCurrentLocation()
        print("호출 된다")
        

        // API 호출
        
        let url = "https://api.odsay.com/v1/api/pointSearch"

        let parameters: [String: Any] = [
            "apiKey": "발급받은 apiKey",
            "lang": 0,
            "x": 127.0276,
            "y": 37.49483,
            "radius": 250,
            "stationClass": 2
        ]

        AF.request(url, method: .get, parameters: parameters).responseJSON { response in
            switch response.result {
            case .success(let value):
                print("API 호출 성공: \(value)")
                // 응답 데이터 처리
            case .failure(let error):
                print("API 호출 실패: \(error)")
                // 에러 처리
            }
        }

    }


    
    func findNearestSubwayStationName(from location: CLLocation) {
        // ODSAY API를 통해 주변 지하철 역을 검색하고 가장 가까운 역을 찾기
        let responseManager = ResponseManager()
        responseManager.fetchNearbySubwayStations(currentLatitude: location.coordinate.latitude, currentLongitude: location.coordinate.longitude) { result in
            switch result {
            case .success(let searchResult):
                // 검색 결과를 처리하여 가장 가까운 역을 가져옴
                guard let nearestStation = searchResult.result.station.first else {
                    print("Failed to find nearest subway station.")
                    return
                }
                print("Nearest subway station found: \(nearestStation.stationName)")
                // 가장 가까운 역의 이름을 업데이트
                DispatchQueue.main.async {
                    self.firstNearLable.text = nearestStation.stationName
                }
            case .failure(let error):
                print("Failed to fetch nearby subway stations: \(error)")
            }
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
            
            self?.delegate?.modalDidDismiss()
        }
    }
}
