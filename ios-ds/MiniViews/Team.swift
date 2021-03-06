//
//  Team.swift
//  ios-ds
//
//  Created by Vasista Vovveti on 9/16/20.
//

import SwiftUI
import PopupView


struct Team: View {
    @ObservedObject var state: DriverStationState = .shared
    @ObservedObject var dev: DeveloperOptions = .shared
    @State var number = "0000"
    @State var show = false
    
    
    init() {
        number = String(state.teamNumber)
    }
    
    var body: some View {
        
            ZStack {
                
                AlertControlView(textString: $number, showAlert: $show, title: "Set Team Number", message: "", keyboardType: .numberPad)
                    .onChange(of: number){ num in

                        if num == "8675309" {
                            dev.isOn.toggle()
                        }

                        if num == "0" {
                            dev.isOn = false
                        }

                        let newTeamNumber = Int(num) ?? -1

                        if newTeamNumber != state.teamNumber {
                            if 0 <= newTeamNumber && newTeamNumber <= 9999 {
                                state.teamNumber = UInt32(newTeamNumber)
                                number = num
                            }
                        }
                    }
                    .frame(maxWidth: 0, maxHeight: 0) // "invisible" element
                
                Button(action: {
                    state.isEnabled = false
                    show = true
                }) {
                    VStack {
                        
                        Text("Team")
                            .bold()
                            .font(.title3)
                            .foregroundColor(.primary)
                            .frame(maxWidth: .infinity, alignment: .topLeading)
                        
                        Text(String(state.teamNumber))
                            .bold()
                            .font(.title3)
                            .foregroundColor(
                                Color.teamColor
                            )
                            .frame(maxHeight: .infinity)
                    }
                }
                .padding()
                .background(
                    RoundedRectangle(cornerRadius: 15, style: .circular)
                        .foregroundColor(Color(UIColor.secondarySystemBackground))
                )
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}
