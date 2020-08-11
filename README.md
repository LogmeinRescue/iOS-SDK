# Rescue SDK for iOS

**The Rescue In-App Support iOS SDK allows your customers to establish a Rescue support session within your app.**

For further information please visit our website: http://secure.logmeinrescue.com/welcome/webhelp/EN/SDKi/MobileSDK/c_riossdk_overview.html

## Installation

### By CocoaPods

You can use Rescue SDK via [CocoaPods](http://cocoapods.org). Add each modules you'd like to use to your `Podfile`:

#### Podfile

```ruby
target 'YourAppTarget' do
  use_frameworks!
  pod 'RescueSDK/Core'
  pod 'RescueSDK/LMICoreMedia'
  pod 'RescueSDK/Broadcast'
end

target 'YourBroadcastTarget' do
  use_frameworks!
  pod 'RescueSDK/Broadcast'
end

```

**IMPORTANT UPDATE:** Our pod is devlivering XCFrameworks supported from CocoaPods 1.9. Please use latest cocoapod to install or update this Pod.

### Manually

Check out the [latest release](https://github.com/LogmeinRescue/iOS-SDK/releases/latest) and follow the [guide](http://secure.logmeinrescue.com/welcome/webhelp/EN/SDKi/MobileSDK/c_riossdk_overview.html) on our website.


1. Download the zip files (source code and frameworks). 
2. Extract source code.
3. Extract frameworks into the source code folder.

**IMPORTANT UPDATE:** LMICoreMedia framework binary contains simulator architectures. Please add strip-frameworks script to your build steps (like in Camera Example app). 
