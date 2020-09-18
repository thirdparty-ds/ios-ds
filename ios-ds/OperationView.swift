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
            Battery()
                .drawingGroup()
            
            HStack {
                Telemetry()
                Team()
                    .frame(maxWidth: 82)
            }

            GameModeSelector()
                .padding(.bottom, 8)
            EnableDisableButtons()
                .shadow(radius: 8)
            
        }
        .padding(8)
    }
}

struct OperationView_Previews: PreviewProvider {
    static var previews: some View {
        OperationView()
    }
}
