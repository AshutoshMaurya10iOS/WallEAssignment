//
//  ViewController.swift
//  APODApp
//
//  Created by Ashutosh Maurya on 08/09/24.
//

import UIKit
import Combine

class ViewController: UIViewController {
	
	private let viewModel: APODViewModel
	private let apodView = APODView()
	private var cancellables = Set<AnyCancellable>()
	
	// Dependency injection for View Model
	init(viewModel: APODViewModel) {
		self.viewModel = viewModel
		super.init(nibName: nil, bundle: nil)
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	override func viewDidLoad() {
		super.viewDidLoad()
		// Do any additional setup after loading the view.
		setupView()
		bindViewModel()
		fetchAPODData()
	}
	
	private func setupView() {
		view.backgroundColor = .white
		apodView.translatesAutoresizingMaskIntoConstraints = false
		view.addSubview(apodView)
		
		NSLayoutConstraint.activate([
			apodView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
			apodView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
			apodView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
			apodView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
		])
	}
	
	private func bindViewModel() {
		viewModel.$state.sink { [weak self] state in
			DispatchQueue.main.async {
				switch state {
					case .idle:
						break
					case .loading:
						self?.apodView.showLoading()
					case .success:
						if let imageData = self?.viewModel.apodImageData,
						   let image = UIImage(data: imageData) {
							self?.apodView.showAPOD(image: image, title: self?.viewModel.title ?? "", explanation: self?.viewModel.explanation ?? "")
						}
					case .failure(let message):
						self?.apodView.showError(message)
				}
			}
		}.store(in: &cancellables)
	}
	
	private func fetchAPODData() {
		viewModel.fetchAPOD()
	}
	
}

