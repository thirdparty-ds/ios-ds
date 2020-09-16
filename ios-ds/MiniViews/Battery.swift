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


struct BatteryInfo: View {
    @ObservedObject var state: DriverStationState = .shared
    @State var chartData: [Double] = [0, 5, 6, 2, 13, 4, 3, 6]
    
    let blueStyle = ChartStyle(backgroundColor: .black,
                               foregroundColor: [ColorGradient(.clear, .blue)])
    
    var body: some View {
        
        CustomCardView(showShadow: true) {
            ChartLabel("Battery Voltage", type: .custom(size: 18, padding: .init(top: 16, leading: 16, bottom: 0, trailing: 16), color: .primary))
                .foregroundColor(Color(UIColor.secondarySystemBackground))
                .background(Color(UIColor.secondarySystemBackground))
            
            LineChart()
                .foregroundColor(Color(UIColor.secondarySystemBackground))
                .background(Color(UIColor.secondarySystemBackground))
        }
        .data(chartData)
        .chartStyle(blueStyle)
        .padding()
    }
}
