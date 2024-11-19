//
//  Color.swift
//  SwyptoTracker
//
//  Created by Sabbir Nasir on 19/11/24.
//

import Foundation
import SwiftUI

extension Color{
    static let theme = ColorTheme()
}

struct ColorTheme {
    let accent = Color("AccentColor")
    let bgColor = Color("BgColor")
    let grnColor = Color("GrnColor")
    let redColor = Color("RedColor")
    let scndTextColor = Color( "SecondaryTxtColor")
}
