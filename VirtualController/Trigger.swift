//
//  Trigger.swift
//  j
//
//  Created by Vasista Vovveti on 10/31/20.
//

import SwiftUI

struct Trigger: View {
    var text: String = ""
    var closure: (CGFloat) -> () = {_ in}
    
    @GestureState private var amount: CGFloat = 0
    @State private var amountAnimated: CGFloat = 0
    @State private var width: CGFloat = 1e99
    @State private var height: CGFloat = 1e99
    
    var body: some View {
        ZStack(alignment: .top) {
            RoundedRectangle(cornerRadius: 15, style: .continuous)
            
            let sliderHeight: CGFloat = 50
            let totalTravel = height - sliderHeight
            
            RoundedRectangle(cornerRadius: 15, style: .continuous)
                .foregroundColor(.blue)
                .overlay(
                    Text(text)
                )
                .offset(y: amountAnimated * totalTravel)
                .gesture(
                    DragGesture(minimumDistance: 0, coordinateSpace: .local)
                        .updating($amount) { value, state, transaction in
//                            print(value.location.y)
                            state = max(0, min(totalTravel, value.translation.height)) / totalTravel
                            
                            if amount < 1 && state == 1 {
                                let impact = UIImpactFeedbackGenerator(style: .soft)
                                impact.impactOccurred()
                            }
                            
                        }
                )
                .onChange(of: amount) { a in
                    withAnimation(.easeOut(duration: a == 0 ? 0.05 : 0)){
                       amountAnimated = a
                    }
                }
                .onChange(of: amountAnimated) { a in
                    closure(a)
                }
                .frame(maxHeight: sliderHeight)
        }
        .overlay(RetrieveDimension(dim: .width, into: $width, when: .always))
        .overlay(RetrieveDimension(dim: .height, into: $height, when: .always))
        .frame(maxWidth: width, maxHeight: height)
    }
}

struct Trigger_Previews: PreviewProvider {
    static var previews: some View {
        Trigger()
    }
}
