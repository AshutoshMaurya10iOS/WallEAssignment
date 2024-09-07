//
//  ConfigurationHelper.swift
//  APODApp
//
//  Created by Ashutosh Maurya on 08/09/24.
//

import Foundation

class ConfigurationHelper {
	static func value(for key: String) -> String {
		guard let url = Bundle.main.url(forResource: "APIConfig", withExtension: "plist"),
			  let data = try? Data(contentsOf: url) else {
			fatalError("Config file not found")
		}
		
		do {
			let plist = try PropertyListSerialization.propertyList(from: data, format: nil) as? [String: Any]
			guard let value = plist?[key] as? String else {
				fatalError("\(key) not found in the config file")
			}
			return value
		} catch {
			fatalError("Failed to load config file: \(error.localizedDescription)")
		}
	}
}
