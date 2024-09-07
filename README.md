# Astronomy Picture of the Day(APOD) App

This is an iOS app that displays NASA's Astronomy Picture of the Day(APOD) along with its title and explanation. The app fetches the image and detatils from NASA's public API, caches the data for offline viewing, and handles network connectivity issues. It is build using MVVM architecture with SOLID principles and leverages Combine for state management.

## Table of Contents
- [Features](#features)
- [Installation](#installation)
- [Usage](#usage)
- [Architecture](#architecture)
- [Technologies Used](#technologies-used)
- [Improvements](#improvements)
- [API Information](#api-information)
- [Screenshots](#screenshots)

## Features
- Fetches the Astronomy Picture of the Day from NASA's APOD API.
- Caches the data locally for offline access.
- Displays an error message when the internet is not available.
- Automatically shows the last seen image when offline.
- Fully programmatic UI (no Storyboards).
- Supports handling of different states: loading, success, and error.
- Uses a network connectivity monitor to detect internet availability.

## Installation

### The ReachabilitySwift is installed using pod dependency

- Navigate to the root folder where the pod file is present
- run 'pod install' on terminal
- Open workspace file once pod install is done 
- In case of error. Follow these steps:
	1. Open project target in project editor window
	2. Go to Build setting
	3. Search for User Script Sandboxing
	4. Toggle from yes to no
- Run the app again

## Prerequisites

- Xcode 12 or later.
- Swift 5.0 or later.
- macOS with an internet connection.

## Steps

1. Clone the repository:
	'''bash
	git clone https://github.com/yourusername/apod-app.git
	'''

2. Open the project in Xcode:
	'''bash
	cd apod-app
	pod install
	open APODApp.xcworkspace
	'''

3. Replace the NASA API key (optional but recommended):
	- Open APIService.swift.
	- Replace the apiKey variable with your own API key from NASA APOD API.

4. Run the app on your preferred simulator or device:
	- Select your target device/simulator in Xcode.
	- Press Cmd + R to run the app.


## Usage

### Online Mode:
1. Upon launching the app with an internet connection, the Astronomy Picture of the Day is fetched from the NASA API.
2. The image, title, and explanation are displayed on the screen.
3. The data is cached for offline use.

### Offline Mode:
1. If no internet connection is available, the app displays the last fetched image and its information.
2. If no internet connection is available the next day, the app displays the last fetched image and its information from the previous day.
3. If the app has never fetched data before, an error message is displayed indicating no internet connection.


## Architecture

This app follows the MVVM (Model-View-ViewModel) architecture pattern:
- **Model**: The data layer, including API responses and caching mechanisms.
- **ViewModel**: The logic layer that fetches data from the model, processes it, and provides it to the view.
- **View**: The user interface, which renders the image and details from the ViewModel.

### SOLID Principles

- **Single Responsibility Principle (SRP)**: Each class has a well-defined responsibility (e.g., APODService for fetching, APODCache for caching).
- **Open-Closed Principle (OCP)**: The app is easily extensible, allowing you to add new services without modifying existing ones.
- **Liskov Substitution Principle (LSP)**: The services (APODFetching, APODCaching) can be interchanged thanks to the use of protocols.
- **Interface Segregation Principle (ISP)**: Separate protocols for fetching and caching are used.
- **Dependency Inversion Principle (DIP)**: The ViewModel depends on abstractions (APODFetching, APODCaching), making it easy to test and modify.

## Technologies Used

- **Swift 5**: The programming language used to build the app.
- **UIKit**: The UI framework used to programmatically create views and layout.
- **Combine**: Used for handling asynchronous events and state management.
- **Network Framework**: Used for checking internet connectivity with ReachabilitySwift.
- **UserDefaults**: Used for caching the APOD data for offline access.
- **Auto Layout**: All views are laid out programmatically using Auto Layout constraints.


## Improvements

Given the time constraints, here are some improvements that can be made:

1. **Image Caching**: Use a more advanced caching library like Kingfisher or SDWebImage for handling image caching.
2. **Liskov Substitution Principle**: This could be optimized further. Have done the basics of it but can be further enhanced
2. **Unit Testing**: Add unit tests to verify ViewModel logic, network requests, and caching mechanisms.
3. **Localization**: Add support for multiple languages to make the app more accessible.
4. **Error Handling Enhancements**: Improve error handling for different types of failures (e.g., server down, invalid API key).
5. **Accessibility**: Add support for VoiceOver and Dynamic Type to improve accessibility.

## API Information

The app uses NASA’s Astronomy Picture of the Day (APOD) API. You can find more information about the API here.

### Example API Request:

GET https://api.nasa.gov/planetary/apod?api_key=YOUR_API_KEY

### Response Format (JSON):
'''json

{
  "title": "Astronomy Picture of the Day",
  "explanation": "A description of the image.",
  "url": "https://example.com/image.jpg"
}

## Screenshots

### Online Mode
### Offline Mode

### Authors
AshutoshMaurya10iOS – GitHub


