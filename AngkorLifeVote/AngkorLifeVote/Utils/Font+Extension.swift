//
//  Font+Extension.swift
//  AngkorLifeVote
//
//  Created by 김정원 on 1/24/25.
//

import SwiftUI

extension Font {
    private static let kpFontBoldName = "KantumruyPro-Bold"
    private static let kpFontMediumName = "KantumruyPro-Medium"
    private static let kpFontLightName = "KantumruyPro-Light"
    private static let kpFontExtraLightName = "KantumruyPro-ExtraLight"
    private static let kpFontRegularName = "KantumruyPro-Regular"
    
    static func kpBold(
        _ style: TextStyle? = nil,
        size: CGFloat? = nil
    ) -> Font {
        if let size = size {
            return .custom(kpFontBoldName, size: size, relativeTo: style ?? .body)
        } else if let style = style {
            return .custom(kpFontBoldName, size: UIFont.preferredFont(forTextStyle: UIFont.TextStyle(style)).pointSize, relativeTo: style)
        } else {
            return .custom(kpFontBoldName, size: UIFont.preferredFont(forTextStyle: .body).pointSize)
        }
    }
    
    static func kpMedium(
        _ style: TextStyle? = nil,
        size: CGFloat? = nil
    ) -> Font {
        if let size = size {
            return .custom(kpFontMediumName, size: size, relativeTo: style ?? .body)
        } else if let style = style {
            return .custom(kpFontMediumName, size: UIFont.preferredFont(forTextStyle: UIFont.TextStyle(style)).pointSize, relativeTo: style)
        } else {
            return .custom(kpFontMediumName, size: UIFont.preferredFont(forTextStyle: .body).pointSize)
        }
    }
    
    static func kpLight(
        _ style: TextStyle? = nil,
        size: CGFloat? = nil
    ) -> Font {
        if let size = size {
            return .custom(kpFontLightName, size: size, relativeTo: style ?? .body)
        } else if let style = style {
            return .custom(kpFontLightName, size: UIFont.preferredFont(forTextStyle: UIFont.TextStyle(style)).pointSize, relativeTo: style)
        } else {
            return .custom(kpFontLightName, size: UIFont.preferredFont(forTextStyle: .body).pointSize)
        }
    }
    
    static func kpExtraLight(
        _ style: TextStyle? = nil,
        size: CGFloat? = nil
    ) -> Font {
        if let size = size {
            return .custom(kpFontExtraLightName, size: size, relativeTo: style ?? .body)
        } else if let style = style {
            return .custom(kpFontExtraLightName, size: UIFont.preferredFont(forTextStyle: UIFont.TextStyle(style)).pointSize, relativeTo: style)
        } else {
            return .custom(kpFontExtraLightName, size: UIFont.preferredFont(forTextStyle: .body).pointSize)
        }
    }
    
    static func kpRegular(
        _ style: TextStyle? = nil,
        size: CGFloat? = nil
    ) -> Font {
        if let size = size {
            return .custom(kpFontRegularName, size: size, relativeTo: style ?? .body)
        } else if let style = style {
            return .custom(kpFontRegularName, size: UIFont.preferredFont(forTextStyle: UIFont.TextStyle(style)).pointSize, relativeTo: style)
        } else {
            return .custom(kpFontRegularName, size: UIFont.preferredFont(forTextStyle: .body).pointSize)
        }
    }
    
    
}

private extension UIFont.TextStyle {
    init(_ textStyle: Font.TextStyle) {
        switch textStyle {
        case .largeTitle: self = .largeTitle
        case .title: self = .title1
        case .title2: self = .title2
        case .title3: self = .title3
        case .headline: self = .headline
        case .subheadline: self = .subheadline
        case .body: self = .body
        case .callout: self = .callout
        case .caption: self = .caption1
        case .caption2: self = .caption2
        case .footnote: self = .footnote
        @unknown default: self = .body
        }
    }
}
