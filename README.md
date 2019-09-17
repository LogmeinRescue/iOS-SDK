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
end

target 'YourBroadcastTarget' do
  use_frameworks!
  pod 'RescueSDK/Broadcast'
end

```

**IMPORTANT UPDATE:** Our pod is using git-lfs. Please install git-lfs before install or update this Pod.

### Manually

Check out the [latest release](https://github.com/LogmeinRescue/iOS-SDK/releases/latest) and follow the [guide](http://secure.logmeinrescue.com/welcome/webhelp/EN/SDKi/MobileSDK/c_riossdk_overview.html) on our website.

**IMPORTANT UPDATE:** Our repository is using git-lfs. Please install git-lfs and clone the repository. **Do not** download the zip file, the archive will not contain the LMICoreMedia.framework. 
