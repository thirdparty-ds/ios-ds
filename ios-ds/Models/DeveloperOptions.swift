//
//  DeveloperOptions.swift
//  ios-ds
//
//  Created by Vasista Vovveti on 9/17/20.
//

import Foundation

class DeveloperOptions: ObservableObject {
    @Published var isOn: Bool
    @Published var graphExtraModes: Bool
    @Published var graphRandomData: Bool
    @Published var showTelemetryJoystick: Bool
    @Published var unhideEnableButton: Bool
    @Published var rioLogRandomData: Bool
    
    
    init() {
        isOn = false
        graphExtraModes = false
        graphRandomData = false
        showTelemetryJoystick = false
        unhideEnableButton = false
        rioLogRandomData = false
    }
    
    static let shared = DeveloperOptions()
}
