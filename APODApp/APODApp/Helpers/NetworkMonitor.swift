//
//  NetworkMonitor.swift
//  APODApp
//
//  Created by Ashutosh Maurya on 08/09/24.
//

import Foundation
import Network
import Reachability

class NetworkMonitor {
	static let shared = NetworkMonitor()
	private let reachability = try! Reachability()
	
	var isConnected: Bool {
		return reachability.connection != .unavailable
	}
	
	private init() {
		reachability.whenReachable = { _ in
			DispatchQueue.main.async {
				print("Connected to Internet")
			}
		}
		
		reachability.whenUnreachable = { _ in
			DispatchQueue.main.async {
				print("Not Connected to Internet")
			}
		}
		
		do {
			try reachability.startNotifier()
		} catch {
			print("Unable to start notifier")
		}
	}
	
	func stopMonitoring() {
		reachability.stopNotifier()
	}
	
	deinit {
		stopMonitoring()
	}
}

