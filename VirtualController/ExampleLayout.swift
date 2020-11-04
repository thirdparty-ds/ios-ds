//
//  ExampleLayout.swift
//  ios-ds
//
//  Created by Vasista Vovveti on 11/3/20.
//

import SwiftUI

struct ExampleLayout: View {
    @State var height: CGFloat = 1e99
    @Environment(\.horizontalSizeClass) var horizontalSizeClass: UserInterfaceSizeClass?
    var body: some View {
        
        Spacer()
        
        Group {
            HStack {
                ControllerButton(text: "Start")
                    .frame(width: 80, height: 50)
                ControllerButton(text: "Select")
                    .frame(width: 80, height: 50)
            }
            
            HStack {
                Spacer()
                Trigger(text: "LT")
                    .frame(width: 80, height: 100)
                Trigger(text: "RT")
                    .frame(width: 80, height: 100)
                Spacer()
            }
            
            HStack {
                Spacer()
                ControllerButton(text: "LB")
                    .frame(width: 80, height: 50)
                ControllerButton(text: "RB")
                    .frame(width: 80, height: 50)
                Spacer()
            }
        }
        .overlay(RetrieveDimension(dim: .height, into: $height, when: .always))
        .offset(y: horizontalSizeClass == .regular ? 200 : 0)
        
        
        HStack(spacing: 0) {

            Spacer()
                .frame(maxWidth: 50)
            
            Joystick(text: "L")
                .frame(width: 80)
            
            Spacer()
                .frame(maxWidth: .infinity)

            ABXY()
                .frame(width: 150)

            Spacer(minLength: 10)
            
        }
        .frame(height: 150)
        

        
        HStack(spacing: 0) {

            Spacer(minLength: 10)
            
            Dpad()
                .frame(width: 120)
            
            Spacer()
                .frame(maxWidth: .infinity)

            Joystick(text: "R")
                .frame(width: 80)

            Spacer()
                .frame(maxWidth: 50)
            
        }
        .frame(height: 150)

        Rectangle()
            .foregroundColor(.clear)
            .frame(height: horizontalSizeClass == .regular ? 100 : 50)
        
//        .overlay(RetrieveDimension(dim: .width, into: $width, when: .always))
//        .frame(maxWidth: width)
//        VStack {
//            HStack {
//                Spacer()
//                Trigger()
//                    .frame(width: 100, height: 80)
//                Spacer()
//                Trigger()
//                    .frame(width: 100, height: 80)
//                Spacer()
//            }
//            ControllerButton()
//            HStack {
//                Spacer()
//                Joystick().frame(width: 100)
//                Spacer()
//                ABXY().frame(width: 150)
//                Spacer()
//            }
//            Spacer()
//                .frame(height: 50)
//            HStack {
//                Spacer()
//                Dpad().frame(width: 150)
//                Spacer()
//                Joystick().frame(width: 100)
//                Spacer()
//            }
//        }
    }
}

struct ExampleLayout_Previews: PreviewProvider {
    static var previews: some View {
        ExampleLayout()
    }
}
