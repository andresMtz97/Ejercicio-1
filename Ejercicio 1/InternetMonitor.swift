//
//  InternetMonitor.swift
//  Ejercicio 1
//
//  Created by DISMOV on 14/06/24.
//

import Foundation
import Network

class InternetMonitor: ObservableObject {
    private let networkMonitor = NWPathMonitor()
    private let monitorQueue = DispatchQueue(label: "Monitor")
    @Published var isConnected = false
    @Published var connType = "no"
    
    init() {
        networkMonitor.pathUpdateHandler = { path in
            self.isConnected = path.status == .satisfied
            self.connType = path.usesInterfaceType(.wifi) ? "Wifi" : "Datos celulares"
        }
        
        networkMonitor.start(queue: monitorQueue)
    }
}
