//
//  Color+Extension.swift
//  ios-ds
//
//  Created by Vasista Vovveti on 9/16/20.
//

import Foundation
import SwiftUI

extension Color {
    
    private static let teamColors: [UInt32: Color] = [
        0: .red,
        365: .green,
        4096: .orange,
    ]
    
    static var teamColor: Color {
        get {
            teamColors[DriverStationState.shared.teamNumber] ?? .blue
        }
    }
}
