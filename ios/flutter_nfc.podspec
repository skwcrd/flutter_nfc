# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html.
# Run `pod lib lint flutter_nfc.podspec` to validate before publishing.
Pod::Spec.new do |s|
  s.name             = 'flutter_nfc'
  s.version          = '1.0.0'
  s.summary          = 'This is flutter plugin for accessing the NFC features on Android and iOS.'
  s.description      = <<-DESC
This is flutter plugin for accessing the NFC features on Android and iOS.
                       DESC
  s.homepage         = 'https://github.com/skwcrd/flutter_nfc'
  s.license          = { :file => '../LICENSE' }
  s.author           = { 'Sukawit Charoendet' => 'sukawit.ch@hotmail.com' }
  s.source           = { :path => '.' }
  s.source_files = 'Classes/**/*'
  s.dependency 'Flutter'
  s.platform = :ios, '11.0'

  # Flutter.framework does not contain a i386 slice.
  # s.pod_target_xcconfig = { 'DEFINES_MODULE' => 'YES', 'VALID_ARCHS[sdk=iphonesimulator*]' => 'x86_64' }
  s.pod_target_xcconfig = { 'DEFINES_MODULE' => 'YES', 'EXCLUDED_ARCHS[sdk=iphonesimulator*]' => 'i386' }
  s.swift_version = '5.0'
end