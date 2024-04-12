//
//  UIColor+Extention.swift
//  CustomTabbar
//
//  Created by 김수영 on 4/10/24.
//

import UIKit

extension UIColor {
    // UIColor 초기화 확장
    convenience init(hex: String, alpha: CGFloat = 1.0) {
        let hexFormatted = hex.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var int = UInt64()
        Scanner(string: hexFormatted).scanHexInt64(&int)
        let a, r, g, b: UInt64
        switch hexFormatted.count {
        case 3: // RGB (12-bit)
            (a, r, g, b) = (255, (int >> 8) * 17, (int >> 4 & 0xF) * 17, (int & 0xF) * 17)
        case 6: // RGB (24-bit)
            (a, r, g, b) = (255, int >> 16, int >> 8 & 0xFF, int & 0xFF)
        case 8: // ARGB (32-bit)
            (a, r, g, b) = (int >> 24, int >> 16 & 0xFF, int >> 8 & 0xFF, int & 0xFF)
        default:
            (a, r, g, b) = (255, 0, 0, 0)
        }
        self.init(
            red: CGFloat(r) / 255,
            green: CGFloat(g) / 255,
            blue: CGFloat(b) / 255,
            alpha: CGFloat(a) / 255
        )
    }

    // 새로운 색상 팔레트
    static let primary = UIColor(hex: "3A5ED5")
   
    static let backgroundWhite = UIColor(hex: "F2F2F2")

    // Grayscale 색상 팔레트 (예시)
    static let gray50 = UIColor(hex: "F2F2F2") // 가장 밝은 회색
    static let gray100 = UIColor(hex: "F5F5F5")
    static let gray200 = UIColor(hex: "EEEEEE")
    static let gray300 = UIColor(hex: "E0E0E0")
    static let gray400 = UIColor(hex: "BDBDBD")
    static let gray500 = UIColor(hex: "9E9E9E") // 중간 회색
    static let gray600 = UIColor(hex: "757575")
    static let gray700 = UIColor(hex: "616161")
    static let gray800 = UIColor(hex: "424242")
    static let gray900 = UIColor(hex: "212121") // 가장 어두운 회색
}

