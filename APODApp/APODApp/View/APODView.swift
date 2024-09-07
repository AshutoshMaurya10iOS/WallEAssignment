//
//  APODView.swift
//  APODApp
//
//  Created by Ashutosh Maurya on 08/09/24.
//

import Foundation
import UIKit

class APODView: UIView {
	private let imageView = UIImageView()
	private let titleLabel = UILabel()
	private let explanationLabel = UILabel()
	private let activityIndicator = UIActivityIndicatorView(style: .large)
	private let errorLable = UILabel()
	
	override init(frame: CGRect) {
		super.init(frame: frame)
		setupViews()
	}
	
	required init?(coder: NSCoder) {
		super.init(coder: coder)
		setupViews()
	}
	
	private func setupViews() {
		// Setup ImageView
		imageView.contentMode = .scaleAspectFit
		imageView.translatesAutoresizingMaskIntoConstraints = false
		addSubview(imageView)
		
		// Setup titleLabel
		titleLabel.font = UIFont.boldSystemFont(ofSize: 24)
		titleLabel.textColor = .black
		titleLabel.textAlignment = .center
		titleLabel.numberOfLines = 0
		titleLabel.translatesAutoresizingMaskIntoConstraints = false
		addSubview(titleLabel)
		
		// Setup explanationLabel
		explanationLabel.font = UIFont.systemFont(ofSize: 16)
		explanationLabel.textColor = .black
		explanationLabel.textAlignment = .center
		explanationLabel.numberOfLines = 0
		explanationLabel.translatesAutoresizingMaskIntoConstraints = false
		addSubview(explanationLabel)
		
		// Setup activity Indicator
		activityIndicator.translatesAutoresizingMaskIntoConstraints = false
		addSubview(activityIndicator)
		
		// Setup errorLabel
		errorLable.textColor = .red
		errorLable.textAlignment = .center
		errorLable.numberOfLines = 0
		errorLable.translatesAutoresizingMaskIntoConstraints = false
		addSubview(errorLable)
		
		setupConstraints()
	}
	
	private func setupConstraints() {
		NSLayoutConstraint.activate([
			imageView.topAnchor.constraint(equalTo: topAnchor, constant: 20),
			imageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
			imageView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
			imageView.heightAnchor.constraint(equalToConstant: 200),
			
			titleLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor),
			titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
			titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
			
			explanationLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor),
			explanationLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
			explanationLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
			
			activityIndicator.centerXAnchor.constraint(equalTo: centerXAnchor),
			activityIndicator.centerYAnchor.constraint(equalTo: centerYAnchor),
			
			errorLable.topAnchor.constraint(equalTo: explanationLabel.bottomAnchor),
			errorLable.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -16),
			errorLable.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
			errorLable.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
		])
	}
	
	func showLoading() {
		imageView.isHidden = true
		titleLabel.isHidden = true
		explanationLabel.isHidden = true
		errorLable.isHidden = true
		activityIndicator.startAnimating()
		activityIndicator.isHidden = false
	}
	
	func showError(_ message: String) {
		imageView.isHidden = true
		titleLabel.isHidden = true
		explanationLabel.isHidden = true
		activityIndicator.stopAnimating()
		activityIndicator.isHidden = true
		errorLable.isHidden = false
		errorLable.text = message
	}
	
	func showAPOD(image: UIImage, title: String, explanation: String) {
		imageView.image = image
		titleLabel.text = title
		explanationLabel.text = explanation
		
		imageView.isHidden = false
		titleLabel.isHidden = false
		explanationLabel.isHidden = false
		activityIndicator.stopAnimating()
		activityIndicator.isHidden = true
		errorLable.isHidden = false
	}
}
