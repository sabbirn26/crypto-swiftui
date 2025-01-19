//
//  XmarkButton.swift
//  SwyptoTracker
//
//  Created by Sabbir Nasir on 19/1/25.
//

import SwiftUI

struct XmarkButton: View {
    @Environment(\.presentationMode) var presentationMode
    var body: some View {
        Button(action: {
            print("<------- Protfolio bottom sheet dissmissed ------->")
            presentationMode.wrappedValue.dismiss()
        }, label: {
            Image(systemName: "xmark")
                .font(.headline)
            
        })
    }
}

#Preview {
    XmarkButton()
}
