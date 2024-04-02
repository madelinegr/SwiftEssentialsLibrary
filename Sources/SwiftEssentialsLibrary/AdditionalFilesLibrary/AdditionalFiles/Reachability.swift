//
//  Reachability.swift
//  twotwotwo-ios
//
//  Created by Adam Novak on 2/20/24.
//

import Network
import Foundation

class Reachability {

    static var shared = Reachability()
    lazy private var monitor = NWPathMonitor()

    var isConnected: Bool {
        return monitor.currentPath.status == .satisfied
    }

    func startNetworkReachabilityObserver() {
        monitor.pathUpdateHandler = { path in
            if path.status == .satisfied {
                NotificationCenter.default.post(name: .init("connectedtointernet"), object: nil)
            } else if path.status == .unsatisfied {
                NotificationCenter.default.post(name: .init("notconnectedtointernet"), object: nil)
            }
        }
        let queue = DispatchQueue.global(qos: .background)
        monitor.start(queue: queue)
    }
}
