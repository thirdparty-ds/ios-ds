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
    
    private var _isEnabled: Bool = false
    
    var isEnabled: Bool {
        get {
            _isEnabled
        }
        set(enable){
            if enable && isCodeAlive && isConnected && !isEstopped {
                print("[user] Enable")
                ds.enable()
            } else {
                print("[user] Disable")
                ds.disable()
            }
        }
    }
    
    private var _isEstopped: Bool = false
    
    var isEstopped: Bool {
        get {
            _isEstopped
        }
        set(estop){
            if estop {
                print("[user] Estop!")
                ds.estop()
            }
        }
    }
    
    private var _isCodeAlive: Bool = false
    
    var isCodeAlive: Bool {
        get {
            _isCodeAlive
        }
    }
    
    private var _isConnected: Bool = false
    
    var isConnected: Bool {
        get {
            _isConnected
        }
    }
    
    private var _batteryVoltage: Float = 0
    
    var batteryVoltage: Float {
        get {
            _batteryVoltage
        }
    }
    
    private var _teamNumber: UInt32 = UInt32(UserDefaults.standard.integer(forKey: "teamNumber"))
    
    var teamNumber: UInt32 {
        get {
            _teamNumber
        }
        set(team) {
            print("[user] Update team to \(team)")
            ds.setTeamNumber(team: team)
            _teamNumber = team
            UserDefaults.standard.set(Int(_teamNumber), forKey: "teamNumber")
        }
    }
    
    private var _dsMode: DSMode = DSMode.Real
    
    var dsMode: DSMode {
        get {
            _dsMode
        }
    }
    
    private var _gameMode: GameMode = GameMode.Teleoperated
    
    var gameMode: GameMode {
        get {
            _gameMode
        }
        set(gm) {
            print("[user] Update gamemode to \(gm)")
            ds.setGameMode(mode: gm)
        }
    }
    
    private var _alliance: Alliance = Alliance.Blue
    
    var alliance: Alliance {
        get {
            _alliance
        }
        set(al) {
            print("[user] Update alliance to \(al)")
            ds.setAlliance(alliance: al)
        }
    }
    
    
    private init() {
        ds = DriverStation()
        
        // Push defaults after DS is initialized
        isEnabled = false
        isEstopped = false
        teamNumber = UInt32(UserDefaults.standard.integer(forKey: "teamNumber"))
        gameMode = GameMode.Teleoperated
        alliance = Alliance.Blue
        
        // Delay sync until after initial push
        timer = Timer.scheduledTimer(timeInterval: 0.02, target: self, selector: #selector(sync), userInfo: nil, repeats: true)
    }
    
    deinit {
        timer?.invalidate()
    }
    
    static let shared = DriverStationState()
    
    @objc func sync() {
        var hasSynced = false
        
        // READ & WRITE
        
        if _isEnabled != ds.isEnabled() {
            _isEnabled = ds.isEnabled()
            hasSynced = true
        }
        
        if _teamNumber != ds.getTeamNumber() {
            _teamNumber = ds.getTeamNumber()
            hasSynced = true
        }
        
        if (_gameMode != ds.getGameMode()){
            _gameMode = ds.getGameMode()
            hasSynced = true
        }
        
        if _isEstopped != ds.isEstopped() {
            _isEstopped = ds.isEstopped()
            hasSynced = true
        }
        
        // READ ONLY
        
        if _isCodeAlive != ds.isCodeAlive() {
            _isCodeAlive = ds.isCodeAlive()
            hasSynced = true
        }
        
        if _isConnected != ds.isConnected() {
            _isConnected = ds.isConnected()
            hasSynced = true
        }
        
        if _batteryVoltage != ds.getBatteryVoltage() {
            _batteryVoltage = ds.getBatteryVoltage()
            hasSynced = true
        }
        
        if _dsMode != ds.getDSMode() {
            _dsMode = ds.getDSMode()
            hasSynced = true
        }
        
        // CUSTOM LOGIC
        if !_isConnected || _isEstopped || !_isCodeAlive && _isEnabled {
            ds.disable()
        }
        
        if hasSynced {
            objectWillChange.send()
        }
    }
}
