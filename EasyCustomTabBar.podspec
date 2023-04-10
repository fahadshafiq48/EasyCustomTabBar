#
# Be sure to run `pod lib lint EasyCustomTabBar.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'EasyCustomTabBar'
  s.version          = '1.0.1'
  s.summary          = 'EasyCustomTabBar is a customizable tabbar with different style options.'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
  EasyCustomTabBar is SwiftUI based pod which allows you to create highly customizable tabbar in different styles.
                       DESC

  s.homepage         = 'https://github.com/fahadshafiq48/EasyCustomTabBar'
  s.screenshots     = 'https://raw.githubusercontent.com/fahadshafiq48/EasyCustomTabBar/main/.github/centred.png', 'https://raw.githubusercontent.com/fahadshafiq48/EasyCustomTabBar/main/.github/separate.png', 'https://raw.githubusercontent.com/fahadshafiq48/EasyCustomTabBar/main/.github/simple.png'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'Fahad Shafiq' => 'fahadshafiq48@gmail.com' }
  s.source           = { :git => 'https://github.com/fahadshafiq48/EasyCustomTabBar.git', :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.ios.deployment_target = '14.0'

  s.source_files = 'EasyCustomTabBar/Classes/**/*'
  s.swift_version = '5.0'
  # s.resource_bundles = {
  #   'EasyCustomTabBar' => ['EasyCustomTabBar/Assets/*.png']
  # }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'
  # s.dependency 'AFNetworking', '~> 2.3'
end
