//
//  UIApplication.swift
//  SwyptoTracker
//
//  Created by Sabbir Nasir on 17/1/25.
//

import Foundation
import SwiftUI

extension UIApplication {
    
    func endEditing() {
        sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
    
}
