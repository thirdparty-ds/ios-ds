//
//  OperationView.swift
//  ios-ds
//
//  Created by Vasista Vovveti on 9/13/20.
//

import SwiftUI
import Introspect

struct ModeSelector: View {
    @ObservedObject var state: DriverStationState = .shared
    var body: some View {
        Picker(selection: $state.gameMode, label: /*@START_MENU_TOKEN@*/Text("Picker")/*@END_MENU_TOKEN@*/) {
            Text("TeleOperated").tag(GameMode.Teleoperated)
            Text("Autonomous").tag(GameMode.Autonomous)
            Text("Test").tag(GameMode.Test)
        }.pickerStyle(SegmentedPickerStyle())
    }
}

struct EnableDisableButtons: View {
    @ObservedObject var state: DriverStationState = .shared
    @State private var enabled = false
    
    var body: some View {
        Picker(selection: $state.isEnabled, label: /*@START_MENU_TOKEN@*/Text("Picker")/*@END_MENU_TOKEN@*/) {
            Text("Enable").tag(true)
            Text("Disable").tag(false)
        }.onChange(of: state.isEnabled, perform: { value in
            // #TODO set gamemode
            
        }).pickerStyle(SegmentedPickerStyle())
        .introspectSegmentedControl{
            segmentedControl in
            
            
            UIView.transition(with:segmentedControl, duration: 0.25, options: .transitionCrossDissolve, animations: {
                segmentedControl.selectedSegmentTintColor = state.isEnabled ? UIColor.green :  UIColor.red
                segmentedControl.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: (state.isEnabled ? UIColor.black : UIColor.white)], for: UIControl.State.selected)
            },
            completion: nil)
            
        }.frame(minHeight: 400)
        
    }
}


//struct EnableDisableButtons: View {
//    var body: some View {
//        HStack {
//            Button("Enable"){
//
//            }
//            .padding()
//            .frame(maxWidth: .infinity)
//            .background(Color.green)
//            .foregroundColor(.white)
//            .cornerRadius(10)
//
//            Button("Disable"){
//
//            }
//            .padding()
//            .frame(maxWidth: .infinity)
//            .background(Color.red)
//            .foregroundColor(.white)
//            .cornerRadius(10)
//        }
//    }
//}

struct OperationView: View {
    
    //  #TODO get DS instance
    
    var body: some View {
        
        VStack {
            ModeSelector()
            
            EnableDisableButtons().frame(height:400)
            
        }
    }
}

struct OperationView_Previews: PreviewProvider {
    static var previews: some View {
        OperationView()
    }
}
