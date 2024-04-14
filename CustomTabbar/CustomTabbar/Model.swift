//
//  Model.swift
//  CustomTabbar
//
//  Created by 김수영 on 4/11/24.
//

import Foundation

// MARK: - SubwayStationSearchResult
struct SubwayStationSearchResult: Codable {
    let result: SubwayStationResult
}

// MARK: - SubwayStationResult
struct SubwayStationResult: Codable {
    let totalCount: Int
    let stations: [SubwayStation]
    
    enum CodingKeys: String, CodingKey {
        case totalCount
        case stations = "station"
    }
}

// MARK: - SubwayStation
struct SubwayStation: Codable {
    let stationName: String
    let stationID: Int
    let x, y: Double
    let cid: Int
    let cityName, arsID, stationDo, gu: String
    let dong: String
    let type: Int
    let laneName, laneCity, ebid: String

    enum CodingKeys: String, CodingKey {
        case stationName, stationID, x, y
        case cid = "CID"
        case cityName, arsID
        case stationDo = "do"
        case gu, dong, type, laneName, laneCity, ebid
    }
}

// MARK: - 반경내 대중교통 POI 검색(Public Transit POI within Radius) - 지하철

// MARK: - NearbySubwayStationSearchResult
struct NearbySubwayStationSearchResult: Codable {
    let result: NearbySubwayStationResult?
}

// MARK: - Result
struct NearbySubwayStationResult: Codable {
    let count: Int
    let station: [NearbySubwayStation]
}

// MARK: - Station
struct NearbySubwayStation: Codable {
    let nonstopStation, stationClass: Int
    let stationName: String
    let stationID: Int
    let x, y: Double
    let arsID: String
    let type: Int
    let laneName, laneCity, ebid: String
}
