//
//  APODService.swift
//  APODApp
//
//  Created by Ashutosh Maurya on 08/09/24.
//

import Foundation

class APODService: APODFetching {
	private let apiService = APIService()
	
	func fetchAPOD(completion: @escaping (Result<APODResponse, Error>) -> Void) {
		let endPoint = "/planetary/apod"
		apiService.fetchData(endpoint: endPoint, completion: completion)
	}
}
