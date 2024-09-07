//
//  APIService.swift
//  APODApp
//
//  Created by Ashutosh Maurya on 08/09/24.
//

import Foundation

class APIService {
	private let apiKey = "rftoBOAnd04EcN2fssCddHfnfP7FDlicTMg6bfGq"
	
	// Generic API request function
	func fetchData<T: Decodable>(endpoint: String, completion: @escaping (Result<T, Error>) -> Void) {
			// Fetch baseURL from the plist file
		let baseURL = ConfigurationHelper.value(for: "BaseURL")
		
		// TODO: Fetch the API Key securely from keychain
		
		guard let url = URL(string: "\(baseURL)\(endpoint)?api_key=\(apiKey)") else {
			print("Error: Invalid URL")
			completion(.failure(APIError.invalidURL))
			return
		}
		
		URLSession.shared.dataTask(with: url) { data, response, error in
			if let error = error {
				print("Error: \(error)")
				completion(.failure(error))
				return
			}
			
			guard let data = data else {
				print("Error: No Data")
				completion(.failure(APIError.noData))
				return
			}
			
			do {
				let decodedData = try JSONDecoder().decode(T.self, from: data)
				completion(.success(decodedData))
			} catch {
				print("Error: bad response")
				completion(.failure(APIError.badResponse))
			}
		}.resume()
	}
	
	// Define API Errors
	enum APIError: Error {
		case invalidURL
		case missingAPIKey
		case noData
		case badResponse
	}
}
