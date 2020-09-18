//
//  DeveloperView.swift
//  ios-ds
//
//  Created by Vasista Vovveti on 9/17/20.
//

import SwiftUI

struct DeveloperView: View {
    @ObservedObject var dev: DeveloperOptions = .shared

    var body: some View {
        
        NavigationView {
            List {
                Toggle(isOn: $dev.graphExtraModes) {Text("Graph Extra Modes")}.padding()
                Toggle(isOn: $dev.graphRandomData) {Text("Graph Random Data")}.padding()
                Toggle(isOn: $dev.showTelemetryJoystick) {Text("Show Telemetry Joystick")}.padding()
                Toggle(isOn: $dev.unhideEnableButton) {Text("Unhide Enable Buttons")}.padding()

            }
            .navigationBarTitle("Developer Options")
        }
        .navigationViewStyle(StackNavigationViewStyle())
        

    }
}
