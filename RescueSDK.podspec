Pod::Spec.new do |s|
  s.name         = "RescueSDK"
  s.version      = "1.0.1"
  s.summary      = "LogMeIn Rescue SDK for iOS."
  s.description  = <<-DESC
  The Rescue In-App Support iOS SDK allows your customers to establish a Rescue support session within your app.  
                   DESC
  s.homepage     = "https://www.logmeinrescue.com/"
  s.license      = { :type => 'Custom', :file => 'LICENSE' }
  s.author       = "LogMeIn Inc."
  s.platform     = :ios, "7.0"
  s.source       = { :git => "https://github.com/LogmeinRescue/iOS-SDK.git", :tag => s.version.to_s }
  s.source_files  = "SDK/include/*.h"
  s.vendored_libraries = 'SDK/lib/fat/libRescueLib.a'
  s.public_header_files = "SDK/include/*.h"
  s.resource  = "SDK/lib/LocalisationBundle.bundle"

  s.prepare_command = <<-CMD
  mkdir -p SDK/lib/fat
  libtool -static SDK/lib/arm/libRescueLib.a SDK/lib/i386/libRescueLib.a -o SDK/lib/fat/libRescueLib.a
                      CMD


  s.frameworks = "CFNetwork", "CoreBluetooth", "CoreTelephony", "SystemConfiguration"
  s.libraries = "resolv", "z", "c++"
  s.requires_arc = true
  s.pod_target_xcconfig = { "OTHER_LDFLAGS" => "-ObjC" }
end
