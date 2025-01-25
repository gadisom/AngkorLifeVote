//
//  Color+Extension.swift
//  AngkorLifeVote
//
//  Created by 김정원 on 1/24/25.
//

import SwiftUI

extension Color {
    static func rgb(red: Int, green: Int, blue: Int, opacity: Double = 1.0) -> Color {
        return Color(
            .sRGB,
            red: Double(red) / 255.0,
            green: Double(green) / 255.0,
            blue: Double(blue) / 255.0,
            opacity: opacity
        )
    }
    
    static let gray185 = rgb(red: 185, green: 185, blue: 185)
    static let gray215 = rgb(red: 215, green: 215, blue: 215)
    static let gray219 = rgb(red: 219, green: 219, blue: 219)

}
