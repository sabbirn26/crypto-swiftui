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
    static let launch
    = LaunchTheme()
}

struct ColorTheme {
    let accent = Color("AccentColor")
    let bgColor = Color("BgColor")
    let grnColor = Color("GrnColor")
    let redColor = Color("RedColor")
    let scndTextColor = Color( "SecondaryTxtColor")
}

struct LaunchTheme {
    let accent = Color("LaunchAccentColor")
    let launchBgColor = Color("LaunchBgColor")
}
