//
//  APODViewModel.swift
//  APODApp
//
//  Created by Ashutosh Maurya on 08/09/24.
//

import Foundation
import Combine

class APODViewModel: ObservableObject {
	@Published var apodImageData: Data? = nil
	@Published var title: String = ""
	@Published var explanation: String = ""
	@Published var errorMessage: String = ""
	@Published var state: APODState = .idle
	
	private let apodService: APODFetching
	private let apodCache: APODCache
	var cancellables = Set<AnyCancellable>()
	
	init(apodService: APODFetching, apodCache: APODCache) {
		self.apodService = apodService
		self.apodCache = apodCache
	}
	
	// Fetching APOD data logic
	func fetchAPOD() {
		state = .loading
		
		// Not connected to internet case
		if !isConnectedToInternet() {
			loadCachedAPOD()
			return
		}
		
		apodService.fetchAPOD { [weak self] result in
			DispatchQueue.main.async {
				switch result {
					case .success(let apod):
						self?.handleSuccess(apod: apod)
					case .failure(let error):
						self?.state = .failure("Failed to load the Astronomy Picture of the Day: \(error.localizedDescription)")
				}
			}
		}
	}
	
	private func handleSuccess(apod: APODResponse) {
		self.title = apod.title
		self.explanation = apod.explanation
		self.apodCache.cacheAPOD(apod)
		self.downloadImage(from: apod.url)
		print("Date: \(apod.date)")
		self.state = .success
	}
	
	// Download image
	private func downloadImage(from url: String) {
		guard let imageURL = URL(string: url) else { return }
		URLSession.shared.dataTask(with: imageURL) { [weak self] data, _, _ in
			DispatchQueue.main.async {
				self?.apodImageData = data
				self?.state = .success
			}
		}.resume()
	}
	
	// Load cached APOD
	private func loadCachedAPOD() {
		if let cachedAPOD = apodCache.retrieveCachedAPOD() {
			self.title = cachedAPOD.title
			self.explanation = cachedAPOD.explanation
			self.downloadImage(from: cachedAPOD.url)
			
			let lastAPODDate = cachedAPOD.date
			if lastAPODDate == getCurrentDate() {
				state = .failure("")
			} else {
				state = .failure("We are not connected to the internet, showing you the last image we have")
			}
		} else {
			state = .failure("No Internet Connection!")
		}
	}
	
	// Check internet connectivity
	private func isConnectedToInternet() -> Bool {
		if NetworkMonitor.shared.isConnected {
			return true
		} else {
			return false
		}
	}
	
	func getCurrentDate() -> String {
		let dateFormatter = DateFormatter()
		dateFormatter.dateFormat = "yyyy-MM-dd"
		return dateFormatter.string(from: Date())
	}
}

enum APODState {
	case idle
	case loading
	case success
	case failure(String)
}
