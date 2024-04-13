//
//  UIColor+Extention.swift
//  CustomTabbar
//
//  Created by 김수영 on 4/10/24.
//

import UIKit

extension UIColor {
    
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

    static let surfaceTint = UIColor(hex: "405F90")
    
    static let primary = UIColor(hex: "405F90")
    static let onPrimary = UIColor(hex: "FFFFFF")
    static let primaryContainer = UIColor(hex: "D6E3FF")
    static let onPrimaryContainer = UIColor(hex: "001B3D")
    
    static let secondary = UIColor(hex: "3D5F90")
    static let onSecondary = UIColor(hex: "FFFFFF")
    static let secondaryContainer = UIColor(hex: "D5E3FF")
    static let onSecondaryContainer = UIColor(hex: "001C3B")
    
    static let tertiary = UIColor(hex: "8F4B39")
    static let onTertiary = UIColor(hex: "FFFFFF")
    static let tertiaryContainer = UIColor(hex: "FFDBD1")
    static let onTertiaryContainer = UIColor(hex: "3A0A01")
    
    static let error = UIColor(hex: "BA1A1A")
    static let onError = UIColor(hex: "FFFFFF")
    static let errorContainer = UIColor(hex: "FFDAD6")
    static let onErrorContainer = UIColor(hex: "410002")
    
    static let background = UIColor(hex: "F9F9FF")
    static let onBackground = UIColor(hex: "191C20")
    
    static let surface = UIColor(hex: "F9F9FF")
    static let onSurface = UIColor(hex: "191C20")
    static let surfaceVariant = UIColor(hex: "E0E2EC")
    static let onSurfaceVariant = UIColor(hex: "44474E")
    
    static let outline = UIColor(hex: "74777F")
    static let outlineVariant = UIColor(hex: "C4C6CF")
    
    static let shadow = UIColor(hex: "000000")
    static let scrim = UIColor(hex: "000000")
    
    static let inverseSurface = UIColor(hex: "2E3036")
    static let inverseonSurface = UIColor(hex: "F0F0F7")
    static let inversePrimary = UIColor(hex: "A9C7FF")
    
    static let primaryFixed = UIColor(hex: "D6E3FF")
    static let onPrimaryFixed = UIColor(hex: "001B3D")
    static let primaryFixedDim = UIColor(hex: "A9C7FF")
    static let onPrimaryFixedVariant = UIColor(hex: "274777")
    
    static let secondaryFixed = UIColor(hex: "D5E3FF")
    static let onSecondaryFixed = UIColor(hex: "001C3B")
    static let secondaryFixedDim = UIColor(hex: "A7C8FF")
    static let onSecondaryFixedVariant = UIColor(hex: "234777")
    
    static let tertiaryFixed = UIColor(hex: "FFDBD1")
    static let onTertiaryFixed = UIColor(hex: "3A0A01")
    static let tertiaryFixedDim = UIColor(hex: "FFB4A1")
    static let onTertiaryFixedVariant = UIColor(hex: "723524")
    
    static let surfaceDim = UIColor(hex: "D9D9E0")
    static let surfaceBright = UIColor(hex: "F9F9FF")
    static let surfaceContainerLowest = UIColor(hex: "FFFFFF")
    static let surfaceContainerLow = UIColor(hex: "F3F3FA")
    static let surfaceContainer = UIColor(hex: "EDEDF4")
    static let surfaceContainerHigh = UIColor(hex: "E7E8EE")
    static let surfaceContainerHighest = UIColor(hex: "E2E2E9")
}
