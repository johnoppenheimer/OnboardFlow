# OnboardFlow

[![CI Status](https://img.shields.io/travis/johnoppenheimer/OnboardFlow.svg?style=flat)](https://travis-ci.org/johnoppenheimer/OnboardFlow)
[![Version](https://img.shields.io/cocoapods/v/OnboardFlow.svg?style=flat)](https://cocoapods.org/pods/OnboardFlow)
[![License](https://img.shields.io/cocoapods/l/OnboardFlow.svg?style=flat)](https://cocoapods.org/pods/OnboardFlow)
[![Platform](https://img.shields.io/cocoapods/p/OnboardFlow.svg?style=flat)](https://cocoapods.org/pods/OnboardFlow)

## Example

To run the example project, clone the repo, and run `pod install` from the Example directory first.

## Requirements

## Installation

OnboardFlow is available through [CocoaPods](https://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod 'OnboardFlow'
```

## How to use

### Create the onboarding controller
Don't forget to `import OnboardFlow`, then you can just

```swift
let onboardingController = OnboardFlowViewController()
// Use the previously created ViewController
onboardingController.controllers = [ViewController()]
```
If you want to display dots at the bottom of the onboardingController:
```swift
onboardingController.showPageControl = true // default is false
```
By default the `OnboardFlowViewController` doesn't allow swipe to navigate between pages, but if you want to:
```swift
onboardingController.enableSwipe = true // default is false
```

The `OnboardFlowViewController` also possesses a `onboardingDelegate` that useful to know when onboarding should end:
```swift
onboardingController.onboardingDelegate = self
```

Then you can create an extension on you main controller:
```swift
extension MainViewController: OnboardFlowViewControllerDelegate {
    func finishOnboarding() {
        /**
        This will be called once the last controller call `done`
         */
    }
}
```

And that's it, you can then display that controller however you want.

### Create controller for onboarding step
Each page in the `OnboardFlowViewController` must be an `UIViewController` to which you added the `OnboardFlowCompletableController` protocol and the `delegate` required.

```swift
import UIKit
import OnboardFlow

class ViewController: UIViewController, OnboardFlowCompletableController {
    var completableDelegate: OnboardFlowCompletableControllerDelegate?

    override func viewDidLoad() {
        super.viewDidLoad()
    }
}
```

If you didn't allow swipe, to let the `OnboardFlowViewController` know that you are done with that controller, call the `delegate` `done` method so that the `OnboardFlowViewController` continue:
```swift
self.completableDelegate?.done(controller: self)
```

### Finishing the onboarding flow
Once you reach the end of your flow, make that controller call its `OnboardFlowCompletableControllerDelegate` `done` method.

## Author

johnoppenheimer, maximecattet@gmx.com

## License

OnboardFlow is available under the MIT license. See the LICENSE file for more info.
