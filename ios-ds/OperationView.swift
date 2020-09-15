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
        let cannotEnable = !state.isConnected || state.isEstopped || !state.isCodeAlive
        
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
            
            if cannotEnable {
                
                RoundedRectangle(cornerRadius: 15, style: .circular)
                    .frame(maxWidth: .infinity)
                    .frame(height: 100)
                    .foregroundColor(Color(UIColor.secondarySystemBackground))
                    .opacity(0.7)
                    .padding()
                    .zIndex(2)
                
                if state.isEstopped {
                    Text("Robot is Estopped!")
                        .fontWeight(.bold)
                        .font(.title)
                        .animation(.default)
                        .zIndex(3)
                } else if !state.isConnected {
                    Text("No connection to Robot!")
                        .fontWeight(.bold)
                        .font(.title)
                        .animation(.default)
                        .zIndex(3)
                } else if !state.isCodeAlive {
                    Text("Robot Code is not running!")
                        .fontWeight(.bold)
                        .font(.title)
                        .animation(.default)
                        .zIndex(3)
                }
                
            }
            
        }
        .frame(maxWidth: .infinity)
        .frame(height: 100)
        .shadow(radius: 5)
        
    }
}

struct TelemetryView: View {
    @ObservedObject var state: DriverStationState = .shared
    var body: some View {
        
        ZStack {
            RoundedRectangle(cornerRadius: 15, style: .circular)
                .frame(maxWidth: .infinity)
                .frame(maxHeight: .infinity)
                .foregroundColor(Color(UIColor.secondarySystemBackground))
            
            VStack {
                HStack{
                    Text("Communications")
                    RoundedRectangle(cornerRadius: 15, style: .circular)
                        .foregroundColor(state.isConnected ? .green : .red)
                        .frame(height: 10)
                }
                Divider()
                HStack{
                    Text("Robot Code")
                    RoundedRectangle(cornerRadius: 15, style: .circular)
                        .foregroundColor(state.isCodeAlive ? .green : .red)
                        .frame(height: 10)
                }
                Divider()
                HStack{
                    Text("Joysticks")
                    RoundedRectangle(cornerRadius: 15, style: .circular)
                        .foregroundColor(false ? .green : .red)
                        .frame(height: 10)
                }
            }
            .padding()
        }
        .frame(maxWidth: .infinity)
        .frame(height: 150)
        .padding()
        .shadow(radius: 5)
        .animation(.default)
        
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
