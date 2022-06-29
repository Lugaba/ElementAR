//
//  TextView.swift
//  POC-ARswiftui
//
//  Created by Luca Hummel on 27/06/22.
//

import SwiftUI

struct textView: View {
    @Binding var text: String
    @Binding var background: Color
    
    var body: some View {
        Text(text)
            .font(.system(.body, design: .rounded))
            .foregroundColor(.white)
            .frame(width: 300, alignment: .center)
            .padding()
            .background(background)
            .cornerRadius(15)
    }
}
