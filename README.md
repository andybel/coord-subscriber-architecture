This app is an example of Coordinator and ViewModel patterns to demonstrate a simple UI of two screens loading data from the network.

# Coordinators

Coordinators are used in this app to handle all navigation logic between the viewcontrollers. Coordinators are responsible for creating their ViewControllers and corresponding ViewModels and Service classes (if required). 

The pattern used here are explained n these videos by Paul Hudson:
* https://www.youtube.com/watch?v=7HgbcTqxoN4
* https://www.youtube.com/watch?v=ueByb0MBMQ4


# ViewModels

ViewModels are used to keep business logic out of the ViewControllers. ViewControllers can only access their ViewModels as protocols (to enable easy mocking). Binding is kept very simple in this example, and is facilitated by means of an updateCallback closure that the ViewController can subscribe to in order to be informed every time it's ViewModel decides there are changes requiring ui updates (or display of errror messages).



# Service Protocols

Just as ViewControllers have buiiness logic handled by their ViewModel protocols, the ViewModels themselves have network logic handled by Service protocols.


# Networking

The core networking functionality is handled by 1 protocol/class setup called CoreApi to allow easy mocking for tests.

See John Sundells post on this approach:
* https://www.swiftbysundell.com/posts/testing-swift-code-that-uses-system-singletons-in-3-easy-steps

The formation of urls for CoreApi requests are handled via a conveince enum type - CoreAPiUrl. 

CoreAPiUrl has an extension allowing easy mocking of api responses form local json files.

All models are structs and use the Codable protocol to map from incoming api data. 

Service protocol methods that return responses from the api do so via a Result<T> type:

```swift
public enum Result<Value> {
    case success(Value)
    case failure(Error)
}
```

The return will always  be either an expected return type OR an error.

# Error Handling

Error handling is defined by a custom type with a localized errorDescription accessor.



# Storyboarded Protocol

ViewControllers use the instatiate() protocol extension method when being creating by corodinators. 

To facilitate this the Storyboard file needs to share the same name as the VC file (minus the "ViewController" part) and the StoryboardId parameter needs to be set to the same name as the VC.



