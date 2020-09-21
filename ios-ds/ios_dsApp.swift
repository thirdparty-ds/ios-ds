//
//  ios_dsApp.swift
//  ios-ds
//
//  Created by Prateek Machiraju on 8/22/20.
//

import SwiftUI

@main
struct ios_dsApp: App {
    var state: DriverStationState
    
    init() {
        state = DriverStationState.shared
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .onReceive(NotificationCenter.default.publisher(for: .deviceDidShakeNotification)) { _ in
                    self.state.isEstopped = true
                    print("Shake estopped")
                }
                .onReceive(NotificationCenter.default.publisher(for: UIScene.willDeactivateNotification)){ _ in
                    self.state.ds.disable()
                    print("Backgrounded")
                }
        }
    }
}


struct ios_dsApp_Previews: PreviewProvider {
    static var previews: some View {
        /*@START_MENU_TOKEN@*/Text("Hello, World!")/*@END_MENU_TOKEN@*/
    }
}
