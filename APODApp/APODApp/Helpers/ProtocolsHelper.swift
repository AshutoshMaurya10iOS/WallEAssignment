//
//  ProtocolsHelper.swift
//  APODApp
//
//  Created by Ashutosh Maurya on 08/09/24.
//

import Foundation

// Protocol for fetching data (abstraction for service layer)
protocol APODFetching {
	func fetchAPOD(completion: @escaping (Result<APODResponse, Error>) -> Void)
}


// Protocol for caching (abstraction fro caching mechanism)
protocol APODCaching {
	func cacheAPOD(_ apod: APODResponse)
	func retrieveCachedAPOD() -> APODResponse?
}
