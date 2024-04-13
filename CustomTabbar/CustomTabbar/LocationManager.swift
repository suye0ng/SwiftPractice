//
//  LocationManager.swift
//  CustomTabbar
//
//  Created by 김수영 on 4/13/24.
//


import CoreLocation
import Alamofire

// LocationManager 클래스 구현부
class LocationManager: NSObject, CLLocationManagerDelegate {
    // [싱글톤] 공유 인스턴스, 앱 전체에서 하나의 LocationManager를 사용하기 위함
    static let shared = LocationManager()
    
    private var locationManager: CLLocationManager?
    
    private override init() {
        super.init()
        self.locationManager = CLLocationManager()
        self.locationManager?.delegate = self
        self.locationManager?.desiredAccuracy = kCLLocationAccuracyBest // 정확도를 최고로 설정
        self.locationManager?.requestWhenInUseAuthorization() // 앱 사용 중 위치 정보 사용 요청
    }
    
    // 사용자의 현재 위치 업데이트 시작
    func startUpdatingCurrentLocation() {
        locationManager?.startUpdatingLocation()
    }
    
    // 위치가 업데이트될 때 호출됨
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let currentLocation = locations.last else { return }
    }
}

class NetworkService {
    
    // 데이터를 GET 방식으로 요청하는 메서드
    func fetchData(url: URLConvertible, completion: @escaping (Result<Data, Error>) -> Void) {
        AF.request(url, method: .get).validate().responseData { response in
            switch response.result {
            case .success(let data):
                completion(.success(data))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}

class ResponseManager {
    private let networkService = NetworkService()
    
    /// 주어진 키워드를 기반으로 지하철 역을 검색합니다.
    /// - Parameters:
    ///   - keyword: 검색하고자 하는 지하철 역의 이름.
    ///   - completion: 검색 결과를 처리하는 클로저. 성공 시 `SubwayStationSearchResult` 타입의 결과를 반환하고, 실패 시 `Error`를 반환합니다.
    /// - Note: 검색 결과는 최대 20개의 지하철 역 정보를 반환합니다.
    func fetchSubwayStations(keyword: String, completion: @escaping (Result<SubwayStationSearchResult, Error>) -> Void) {
        let baseUrl = "https://api.odsay.com/v1/api/searchStation?lang=0&stationName=\(keyword)&stationClass=2&displayCnt=20"
        
        networkService.fetchData(url: baseUrl) { result in
            switch result {
            case .success(let data):
                do {
                    let searchResult = try JSONDecoder().decode(SubwayStationSearchResult.self, from: data)
                    completion(.success(searchResult))
                } catch {
                    completion(.failure(error))
                }
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    
    /// 주어진 위도와 경도를 기반으로 반경 내의 버스 정류장 정보를 검색합니다.
    /// - Parameters:
    ///   - currentLatitude: 현재 사용자의 위도.
    ///   - currentLongitude: 현재 사용자의 경도.
    ///   - completion: 검색 결과를 처리하는 클로저. 성공 시 `NearbyBusStationSearchResult` 타입의 결과를 반환하고, 실패 시 `Error`를 반환합니다.
    ///   - currentLatitude: 현재 사용자의 위도.
     ///   - currentLongitude: 현재 사용자의 경도.
     ///   - completion: 검색 결과를 처리하는 클로저. 성공 시 `NearbySubwayStationSearchResult` 타입의 결과를 반환하고, 실패 시 `Error`를 반환합니다.
     func fetchNearbySubwayStations(currentLatitude: Double, currentLongitude: Double, completion: @escaping (Result<NearbySubwayStationSearchResult, Error>) -> Void) {
         let baseUrl = "https://api.odsay.com/v1/api/pointSearch?x=\(currentLatitude)&y=\(currentLongitude)&stationClass=2"
         
         networkService.fetchData(url: baseUrl) { result in
             switch result {
             case .success(let data):
                 do {
                     let searchResult = try JSONDecoder().decode(NearbySubwayStationSearchResult.self, from: data)
                     completion(.success(searchResult))
                 } catch {
                     completion(.failure(error))
                 }
             case .failure(let error):
                 completion(.failure(error))
             }
         }
     }
 }

