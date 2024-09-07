//
//  APODCache.swift
//  APODApp
//
//  Created by Ashutosh Maurya on 08/09/24.
//

import Foundation

class APODCache: APODCaching {
	private let cacheKey = "CachedAPOD"
	
	static let shared = APODCache()
	
	private init() { }
	
	func cacheAPOD(_ apod: APODResponse) {
		if let data = try? JSONEncoder().encode(apod) {
			UserDefaults.standard.setValue(data, forKey: cacheKey)
		}
	}
	
	func retrieveCachedAPOD() -> APODResponse? {
		if let data = UserDefaults.standard.data(forKey: cacheKey),
		   let cachedAPOD = try? JSONDecoder().decode(APODResponse.self, from: data) {
			return cachedAPOD
		}
		return nil
	}
	
	func retrieveCachedPODDate() -> String? {
		if let data = UserDefaults.standard.data(forKey: cacheKey),
		   let cachedAPOD = try? JSONDecoder().decode(APODResponse.self, from: data) {
			return cachedAPOD.date
		}
		return nil
	}
}
