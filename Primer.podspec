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
  s.summary          = 'A short description of Primer.'
# TODO: add a description and a summmary
  s.description      = "Put a description here"
  s.homepage         = 'https://github.com/Valentin Wallet/Primer'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'Valentin Wallet' => 'valentinwallet@gmail.com' }
  s.source           = { :git => 'https://github.com/Valentin Wallet/Primer.git', :tag => s.version.to_s }
  s.ios.deployment_target = '12.0'
  s.source_files = 'Primer/Classes/**/*'
end
