//
//  GameModeSelector.swift
//  ios-ds
//
//  Created by Vasista Vovveti on 9/15/20.
//

import SwiftUI

struct GameModeSelector: View {
    @ObservedObject var state: DriverStationState = .shared
    var body: some View {
        Picker(selection: $state.gameMode, label: /*@START_MENU_TOKEN@*/Text("Picker")/*@END_MENU_TOKEN@*/) {
            Text("TeleOperated").tag(GameMode.Teleoperated)
            Text("Autonomous").tag(GameMode.Autonomous)
            Text("Test").tag(GameMode.Test)
        }.pickerStyle(SegmentedPickerStyle())
//        .padding()
    }
}

