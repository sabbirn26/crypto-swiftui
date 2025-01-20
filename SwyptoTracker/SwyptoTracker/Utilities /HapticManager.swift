//
//  HapticManager.swift
//  SwyptoTracker
//
//  Created by Sabbir Nasir on 20/1/25.
//

import Foundation
import SwiftUI

class HapticManager{
    static private let generator = UINotificationFeedbackGenerator()
    
    static func notification(type: UINotificationFeedbackGenerator.FeedbackType){
        generator.notificationOccurred(type)
    }
}
