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

```

~~**Important:** don't forget to add both pod sources to top of your `Podfile`!~~

**UPDATE:** our pod has been moved to the official CocoaPods pod source. Please remove the LogmeinRescue `source` from your `Podfile`.

### Manually

Download the [latest release](https://github.com/LogmeinRescue/iOS-SDK/releases/latest) and follow the [guide](http://secure.logmeinrescue.com/welcome/webhelp/EN/SDKi/MobileSDK/c_riossdk_overview.html) on our website.
