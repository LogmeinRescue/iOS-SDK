Pod::Spec.new do |s|
  s.name         = "RescueSDK"
  s.version      = "5.8"
  s.summary      = "LogMeIn Rescue SDK for iOS."
  s.description  = <<-DESC
  The Rescue In-App Support iOS SDK allows your customers to establish a Rescue support session within your app.  
                   DESC
  s.homepage     = "https://www.logmeinrescue.com/"
  s.license      = { :type => 'Custom', :file => 'LICENSE' }
  s.author       = "LogMeIn Inc."
  s.platform     = :ios, "11.0"
  s.source       = { :http => "https://github.com/LogmeinRescue/iOS-SDK/releases/download/" + s.version.to_s + "/rescue-ios-sdk-" + s.version.to_s + "-frameworks.zip" }
  s.user_target_xcconfig = { "EMBEDDED_CONTENT_CONTAINS_SWIFT" => "YES", "CLANG_MODULES_AUTOLINK" => "YES" }
  s.documentation_url    = "https://secure.logmeinrescue.com/welcome/webhelp/EN/SDKi/MobileSDK/c_riossdk_overview.html"
  s.default_subspec = "Core"

  s.subspec 'Core' do |core|
    core.vendored_frameworks = "Frameworks/RescueCore.xcframework"
  end

  s.subspec 'LMICoreMedia' do |core_media|
    core_media.vendored_frameworks = "Frameworks/LMICoreMedia.framework"
    core_media.dependency "RescueSDK/Core"
  end

  s.subspec 'Broadcast' do |broadcast|
    broadcast.vendored_frameworks = "Frameworks/RescueBroadcast.xcframework"
  end

end
