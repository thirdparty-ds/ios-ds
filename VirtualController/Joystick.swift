//
//  Joystick.swift
//  j
//
//  Created by Vasista Vovveti on 10/21/20.
//
import UIKit
import SwiftUI
import CoreHaptics

public struct ForceTouchDragGestureValue : Equatable {
    var radius: CGFloat
    var radiusTolerance: CGFloat
    var startLocation: CGPoint
    var location: CGPoint
    var translation: CGSize
    
    func copy() -> ForceTouchDragGestureValue {
        return ForceTouchDragGestureValue(
            radius: radius,
            radiusTolerance: radiusTolerance,
            startLocation: startLocation,
            location: location,
            translation: translation
        )
    }
    
}

public class ForceTouchHandler: UIViewController {
    private(set) var value: ForceTouchDragGestureValue = ForceTouchDragGestureValue(
        radius: 0,
        radiusTolerance: 0,
        startLocation: CGPoint(x: 0, y: 0),
        location: CGPoint(x: 0, y: 0),
        translation: CGSize(width: 0, height: 0)
    )
    
    private var onChangedCallback: (ForceTouchDragGestureValue) -> () = {_ in}
    private var onEndedCallback: (ForceTouchDragGestureValue) -> () = {_ in}
    
    public func onChanged(_ action: @escaping (ForceTouchDragGestureValue) -> ()) -> ForceTouchHandler {
//        print("r")
        onChangedCallback = action
        return self
    }
    
    public func onEnded(_ action: @escaping (ForceTouchDragGestureValue) -> ()) -> ForceTouchHandler {
        onEndedCallback = action
        return self
    }
    
    override public func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let touch = touches.first

        value.startLocation = touch?.preciseLocation(in: view) ?? CGPoint(x: 0, y: 0)
        value.location = touch?.preciseLocation(in: view) ?? CGPoint(x: 0, y: 0)
        value.radiusTolerance = touch?.majorRadiusTolerance ?? 0
        value.radius = touch?.majorRadius ?? 0
        value.translation = CGSize(width: 0, height: 0)
        
        onChangedCallback(value)
        
    }

    override public func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        let touch = touches.first

        value.location = touch?.preciseLocation(in: view) ?? CGPoint(x: 0, y: 0)
        value.radius = touch?.majorRadius ?? 0
        value.translation = CGSize(
            width: value.location.x - value.startLocation.x,
            height: value.location.y - value.startLocation.y
        )
        
//        print(value.location)
        onChangedCallback(value)
    }

    override public func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
//        let touch = touches.first

        value.startLocation = CGPoint(x: 0, y: 0)
        value.location = CGPoint(x: 0, y: 0)
        value.radiusTolerance = 0
        value.radius = 0
        value.translation = CGSize(width: 0, height: 0)
        
        onEndedCallback(value)
    }
    
    override public func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
//        let touch = touches.first

        value.startLocation = CGPoint(x: 0, y: 0)
        value.location = CGPoint(x: 0, y: 0)
        value.radiusTolerance = 0
        value.radius = 0
        value.translation = CGSize(width: 0, height: 0)
        
        onEndedCallback(value)
    }
    
}



struct ForceTouchDragGestureView: UIViewControllerRepresentable {
    
    public var onChanged: (ForceTouchDragGestureValue) -> () = {_ in}
    public var onEnded: (ForceTouchDragGestureValue) -> () = {_ in}
    
    
    typealias UIViewControllerType = ForceTouchHandler
    
    func makeUIViewController(context: UIViewControllerRepresentableContext<ForceTouchDragGestureView>) -> ForceTouchHandler {
        return ForceTouchHandler().onChanged(onChanged).onEnded(onEnded)
    }

    func updateUIViewController(_ uiViewController: ForceTouchHandler, context: UIViewControllerRepresentableContext<ForceTouchDragGestureView>) {
        
    }
    
}

struct Joystick: View{
    var text: String = ""
    var closure: (CGPoint) -> () = {_ in}
    
    @State private var position: CGPoint = CGPoint(x: 0, y: 0)
    @State private var size: CGFloat = 1e99
    @State private var forcePressed: Bool = false
    @State private var positionClamped: Bool = false
    
    private func clampOffset(width: CGFloat, height: CGFloat, radius: CGFloat) -> (CGFloat, CGFloat) {
        let r2 = sqrt( pow(width, 2) + pow(height, 2) )
        var newWidth = width
        var newHeight = height
        if r2 > radius {
            newWidth *= radius / r2
            newHeight *= radius / r2
        }
        return (newWidth, newHeight)
    }

    var body: some View {
        let diameter = size
        let radius = diameter / 2
        ZStack{
            Circle()
                .foregroundColor(forcePressed ? .red : .none)
            Circle()
                .foregroundColor(.blue)
                .overlay(
                    Text(text)
                )
                .frame(maxWidth: size / 1.25, maxHeight: size / 1.25)
                .rotation3DEffect(
                    .degrees(35 * sqrt(Double(pow(position.x, 2) + pow(position.y, 2)))),
                    axis: (
                        x: -position.y,
                        y: position.x,
                        z: 0
                    )
                )
                .offset(
                    x: position.x * radius,
                    y: position.y * radius
                )

                .shadow(radius: 15)
            
            ForceTouchDragGestureView (
                onChanged: { value in
                    let radius = size / 2
                    let (newWidth, newHeight) = clampOffset(width: value.translation.width, height: value.translation.height, radius: radius)
                    position.x = newWidth / radius
                    position.y = newHeight / radius
                    forcePressed = value.radius > 75
                    
                    let impact = UIImpactFeedbackGenerator(style: .rigid)
                    
                    if sqrt(pow(value.translation.width, 2) + pow(value.translation.height, 2)) > radius {
                        if !positionClamped {
                            impact.impactOccurred()
                        }
                        positionClamped = true
                    } else {
                        positionClamped = false
                    }
                    
                },
                onEnded: { _ in
                    withAnimation(.easeOut(duration: 0.1)) {
                        position.x = 0
                        position.y = 0
                    }
                    
                    forcePressed = false
                    
                }
            )
            .frame(maxWidth: size / 1.5, maxHeight: size / 1.5)
            .clipShape(/*@START_MENU_TOKEN@*/Circle()/*@END_MENU_TOKEN@*/).allowsHitTesting(true)
                
        }
        .onChange(of: position) { p in
            closure(p)
        }
        .overlay(RetrieveDimension(dim: .width, into: $size, when: .dimIsSmaller))
        .overlay(RetrieveDimension(dim: .height, into: $size, when: .dimIsSmaller))
        .frame(maxWidth: size, maxHeight: size)
    }
}
