//
//  Telemetry.swift
//  ios-ds
//
//  Created by Vasista Vovveti on 9/15/20.
//

import SwiftUI

struct Telemetry: View {
    @ObservedObject var state: DriverStationState = .shared
    var body: some View {
        
        VStack {
            HStack{
                Text("Communications").bold()
                ProgressBar(value: state.isConnected ? 1 : 0)
                    .frame(height: 10)
            }
            Divider()
            HStack{
                Text("Robot Code").bold()
                ProgressBar(value: state.isCodeAlive ? 1 : 0)
                    .frame(height: 10)
            }
            Divider()
            HStack{
                Text("Joysticks").bold()
                ProgressBar(value: state.gameMode == GameMode.Test ? 1 : 0)
                    .frame(height: 10)
            }
        }
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 15, style: .circular)
                .foregroundColor(Color(UIColor.secondarySystemBackground))
        )
        .frame(maxWidth: .infinity)
        .frame(height: 150)
        .padding()
        .shadow(radius: 5)
        
        
    }
}
