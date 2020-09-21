//
//  EnableDisableButtons.swift
//  ios-ds
//
//  Created by Vasista Vovveti on 9/15/20.
//

import SwiftUI

struct EnableDisableButtons: View {
    @ObservedObject var state: DriverStationState = .shared
    @ObservedObject var dev: DeveloperOptions = .shared
    var isVertical: Bool
    
    init(isVertical: Bool = false) {
        self.isVertical = isVertical
    }
    
    
    @ViewBuilder
    func EnableButton() -> some View {
        Button(action: {
            state.isEnabled = true
        }) {
            Text(state.isEnabled ? "Enabled" : "Enable")
                .fontWeight(.semibold)
                .font(.title2)
                .underline(state.isEnabled, color: .white)
                .frame(maxWidth: .infinity, maxHeight: .infinity)
        }
        .foregroundColor(.white)
        .background(Color.green)
        .cornerRadius(15)
    }
    
    @ViewBuilder
    func DisableButton() -> some View {
        Button(action: {
            state.isEnabled = false
        }) {
            Text(state.isEnabled ? "Disable" : "Disabled")
                .fontWeight(.semibold)
                .font(.title2)
                .underline(!state.isEnabled, color: .white)
                .frame(maxWidth: .infinity, maxHeight: .infinity)
        }
        .foregroundColor(.white)
        .background(Color.red)
        .cornerRadius(15)
    }
    
    var body: some View {
        let cannotEnable: Bool = (!state.isConnected || state.isEstopped || !state.isCodeAlive) && !(dev.isOn && dev.unhideEnableButton && state.gameMode != GameMode.Test)
        
        ZStack{
            GeometryReader { metrics in
                if !cannotEnable {
                    if !isVertical {
                        HStack() {
                            EnableButton()
                                .frame(maxWidth: metrics.size.width * 0.3, maxHeight: .infinity)
                            
                            Spacer()
                            
                            DisableButton()
                                .frame(maxWidth: .infinity, maxHeight: .infinity)
                        }.disabled(cannotEnable)
                    } else {
                        VStack() {
                            EnableButton()
                                .frame(maxWidth: .infinity, maxHeight: metrics.size.height * 0.3)
                            
                            Spacer()
                            
                            DisableButton()
                                .frame(maxWidth: .infinity, maxHeight: .infinity)
                        }.disabled(cannotEnable)
                    }
                }
                
            }
            .frame(maxWidth: isVertical ? 90 : .infinity, maxHeight: isVertical ? .infinity : 90)
            .padding(8)
            .background(
                RoundedRectangle(cornerRadius: 15, style: .circular)
                    .foregroundColor(Color(UIColor.secondarySystemBackground))
            )
            .animation(.easeOut(duration: 0.1))
            
            if state.isEstopped {
                VStack {
                    Text("Robot")
                        .fontWeight(.bold)
                        .font(.title)
                    
                    Text("is")
                        .fontWeight(.bold)
                        .font(.title)
                    
                    Text("ESTOP!")
                        .fontWeight(.bold)
                        .font(.title)
                }
                .animation(.default)
                .zIndex(3)
            }
            
        }
        
        
    }
}

