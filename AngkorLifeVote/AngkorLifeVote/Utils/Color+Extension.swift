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
}
