//
//  Model.swift
//  CustomTabbar
//
//  Created by 김수영 on 4/11/24.
//

import Foundation

// MARK: - Welcome
struct Welcome: Codable {
    let result: Result
}

// MARK: - Result
struct Result: Codable {
    let count: Int
    let lane: [Lane]
}

// MARK: - Lane
struct Lane: Codable {
    let stationClass, stationID: Int
    let stationName: String
    let x, y: Double
    let busList: [BusList]
    let subwayLaneName, subwayLaneCity: String?
    let subwayLaneType: Int?
}

// MARK: - BusList
struct BusList: Codable {
    let busID, type: Int
    let busNo: String
}
