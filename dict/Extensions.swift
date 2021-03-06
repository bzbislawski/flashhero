//
//  Extensions.swift
//  dict
//
//  Created by Bartosz Zbislawski on 21/01/2020.
//  Copyright © 2020 Bartosz Zbislawski. All rights reserved.
//

import SwiftUI

extension Color {
    static func rgb(r: Double, g: Double, b: Double) -> Color {
        return Color(red: r / 255, green: g / 255, blue: b / 255)
    }
    
    // Accent color
    static let iconActive = Color.rgb(r: 79, g: 198, b: 233)
    static let iconInactive = Color.rgb(r: 134, g: 131, b: 154)
    static let borderColor = Color.rgb(r: 214, g: 211, b: 221)
    static let fontColor = Color.rgb(r: 52, g: 92, b: 157)
    static let lightBlue = Color.rgb(r: 62, g: 208, b: 242)
    static let darkBlue = Color.rgb(r: 28, g: 65, b: 116)
    
    // Gray colors
    static let backgroundColor = Color.rgb(r: 244, g: 244, b: 244)
    static let secondaryBackgroundColor = Color.rgb(r: 209, g: 214, b: 217)
    static let tertiaryBackgroundColor = Color.rgb(r: 142, g: 141, b: 146)
    static let quaternaryBackgroundColor = Color.rgb(r: 79, g: 78, b: 78)
    static let quinaryBackgroundColor = Color.rgb(r: 146, g: 146, b: 150)
}

extension UIColor {
    static let backgroundColor = UIColor(red:241/255, green:242/255, blue:244/255, alpha: 1.0)
}
