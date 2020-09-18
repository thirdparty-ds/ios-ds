//
//  BatteryState.swift
//  ios-ds
//
//  Created by Vasista Vovveti on 9/16/20.
//

import Foundation

enum BatteryMode: CaseIterable {
    case continuous, clear, overwrite

    func next() -> BatteryMode {
        switch self {
        case .continuous:
            return .clear
        case .clear:
            return .overwrite
        case .overwrite:
            return .continuous
        }
    }
}

class BatteryState : ObservableObject {
    private var interval: Double
    private var index: Int = 0
    
    var seconds: Double {
        didSet {
            voltages = Array(repeating: 0, count: Int(seconds / interval))
        }
    }
    var mode: BatteryMode
    var voltages: [Double]

    init(interval: Double, seconds: Double = 5, mode: BatteryMode = .continuous) {
        self.seconds = seconds
        self.interval = interval
        self.mode = mode
        
        voltages = Array(repeating: 0, count: Int(seconds / interval))
    }
    
    func push(_ value: Double){
        switch mode {
        case .continuous:
            index = 0
            voltages.append(value)
            voltages.removeFirst()
        case .clear:
            index += 1
            if index % voltages.count == 0 {
                voltages = Array(repeating: 0, count: Int(seconds / interval))
                index = 0
            }
            voltages[index] = value
        case .overwrite:
            index += 1
            if index % voltages.count == 0 {
                index = 0
            }
            voltages[index] = value
        }
        
        // The graph lib autoscales and doesn't allow for specifying bounds
        // This forces the autoscale's hand
        voltages[0] = 14
        voltages[1] = 0
        
        objectWillChange.send()
    }
    
    func push(_ value: Float){
        push(Double(value))
    }
    
}
