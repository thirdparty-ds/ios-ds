//
//  RebootView.swift
//  ios-ds
//
//  Created by Vasista Vovveti on 9/18/20.
//

import SwiftUI

struct RebootView: View {
    @ObservedObject var state: DriverStationState = .shared
    
    var body: some View {
        
        HStack{
            Button(action: {
                state.ds.restartRoboRIO()
            }) {
                Text("Restart RoboRIO")
                    .bold()
                    .frame(maxWidth: .infinity)
                    .frame(height: 30)
            }
            .foregroundColor(.primary)
            .background(Color(UIColor.systemFill))
            .cornerRadius(10)
            
            Button(action: {
                state.ds.restartCode()
            }) {
                Text("Restart Code")
                    .bold()
                    .frame(maxWidth: .infinity)
                    .frame(height: 30)
            }
            .foregroundColor(.primary)
            .background(Color(UIColor.systemFill))
            .cornerRadius(10)
            
        }
        .padding(8)
        .frame(maxWidth: .infinity)
        .background(
            RoundedRectangle(cornerRadius: 15, style: .circular)
                .foregroundColor(Color(UIColor.secondarySystemBackground))
        )
//        .padding()
    }
}

struct RebootView_Previews: PreviewProvider {
    static var previews: some View {
        RebootView()
    }
}
