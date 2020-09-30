//
//  ContentView.swift
//  ios-ds
//
//  Created by Prateek Machiraju on 8/22/20.
//

import SwiftUI

struct ContentView: View {
    @Environment(\.verticalSizeClass) var verticalSizeClass: UserInterfaceSizeClass?
    @Environment(\.horizontalSizeClass) var horizontalSizeClass: UserInterfaceSizeClass?
    @ObservedObject var dev: DeveloperOptions = .shared
    var body: some View {
        TabView {
            OperationView()
                .tabItem {
                    Text("Operation")
                }
            
            if !(verticalSizeClass == .regular && horizontalSizeClass == .regular) {
                RioLogView()
                    .tabItem {
                        Text("RioLog")
                    }
            }
            
            if dev.isOn {
                DeveloperView()
                    .tabItem {
                        Text("Developer")
                    }
            }
            
            
//            DiagnosticsView()
//            SetupView()
//            ControllersView()
//            PowerView()
        }
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
