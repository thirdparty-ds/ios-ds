//
//  ControllerButton.swift
//  j
//
//  Created by Vasista Vovveti on 10/31/20.
//

import SwiftUI

struct ControllerButton: View {
    var text: String = ""
    var closure: (Bool) -> () = {_ in}
    
    @State private var pressed: Bool = false
    
    var body: some View {
        RoundedRectangle(cornerRadius: 15, style: .continuous)
            .foregroundColor(pressed ? .blue : .none)
            .overlay(
                Text(text)
                    .foregroundColor(/*@START_MENU_TOKEN@*/.blue/*@END_MENU_TOKEN@*/)
            )
            .onLongPressGesture(minimumDuration: .infinity, maximumDistance: .infinity, pressing: { pressing in
                let impact = UIImpactFeedbackGenerator(style: .light)
                impact.impactOccurred()
                pressed = pressing
                }, perform: { })
            .onChange(of: pressed) { p in
                closure(p)
            }
    }
}

struct ShoulderButton_Previews: PreviewProvider {
    static var previews: some View {
        ControllerButton()
    }
}
