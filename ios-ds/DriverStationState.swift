//
//  DriverStationState.swift
//  ios-ds
//
//  Created by Vasista Vovveti on 9/14/20.
//

// https://medium.com/better-programming/the-best-way-to-use-environment-objects-in-swiftui-d9a88b1e253f

import Foundation

class DriverStationState: ObservableObject {
    
    let ds: DriverStation
    var timer: Timer?
    
    @Published var isEnabled: Bool = false
    @Published var isEstopped: Bool = false // read only
    @Published var isCodeAlive: Bool = false // read only
    @Published var isConnected: Bool = false // read only
    @Published var batteryVoltage: Float = 0
    @Published var teamNumber: UInt32 = 4096
    @Published var dsMode: DSMode = DSMode.Real
    @Published var gameMode: GameMode = GameMode.Teleoperated
    @Published var alliance: Alliance = Alliance.Blue
    
    private init() {
        ds = DriverStation()
        timer = Timer.scheduledTimer(timeInterval: 0.02, target: self, selector: #selector(sync), userInfo: nil, repeats: true)
    }
    
    deinit {
        timer?.invalidate()
    }
    
    static let shared = DriverStationState()
    
    @objc func sync() {
        // READ & WRITE
        if isEnabled != ds.isEnabled() {
            if !isEnabled {
                ds.disable()
            } else if isEnabled && isCodeAlive && isConnected && !isEstopped {
                ds.enable()
            }
            
            isEnabled = ds.isEnabled()
        }
        
        if teamNumber != ds.getTeamNumber() {
            ds.setTeamNumber(team: teamNumber)
            teamNumber = ds.getTeamNumber()
        }
        
        if (gameMode != ds.getGameMode()){
            ds.setGameMode(mode: gameMode)
            gameMode = ds.getGameMode()
        }
        
        // READ ONLY
        
        if isEstopped != ds.isEstopped() {
            isEstopped = ds.isEstopped()
        }
        
        if isCodeAlive != ds.isCodeAlive() {
            isCodeAlive = ds.isCodeAlive()
        }
        
        if isConnected != ds.isConnected() {
            isConnected = ds.isConnected()
        }
        
        if batteryVoltage != ds.getBatteryVoltage() {
            batteryVoltage = ds.getBatteryVoltage()
        }
        
        if dsMode != ds.getDSMode() {
            dsMode = ds.getDSMode()
        }
    }
}
