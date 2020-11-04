//
//  JoystickSelector.swift
//  ios-ds
//
//  Created by Vasista Vovveti on 11/4/20.
//

import SwiftUI

struct JoystickSelector: View {
    @Binding var joysticks: [String]
    @State private var labelWidth: CGFloat = 1e99
    @State private var selectedItem: String = ""
    
    func move(from source: IndexSet, to destination: Int) {
        // only fires after item is let go
        joysticks.move(fromOffsets: source, toOffset: destination)
    }
    
    var body: some View {
            
        GeometryReader { proxy in
            HStack(spacing: 0) {
                
                List {
                    
                    ForEach(["0","1","2","3","4","5"], id: \.self) { n in
                        Text(n)
                            .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                            .overlay(RetrieveDimension(dim: .width, into: $labelWidth, when: .always))
                    }
                }
                .introspectTableView { table in
                    table.isScrollEnabled = false
                }
                .frame(minWidth: 0, idealWidth: 0, maxWidth: labelWidth * 5)
                
                List {
                        ForEach(joysticks, id: \.self) { j in
                            Text(j)
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .background(
                                    RoundedRectangle(cornerRadius: 5)
                                        .foregroundColor(selectedItem == j ? .blue : .clear)
                                )
                                .multilineTextAlignment(.leading)
                                .onTapGesture{
                                    withAnimation(.easeOut(duration: 0.2)) {
                                        selectedItem = selectedItem == j ? "" : j
                                        
                                    }
                                }
                        }
                        .onMove(perform: move)
                }
                .introspectTableView { table in
                    table.isScrollEnabled = false
                }
                .offset(y: 0)
                .environment(\.editMode, Binding.constant(EditMode.active))

            }
            .padding() // DO NOT REMOVE; MUST BE >= 0.1
        }
        
    }
}

struct JoystickSelector_Previews: PreviewProvider {
    static var previews: some View {
        JoystickSelector()
    }
}
