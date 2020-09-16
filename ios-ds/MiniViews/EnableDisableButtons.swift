//
//  EnableDisableButtons.swift
//  ios-ds
//
//  Created by Vasista Vovveti on 9/15/20.
//

import SwiftUI

struct EnableDisableButtons: View {
    @ObservedObject var state: DriverStationState = .shared
    
    var body: some View {
        let cannotEnable: Bool = !state.isConnected || state.isEstopped || !state.isCodeAlive
        //        let cannotEnable: Bool = state.gameMode == GameMode.Test
        
        ZStack {
            RoundedRectangle(cornerRadius: 15, style: .circular)
                .frame(maxWidth: .infinity)
                .frame(height: 100)
                .foregroundColor(Color(UIColor.secondarySystemBackground))
                .padding()
            
            GeometryReader { metrics in
                HStack {
                    Button(action: {
                        state.isEnabled = true
                        state.isEnabled = state.isEnabled
                    }) {
                        Text(state.isEnabled ? "Enabled" : "Enable")
                            .fontWeight(.semibold)
                            .font(.title)
                            .underline(state.isEnabled, color: .white)
                    }
                    .disabled(cannotEnable)
                    .frame(maxWidth: metrics.size.width * 0.3, maxHeight: .infinity)
                    .foregroundColor(.white)
                    .background(Color.green)
                    .cornerRadius(15)
                    
                    
                    Button(action: {
                        state.isEnabled = false
                        state.isEnabled = state.isEnabled
                    }) {
                        Text(state.isEnabled ? "Disable" : "Disabled")
                            .fontWeight(.semibold)
                            .font(.title)
                            .underline(!state.isEnabled, color: .white)
                    }
                    .disabled(cannotEnable)
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .foregroundColor(.white)
                    .background(Color.red)
                    .cornerRadius(15)
                    
                }
                
                
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .padding()
            .padding()
            .blur(radius: cannotEnable ? 10 : 0)
            
            
            if cannotEnable && state.isEstopped {
                
                RoundedRectangle(cornerRadius: 15, style: .circular)
                    .frame(maxWidth: .infinity)
                    .frame(height: 100)
                    .foregroundColor(Color(UIColor.secondarySystemBackground))
                    .opacity(0.7)
                    .padding()
                    .zIndex(2)
                
                Text("Robot is Estopped!")
                    .fontWeight(.bold)
                    .font(.title)
                    .animation(.default)
                    .zIndex(3)
                
                
            }
            
        }
        .animation(.easeOut(duration: 0.1))
        .frame(maxWidth: .infinity)
        .frame(height: 100)
        
    }
}

