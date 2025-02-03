//
//  XmarkButton.swift
//  SwyptoTracker
//
//  Created by Sabbir Nasir on 19/1/25.
//

import SwiftUI

struct XmarkButton: View {
    let dismiss: () -> Void
    var body: some View {
        Button(action: {
            print("<------- Protfolio bottom sheet dissmissed ------->")
            dismiss()
        }, label: {
            Image(systemName: "xmark")
                .font(.headline)
            
        })
    }
}

#Preview {
    XmarkButton(dismiss: {})
}
