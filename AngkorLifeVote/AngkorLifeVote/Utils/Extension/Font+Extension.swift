//
//  Font+Extension.swift
//  AngkorLifeVote
//
//  Created by 김정원 on 1/24/25.
//

import SwiftUI

extension Font {
    /// 폰트 종류
    enum KPFONTStyle: String {
        case bold = "KantumruyPro-Bold"
        case semiBold = "KantumruyPro-SemiBold"
        case medium = "KantumruyPro-Medium"
        case light = "KantumruyPro-Light"
        case extraLight = "KantumruyPro-ExtraLight"
        case regular = "KantumruyPro-Regular"
    }

    /// Font.TextStyle을 UIFont.TextStyle로 매핑하는 헬퍼 메서드
    private static func mapTextStyle(_ textStyle: Font.TextStyle) -> UIFont.TextStyle {
        switch textStyle {
        case .largeTitle: return .largeTitle
        case .title: return .title1
        case .title2: return .title2
        case .title3: return .title3
        case .headline: return .headline
        case .subheadline: return .subheadline
        case .body: return .body
        case .callout: return .callout
        case .caption: return .caption1
        case .caption2: return .caption2
        case .footnote: return .footnote
        @unknown default: return .body
        }
    }

    /// 공통 폰트 생성 메서드
    private static func kpFont(
        _ style: KPFONTStyle,
        textStyle: TextStyle? = nil,
        size: CGFloat? = nil
    ) -> Font {
        if let size = size {
            return .custom(style.rawValue, size: size, relativeTo: textStyle ?? .body)
        } else if let textStyle = textStyle {
            let uiTextStyle = mapTextStyle(textStyle)
            let defaultSize = UIFont.preferredFont(forTextStyle: uiTextStyle).pointSize
            return .custom(style.rawValue, size: defaultSize, relativeTo: textStyle)
        } else {
            let defaultSize = UIFont.preferredFont(forTextStyle: .body).pointSize
            return .custom(style.rawValue, size: defaultSize)
        }
    }

    static func kpBold(
        _ textStyle: TextStyle? = nil,
        size: CGFloat? = nil
    ) -> Font {
        kpFont(.bold, textStyle: textStyle, size: size)
    }

    static func kpSemiBold(
        _ textStyle: TextStyle? = nil,
        size: CGFloat? = nil
    ) -> Font {
        kpFont(.semiBold, textStyle: textStyle, size: size)
    }

    static func kpMedium(
        _ textStyle: TextStyle? = nil,
        size: CGFloat? = nil
    ) -> Font {
        kpFont(.medium, textStyle: textStyle, size: size)
    }

    static func kpLight(
        _ textStyle: TextStyle? = nil,
        size: CGFloat? = nil
    ) -> Font {
        kpFont(.light, textStyle: textStyle, size: size)
    }

    static func kpExtraLight(
        _ textStyle: TextStyle? = nil,
        size: CGFloat? = nil
    ) -> Font {
        kpFont(.extraLight, textStyle: textStyle, size: size)
    }

    static func kpRegular(
        _ textStyle: TextStyle? = nil,
        size: CGFloat? = nil
    ) -> Font {
        kpFont(.regular, textStyle: textStyle, size: size)
    }
}
