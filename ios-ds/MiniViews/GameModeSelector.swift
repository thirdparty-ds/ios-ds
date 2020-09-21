//
//  GameModeSelector.swift
//  ios-ds
//
//  Created by Vasista Vovveti on 9/15/20.
//

import SwiftUI
import Introspect

struct GameModeSelector: View {
    @ObservedObject var state: DriverStationState = .shared
    var body: some View {
        Picker(selection: $state.gameMode, label: /*@START_MENU_TOKEN@*/Text("Picker")/*@END_MENU_TOKEN@*/) {
            Text("TeleOperated").tag(GameMode.Teleoperated)
            Text("Autonomous").tag(GameMode.Autonomous)
            Text("Test").tag(GameMode.Test)
        }.pickerStyle(SegmentedPickerStyle())
        .introspectSegmentedControl{ segmentedControl in
            segmentedControl.setTitleTextAttributes([NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 14)], for: UIControl.State.selected)
            segmentedControl.setTitleTextAttributes([NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 14)], for: UIControl.State.normal)
        }
    }
}

