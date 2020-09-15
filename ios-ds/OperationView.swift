//
//  OperationView.swift
//  ios-ds
//
//  Created by Vasista Vovveti on 9/13/20.
//

import SwiftUI
import Introspect

struct ModeSelector: View {
    @ObservedObject var state: DriverStationState = .shared
    var body: some View {
        Picker(selection: $state.gameMode, label: /*@START_MENU_TOKEN@*/Text("Picker")/*@END_MENU_TOKEN@*/) {
            Text("TeleOperated").tag(GameMode.Teleoperated)
            Text("Autonomous").tag(GameMode.Autonomous)
            Text("Test").tag(GameMode.Test)
        }.pickerStyle(SegmentedPickerStyle())
        .padding()
        .shadow(radius: 5)
    }
}


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
        .shadow(radius: 5)
        
    }
}

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

struct TelemetryView: View {
    @ObservedObject var state: DriverStationState = .shared
    var body: some View {
        
        VStack {
            HStack{
                Text("Communications")
                ProgressBar(value: state.isConnected ? 1 : 0)
                    .frame(height: 10)
            }
            Divider()
            HStack{
                Text("Robot Code")
                ProgressBar(value: state.isCodeAlive ? 1 : 0)
                    .frame(height: 10)
            }
            Divider()
            HStack{
                Text("Joysticks")
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

struct OperationView: View {
    var body: some View {
        
        VStack {
            TelemetryView()
            ModeSelector()
            EnableDisableButtons()
            
        }
    }
}

struct OperationView_Previews: PreviewProvider {
    static var previews: some View {
        OperationView()
    }
}
