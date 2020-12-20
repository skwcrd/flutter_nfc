Pod::Spec.new do |s|
  s.name             = 'flutter_nfc'
  s.version          = '1.0.0'
  s.summary          = 'The flutter plugin for support using NFC features on Android and iOS.'
  s.description      = <<-DESC
The flutter plugin for support using NFC features on Android and iOS.
                       DESC
  s.homepage         = 'https://github.com/skwcrd/flutter_nfc'
  s.license          = { :file => '../LICENSE' }
  s.author           = { 'Sukawit Charoendet' => 'sukawit.ch@hotmail.com' }
  s.source           = { :path => '.' }
  s.source_files = 'Classes/**/*'
  s.dependency 'Flutter'
  s.platform = :ios, '13.0'

  s.pod_target_xcconfig = { 'DEFINES_MODULE' => 'YES', 'EXCLUDED_ARCHS[sdk=iphonesimulator*]' => 'i386' }
  s.swift_version = '5.0'
end