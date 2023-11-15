Pod::Spec.new do |s|
  s.name         = "RescueSDK"
  s.version      = "5.17"
  s.summary      = "LogMeIn Rescue SDK for iOS."
  s.description  = <<-DESC
  The Rescue In-App Support iOS SDK allows your customers to establish a Rescue support session within your app.  
                   DESC
  s.homepage     = "https://www.logmeinrescue.com/"
  s.license      = { :type => 'Custom', :file => 'LICENSE' }
  s.author       = "LogMeIn Inc."
  s.platform     = :ios, "15.0"
  s.source       = { :http => "https://github.com/LogmeinRescue/iOS-SDK/releases/download/" + s.version.to_s + "/rescue-ios-sdk-" + s.version.to_s + "-frameworks.zip",
                     :sha256 => "e019711b5ff2d99f54c9428de428d99f0e4dc00eabcc0fc791b5418072fdce1e" }
  s.pod_target_xcconfig = { "EXCLUDED_ARCHS[sdk=iphonesimulator*]" => "arm64" }
  s.user_target_xcconfig = { "EMBEDDED_CONTENT_CONTAINS_SWIFT" => "YES", "CLANG_MODULES_AUTOLINK" => "YES", "EXCLUDED_ARCHS[sdk=iphonesimulator*]" => "arm64" }
  s.documentation_url    = "https://secure.logmeinrescue.com/welcome/webhelp/EN/SDKi/MobileSDK/c_riossdk_overview.html"
  s.default_subspec = "Core"

  s.subspec 'Core' do |core|
    core.vendored_frameworks = "Frameworks/RescueCore.xcframework"
  end

  s.subspec 'LMICoreMedia' do |core_media|
    core_media.vendored_frameworks = "Frameworks/LMICoreMedia.xcframework"
    core_media.dependency "RescueSDK/Core"
  end

  s.subspec 'Broadcast' do |broadcast|
    broadcast.vendored_frameworks = "Frameworks/RescueBroadcast.xcframework"
  end

end
