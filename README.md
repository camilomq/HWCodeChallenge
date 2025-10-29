# HWCodeChallenge (iOS)

This is the implementation of the iOS Code Challenge.

## Description

The app displays a list of photos obtained from Flickr API; user can select any photo in the list to navigate to a details screen. 
The UI is implemented using SwiftUI, and MVVM is used as the architectural pattern. The codebase features extensive usage of protocols, generics and Swift structured concurrency.
No third-party SDK or framework is being used, so no external dependencies need to be installed.

## Getting Started

### Prerequisites

* Xcode 16.4 (Xcode 26.0.1 can be used, however I encountered a bug that prevented me from running the unit tests without crashing)
* Flickr API key (provided separately)

### Installing

* Clone this repo to your local machine
* Open `HWCodeChallenge.xcodeproj` on Xcode

### Environment setup

* Go to `HWCodeChallenge/Secrets.swift` file
* Copy/paste the provided Flickr API key

## Running the app

* In Xcode, select Product > Run to run the app (or type `CMD+R`)
* Optionally, select Product > Test to run the unit tests (or type `CMD+U`)

## Software Architecture

As mentioned before, MVVM is used as the architectural pattern. Every component in the UI (the list, each row, and the detail view) is implemented using a view that is bound to a view model. 

Each view file contains the protocol declaration for its view model so only the required properties and capabilities
from the view perspective are included. One of the advantages of this approach is the freedom to define simple view models that can be injected to the view so
it can be quickly tested on the Canvas (via a Preview). 

The view model file contains the implementation of the corresponding protocol, and also defines the protocol
for the model entity that holds the required data. In order to avoid excesive (even redundant) files, no _model_ files were included; instead, the data object
that is built from the remote API response also conforms to the model as needed.

The app assembly folder contains the files with the entry point to inject the view model and its dependencies.

As you'll see, only two entities contain specifics about Flickr API: a remote service subclass and a decodable DTO (model); the rest of the system is completely generic.
In order to extend the functionality to work with other API providers, simply define a new remote service (it contains the url and provides an opportunity to tweak
decoding logic), and a decodable DTO that conforms to the model protocol that the list can interact with. Then, inject the new dependencies to the view model in app
assembly layer.

## Implementation details

* SwiftUI for views
* View models conform to `ObservableObject`
* Swift structured concurrency for asynchronous operations
* Image caching using `Actor` to prevent threading issues and data races.
* Error handling
