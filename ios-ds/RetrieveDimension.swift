//
//  RetrieveDimension.swift
//  ios-ds
//
//  Created by Vasista Vovveti on 9/21/20.
//

import SwiftUI

struct RetrieveDimension: View {
    
    enum RDDimension {
        case width
        case height
    }
    
    enum RDCondition {
        case always
        case dimIsGreater
        case dimIsSmaller
    }
    
    var dim: RDDimension
    @Binding var into: CGFloat
    var when: RDCondition
    
    var body: some View {
        GeometryReader { proxy in
            Color.clear.onAppear{
                var newValue: CGFloat = 0
                
                switch dim {
                case .width:
                    newValue = proxy.size.width
                case .height:
                    newValue = proxy.size.height
                }
                
                switch when {
                case .always:
                    into = newValue
                case .dimIsGreater:
                    if newValue > into {
                        into = newValue
                    }
                case .dimIsSmaller:
                    if newValue < into {
                        into = newValue
                    }
                }
            }
        }
    }
}
