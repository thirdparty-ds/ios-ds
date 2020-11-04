//
//  Dpad.swift
//  j
//
//  Created by Vasista Vovveti on 10/21/20.
//

import SwiftUI

enum DpadState: Int {
    /// clockwise
    case none = -1
    case north = 0
    case northeast = 45
    case east = 90
    case southeast = 135
    case south = 180
    case southwest = 225
    case west = 270
    case northwest = 315
}

struct Dpad: View {
    @GestureState private var state: DpadState = .none
    @State private var size: CGFloat = 1e99
    let closure: (DpadState) -> ()
    
    init(closure: @escaping (DpadState) -> () = {_ in}) {
        self.closure = closure
    }
    
    var body: some View {
        let outerCornerRadius: CGFloat = 14
        let innerCornerRadius: CGFloat = 11
        ZStack {
            ZStack {
                Rectangle()
                    .frame(maxWidth: size - outerCornerRadius * 2 - 1, maxHeight: size - outerCornerRadius * 2 - 1)
            }
            .frame(maxWidth: size, maxHeight: size)
            .mask(
                VStack {
                    HStack(spacing: .none){
                        RoundedRectangle(cornerRadius: innerCornerRadius, style: .continuous).frame(width: size/3, height: size/3)
                        RoundedRectangle(cornerRadius: innerCornerRadius, style: .continuous)
                        RoundedRectangle(cornerRadius: innerCornerRadius, style: .continuous).frame(width: size/3, height: size/3)
                    }
                    HStack{
                        RoundedRectangle(cornerRadius: innerCornerRadius, style: .continuous)
                        RoundedRectangle(cornerRadius: innerCornerRadius, style: .continuous)
                        RoundedRectangle(cornerRadius: innerCornerRadius, style: .continuous)
                    }
                    HStack{
                        RoundedRectangle(cornerRadius: innerCornerRadius, style: .continuous).frame(width: size/3, height: size/3)
                        RoundedRectangle(cornerRadius: innerCornerRadius, style: .continuous)
                        RoundedRectangle(cornerRadius: innerCornerRadius, style: .continuous).frame(width: size/3, height: size/3)
                    }
                }
                .foregroundColor(.black)
                .background(Color.white)
                .compositingGroup()
                .luminanceToAlpha()
            )
            
            RoundedRectangle(cornerRadius: outerCornerRadius, style: .continuous)
                .frame(maxWidth: size, maxHeight: size / 3)
            RoundedRectangle(cornerRadius: outerCornerRadius, style: .continuous)
                .frame(maxWidth: size / 3, maxHeight: size)
            
        }
        .clipped()
        .gesture(
            DragGesture(minimumDistance: 0, coordinateSpace: .local)
                .updating($state){ value, state, transaction in
                    let x = value.location.x
                    let y = value.location.y

                    let firstThird = size / 3
                    let secondThird = 2 * size / 3

                    let row = y < firstThird ? 0 :
                        y < secondThird ? 1 : 2
                    let col = x < firstThird ? 0 :
                        x < secondThird ? 1 : 2

                    let newState: DpadState = {
                        switch (row, col) {
                        case (0, 0): return .northwest
                        case (0, 1): return .north
                        case (0, 2): return .northeast
                        case (1, 0): return .west
                        case (1, 1): return .none
                        case (1, 2): return .east
                        case (2, 0): return .southwest
                        case (2, 1): return .south
                        case (2, 2): return .southeast
                        default: return .none
                        }
                    }()

                    if state == .none && (
                                   newState == .northwest
                                || newState == .northeast
                                || newState == .southwest
                                || newState == .southeast) {
                        return
                    }
                    
                    if newState != state {
                        state = newState
                    }
                }

        )
        .onChange(of: state){ s in
            let impact = UIImpactFeedbackGenerator(style: .light)
            impact.impactOccurred()
            
            closure(s)
        }
        .clipped()
        .shadow(
            radius: 15,
            x: (90 < state.rawValue && state.rawValue < 270) ? -1 : (state == .northwest || state == .north || state == .northeast) ? 1 : 0,
            y: state.rawValue > 180 ? -1 : (0 < state.rawValue && state.rawValue < 180) ? 1 : 0
        )
        .rotation3DEffect(
            .degrees(5),
            axis: (
                x: (90 < state.rawValue && state.rawValue < 270) ? -1 : (state == .northwest || state == .north || state == .northeast) ? 1 : 0,
                y: state.rawValue > 180 ? -1 : (0 < state.rawValue && state.rawValue < 180) ? 1 : 0,
                z: 0
            )
        )
        .overlay(RetrieveDimension(dim: .width, into: $size, when: .dimIsSmaller))
        .overlay(RetrieveDimension(dim: .height, into: $size, when: .dimIsSmaller))
        .frame(maxWidth: size, maxHeight: size)

    }
}

struct Dpad_Previews: PreviewProvider {
    static var previews: some View {
        Dpad()
    }
}
