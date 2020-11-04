//
//  ABXY.swift
//  j
//
//  Created by Vasista Vovveti on 10/21/20.
//

import SwiftUI

struct ABXY: View {
    @State private var APressed: Bool = false
    @State private var BPressed: Bool = false
    @State private var XPressed: Bool = false
    @State private var YPressed: Bool = false
    @State private var size: CGFloat = 1e99
    
    let closure: (Bool, Bool, Bool, Bool) -> ()
    
    init(closure: @escaping (Bool, Bool, Bool, Bool) -> () = {_, _, _, _ in}) {
        self.closure = closure
    }
    
    var body: some View {
        let buttonSize = size / 3
        
        ZStack {
            // up
            Circle()
                .foregroundColor(YPressed ? .blue : .white)
                .frame(maxWidth: buttonSize, maxHeight: buttonSize)
                .overlay(
                    Text("Y")
                        .bold()
                        .scaledToFill()
                        .foregroundColor(.blue)
                )
                .offset(x: 0, y: -size / 2 + buttonSize / 2)
                .onLongPressGesture(minimumDuration: .infinity, maximumDistance: buttonSize / 2, pressing: { pressing in
                    let impact = UIImpactFeedbackGenerator(style: .light)
                    impact.impactOccurred()
                    YPressed = pressing
                    }, perform: { })
            
            // down
            Circle()
                .foregroundColor(APressed ? .blue : .white)
                .frame(maxWidth: buttonSize, maxHeight: buttonSize)
                .overlay(
                    Text("A")
                        .bold()
                        .scaledToFill()
                        .foregroundColor(/*@START_MENU_TOKEN@*/.blue/*@END_MENU_TOKEN@*/)
                )
                .offset(x: 0, y: size / 2 - buttonSize / 2)
                .onLongPressGesture(minimumDuration: .infinity, maximumDistance: buttonSize / 2, pressing: { pressing in
                    let impact = UIImpactFeedbackGenerator(style: .light)
                    impact.impactOccurred()
                    APressed = pressing
                    }, perform: { })
            
            // left
            Circle()
                .foregroundColor(XPressed ? .blue : .white)
                .frame(maxWidth: buttonSize, maxHeight: buttonSize)
                .overlay(
                    Text("X")
                        .bold()
                        .scaledToFill()
                        .foregroundColor(/*@START_MENU_TOKEN@*/.blue/*@END_MENU_TOKEN@*/)
                )
                .offset(x: -size / 2 + buttonSize / 2, y: 0)
                .onLongPressGesture(minimumDuration: .infinity, maximumDistance: buttonSize / 2, pressing: { pressing in
                    let impact = UIImpactFeedbackGenerator(style: .light)
                    impact.impactOccurred()
                    XPressed = pressing
                    }, perform: { })
            
            // right
            Circle()
                .foregroundColor(BPressed ? .blue : .white)
                .frame(maxWidth: buttonSize, maxHeight: buttonSize)
                .overlay(
                    Text("B")
                        .bold()
                        .scaledToFill()
                        .foregroundColor(/*@START_MENU_TOKEN@*/.blue/*@END_MENU_TOKEN@*/)
                )
                .offset(x: size / 2 - buttonSize / 2, y: 0)
                .onLongPressGesture(minimumDuration: .infinity, maximumDistance: buttonSize / 2, pressing: { pressing in
                    let impact = UIImpactFeedbackGenerator(style: .light)
                    impact.impactOccurred()
                    BPressed = pressing
                    }, perform: { })
        }
        .onChange(of: APressed){a in closure(a, BPressed, XPressed, YPressed)}
        .onChange(of: BPressed){b in closure(APressed, b, XPressed, YPressed)}
        .onChange(of: XPressed){x in closure(APressed, BPressed, x, YPressed)}
        .onChange(of: YPressed){y in closure(APressed, BPressed, XPressed, y)}
        .overlay(RetrieveDimension(dim: .width, into: $size, when: .dimIsSmaller))
        .overlay(RetrieveDimension(dim: .height, into: $size, when: .dimIsSmaller))
        .frame(maxWidth: size, maxHeight: size)
    }
}

struct ABXY_Previews: PreviewProvider {
    static var previews: some View {
        ABXY()
    }
}
