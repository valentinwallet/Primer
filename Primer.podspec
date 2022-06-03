#
# Be sure to run `pod lib lint Primer.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'Primer'
  s.version          = '0.1.0'
  s.summary          = 'Light Primer iOS SDK'
  s.description      = <<-DESC
  This library contains the official iOS SDK for Primer. Install this Cocoapod to seemlessly integrate the Primer Checkout & API platform in your app.
  DESC
  s.homepage         = 'https://github.com/Valentin Wallet/Primer'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'Valentin Wallet' => 'valentinwallet@gmail.com' }
  s.source           = { :git => 'https://github.com/Valentin Wallet/Primer.git', :tag => s.version.to_s }
  s.swift_version    = "5.0"
  s.ios.deployment_target = '13.0'
  s.source_files = 'Sources/**/*.swift'
end
