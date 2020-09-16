//
//  OperationView.swift
//  ios-ds
//
//  Created by Vasista Vovveti on 9/13/20.
//

import SwiftUI


struct OperationView: View {
    var body: some View {
        
        VStack {
            HStack {
                Team()
                BatteryInfo()
            }
            Telemetry()
            GameModeSelector()
            EnableDisableButtons()
            
        }
        .padding(.bottom, 16)
    }
}

struct OperationView_Previews: PreviewProvider {
    static var previews: some View {
        OperationView()
    }
}
