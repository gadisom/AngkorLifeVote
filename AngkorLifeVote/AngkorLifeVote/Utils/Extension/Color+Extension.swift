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

    /// RGB: 111, 118, 255 (보라색 계열)
    static var AK6f76ff: Color {
        return .rgb(red: 111, green: 118, blue: 255)
    }

    /// RGB: 124, 124, 124 (중간 회색)
    static var AK7c7c7c: Color {
        return .rgb(red: 124, green: 124, blue: 124)
    }

    /// RGB: 66, 50, 213 (진한 보라색)
    static var AK4232d5: Color {
        return .rgb(red: 66, green: 50, blue: 213)
    }

    /// RGB: 7, 9, 9 (매우 진한 검정색)
    static var AK070909: Color {
        return .rgb(red: 7, green: 9, blue: 9)
    }

    /// RGB: 12, 12, 12 (거의 검정색)
    static var AK121212: Color {
        return .rgb(red: 12, green: 12, blue: 12)
    }

    /// RGB: 37, 37, 37 (짙은 회색)
    static var AK252525: Color {
        return .rgb(red: 37, green: 37, blue: 37)
    }

    /// RGB: 30, 30, 30 (짙은 회색)
    static var AK303030: Color {
        return .rgb(red: 30, green: 30, blue: 30)
    }

    /// RGB: 36, 33, 34 (검정색에 가까운 어두운 갈색)
    static var AK363334: Color {
        return .rgb(red: 36, green: 33, blue: 34)
    }

    /// RGB: 185, 185, 185 (밝은 회색)
    static var AKb9b9b9: Color {
        return .rgb(red: 185, green: 185, blue: 185)
    }

    /// RGB: 218, 218, 218 (아주 밝은 회색)
    static var AKdadada: Color {
        return .rgb(red: 218, green: 218, blue: 218)
    }
    
    /// RGB: 219, 219, 219  (밝은 회색)
    static var AKdbdbdb: Color {
        return .rgb(red: 219, green: 219, blue: 219)
    }
    
    /// RGB: 219, 219, 219 (밝은 회색, 투명도 0.8)
    static var AKdbdbdb08: Color {
        return .rgb(red: 219, green: 219, blue: 219, opacity: 0.8)
    }

    /// RGB: 246, 246, 246 (밝은 배경용 색)
    static var AKf6f6f6: Color {
        return .rgb(red: 246, green: 246, blue: 246)
    }

    /// RGB: 248, 248, 252 (배경색)
    static var AKbackground: Color {
        return .rgb(red: 248, green: 248, blue: 252)
    }

    /// RGB: 174, 174, 178 (밝은 회색)
    static var AKgray2: Color {
        return .rgb(red: 174, green: 174, blue: 178)
    }
}
