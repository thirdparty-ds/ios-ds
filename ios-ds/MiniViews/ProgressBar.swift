//
//  ProgressBar.swift
//  ios-ds
//
//  Created by Vasista Vovveti on 9/15/20.
//

import SwiftUI

struct ProgressBar: View {
    var value: Float
    var backgroundColor: Color = .red
    var foregroundColor: Color = .green
    
    var body: some View {
        GeometryReader { metrics in
            ZStack(alignment: .leading){
                Rectangle()
                    .foregroundColor(backgroundColor)
                    .frame(width: metrics.size.width, height: metrics.size.height)
                
                Rectangle()
                    .foregroundColor(foregroundColor)
                    .frame(width: metrics.size.width * CGFloat(value), height: metrics.size.height)
                    .animation(.easeOut(duration: 0.2))
            }.cornerRadius(45, antialiased: true)
        }
    }
}
