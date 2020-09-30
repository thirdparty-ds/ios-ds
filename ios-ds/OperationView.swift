//
//  OperationView.swift
//  ios-ds
//
//  Created by Vasista Vovveti on 9/13/20.
//

import SwiftUI


struct OperationView: View {
    @Environment(\.verticalSizeClass) var verticalSizeClass: UserInterfaceSizeClass?
    @Environment(\.horizontalSizeClass) var horizontalSizeClass: UserInterfaceSizeClass?
    @State var teamHeight: CGFloat = 0
    
    var body: some View {
        
        HStack {
            if verticalSizeClass == .compact {
                EnableDisableButtons(isVertical: true)
                    .shadow(radius: 8)
            }
            
            VStack {
                Battery().drawingGroup()
                
                RebootView()
                
                HStack {
                    Telemetry().overlay(RetrieveDimension(dim: .height, into: $teamHeight, when: .always))
                    
                    Team()
                        .frame(maxWidth: 82)
                        .frame(maxHeight: teamHeight)
                }

                GameModeSelector()
//                    .padding(.bottom, 8)
                
                if verticalSizeClass == .regular {
                    EnableDisableButtons(isVertical: false)
                        .shadow(radius: 8)
                }
                
            }
            
            if verticalSizeClass == .regular && horizontalSizeClass == .regular {
                RioLog()
            }
            
        }
        .padding(8)
    }
}

struct OperationView_Previews: PreviewProvider {
    static var previews: some View {
        OperationView()
    }
}
