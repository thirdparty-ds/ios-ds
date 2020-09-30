//
//  RioLogView.swift
//  ios-ds
//
//  Created by Vasista Vovveti on 9/29/20.
//

import SwiftUI

struct RioLogView: View {
    @Environment(\.verticalSizeClass) var verticalSizeClass: UserInterfaceSizeClass?
    var body: some View {
        HStack {
            if verticalSizeClass == .compact {
                EnableDisableButtons(isVertical: true)
                    .shadow(radius: 8)
            }
            
            VStack {
                RioLog()
                
                if verticalSizeClass == .regular {
                    EnableDisableButtons(isVertical: false)
                        .shadow(radius: 8)
                }
            }
        }.padding(8)
    }
}
