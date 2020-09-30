//
//  RioLog.swift
//  ios-ds
//
//  Created by Vasista Vovveti on 9/21/20.
//

import SwiftUI

struct RioLog: View {
    @ObservedObject var state: DriverStationState = .shared
    @State var shouldAutoScroll: Bool = true
    
    var body: some View {
        ZStack {
            ScrollView {
                ScrollViewReader { proxy in
                    LazyVStack(alignment: .leading) {
                        Text("Riolog")
                            .bold()
                            .font(.title3)
                            .foregroundColor(.primary)
                        ForEach(state.rioLog, id: \.self) { item in
                            Text(item.value)
                                .font(Font.system(.body, design: .monospaced))
                                .frame(maxWidth: .infinity, alignment: .leading)
                        }
                    }
                    .onChange(of: state.rioLog) { _ in
                        if shouldAutoScroll {
                            proxy.scrollTo(state.rioLog.last!)
                        }
                    }
                }
            }
            .gesture(
                DragGesture()
                    .onChanged { _ in
                        shouldAutoScroll = false
                    }
            )
            
            if !shouldAutoScroll {
            
                Button(action: {
                    shouldAutoScroll = true
                }) {
                    Image(systemName: "arrow.down.to.line")
                        .font(.system(size: 25.0))
                        .foregroundColor(.white)
                        .padding()
                        .background(
                            Circle()
                                .foregroundColor(
                                    .teamColor != Color.white ? .teamColor : .blue
                                )
                        )
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .bottomTrailing)
                .padding(.bottom, 64)
                .padding(.trailing, 16)
                .transition(.move(edge: .trailing))
                .animation(.spring())
            
            }
        }
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 15, style: .circular)
                .foregroundColor(Color(UIColor.secondarySystemBackground))
        )
//        .padding()
    }
}
