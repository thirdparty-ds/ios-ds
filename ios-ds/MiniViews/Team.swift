//
//  Team.swift
//  ios-ds
//
//  Created by Vasista Vovveti on 9/16/20.
//

import SwiftUI

struct Team: View {
    @ObservedObject var state: DriverStationState = .shared
    @State var number = "0000"
    @State var show = false
    
    
    
    init() {
        number = String(state.teamNumber)
    }
    
    
    var body: some View {
        
        ZStack {
        
        AlertControlView(textString: $number, showAlert: $show, title: "Set Team Number", message: "qqq")
            .onChange(of: number){ num in
                
                let newTeamNumber = Int(num) ?? -1
                
                if newTeamNumber != state.teamNumber {
                    
                    if newTeamNumber >= 0 {
                        state.teamNumber = UInt32(newTeamNumber)
                    }
                    
                    if state.teamNumber == 0 {
                        number = "0000"
                    } else {
                        number = String(state.teamNumber)
                    }
                }
                
                
            }
        
        Button(action: {
            show = true
        }) {
            VStack {
                
                Text("Team #")
                    .bold()
                    .font(.title3)
                    .foregroundColor(.primary)
                
                Text(state.teamNumber == 0 ? "0000" : String(state.teamNumber))
                    .bold()
                    .font(.title3)
                    .foregroundColor(
                        state.teamNumber == 365 ? .green :
                            state.teamNumber == 4096 ? .orange :
                            .blue
                    )
            }
        }
        .padding()
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(
            RoundedRectangle(cornerRadius: 15, style: .circular)
                .foregroundColor(Color(UIColor.secondarySystemBackground))
        )
        .padding()
    }
    }
}
