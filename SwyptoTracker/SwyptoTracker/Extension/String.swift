//
//  String.swift
//  SwyptoTracker
//
//  Created by Sabbir Nasir on 3/2/25.
//

import Foundation

extension String{
    var removingHTMLOcc : String{
        return self.replacingOccurrences(of: "<[^>]+>", with: "", options: .regularExpression, range: nil)
    }
}
