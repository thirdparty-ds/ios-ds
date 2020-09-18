//
//  Battery.swift
//  ios-ds
//
//  Created by Vasista Vovveti on 9/16/20.
//

import SwiftUI
import SwiftUICharts

public struct CustomCardView<Content: View>: View, ChartBase {
    public var chartData = ChartData()
    let content: () -> Content
    
    private var showShadow: Bool
    
    @EnvironmentObject var style: ChartStyle
    
    public init(showShadow: Bool = true, @ViewBuilder content: @escaping () -> Content) {
        self.showShadow = showShadow
        self.content = content
    }
    
    public var body: some View {
        ZStack{
            RoundedRectangle(cornerRadius: 20)
                .fill(Color(UIColor.secondarySystemBackground))
            VStack {
                self.content()
            }
            .clipShape(RoundedRectangle(cornerRadius: 20))
        }
    }
}


struct Battery: View {
    @ObservedObject var state: DriverStationState = .shared
    @ObservedObject var dev: DeveloperOptions = .shared
    @State var style = ChartStyle(backgroundColor: .clear, foregroundColor: [ColorGradient(.clear, Color.teamColor)])
    
    var body: some View {
        
        
        ZStack {
            LineChart()
                .data(state.batteryState.voltages)
                .chartStyle(ChartStyle(backgroundColor: .clear, foregroundColor: [ColorGradient(.clear, Color.teamColor)]))
                .allowsHitTesting(/*@START_MENU_TOKEN@*/false/*@END_MENU_TOKEN@*/)
                .foregroundColor(Color(UIColor.secondarySystemBackground))
                .background(Color(UIColor.secondarySystemBackground))
                .clipShape(
                    RoundedRectangle(cornerRadius: 15, style: .circular)
                )
                .onTapGesture(count: /*@START_MENU_TOKEN@*/1/*@END_MENU_TOKEN@*/, perform: {
                    if dev.isOn && dev.graphExtraModes {
                        state.batteryState.mode = state.batteryState.mode.next()
                    }
            })
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            
            VStack(alignment: .trailing) {
                Text("Battery")
                    .bold()
                    .font(.title3)
                    .foregroundColor(.primary)
                
                Text(String(format: "%.1fV", state.batteryVoltage))
                    .bold()
                    .font(Font.system(.body, design: .monospaced))
//                    .font(.title3)
                    .foregroundColor(.primary)
                    .frame(alignment: .trailing)
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
            .padding()
            
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        
    }
}
