Pod::Spec.new do |s|
  s.name             = 'Primer'
  s.version          = '1.0.0'
  s.summary          = 'Primer will help you to show a nice checkout view controller'
  s.homepage         = 'https://github.com/valentinwallet/Primer'
  s.license          = 'MIT'
  s.author           = { 'Valentin Wallet' => 'valentinwallet@gmail.com' }
  s.source           = { :git => 'https://github.com/valentinwallet/Primer.git', :tag => s.version }
  s.ios.deployment_target = '13.0'
  s.swift_version = '5.0'
  s.source_files = 'Sources/Primer/**/*'
end
