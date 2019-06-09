//
//  ReachabilityManager.swift
//  MovieApp
//
//  Created by asylzhan on 6/6/19.
//  Copyright © 2019 asylzhan. All rights reserved.
//

import Foundation
import Alamofire

public protocol NetworkStatusListener: class {
  func networkStatusDidChange(status: NetworkReachabilityManager.NetworkReachabilityStatus)
}

class ReachabilityManager: NSObject {
  static let shared = ReachabilityManager()
  var listeners = [NetworkStatusListener]()
  
  let reachability = NetworkReachabilityManager()!
  
  func isReachable() -> Bool {
    return reachability.isReachable
  }
  
  func startMonitoring() {
    reachability.listener = { status in
      switch status {
      case .notReachable:
        debugPrint("not reachable")
      case .reachable(_):
        debugPrint("reachable via")
      case .unknown:
        break
      }
      
      for listener in self.listeners {
        listener.networkStatusDidChange(status: status)
      }
    }
    reachability.startListening()
  }
  
  func stopMonitoring() {
    reachability.stopListening()
  }
  
  func addListener(listener: NetworkStatusListener?) {
    if let listener = listener {
      listeners.append(listener)
    }
  }
  
  func removeListener(listener: NetworkStatusListener) {
    listeners = listeners.filter { $0 !== listener }
  }
  
}
