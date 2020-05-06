#
#  Be sure to run `pod spec lint JonHomeiOSCore.podspec.podspec' to ensure this is a
#  valid spec and to remove all comments including this before submitting the spec.
#
#  To learn more about Podspec attributes see https://guides.cocoapods.org/syntax/podspec.html
#  To see working Podspecs in the CocoaPods repo see https://github.com/CocoaPods/Specs/
#

Pod::Spec.new do |spec|

  spec.name         = "JonHomeiOSCore.podspec"
  spec.version      = "0.0.1"
  spec.summary      = "Core for Myself"

  # spec.description  = <<-DESC
  #                  DESC

  spec.homepage     = "https://github.com/JonHome/iOSCore"

  spec.license      = "MIT"

  spec.author       = { "JonHome" => "wei3390961@163.com" }

  spec.platform     = :ios, "10.0"

  spec.source       = { :git => "https://github.com/JonHome/iOSCore.git", :tag => "v_#{spec.version}" }

  spec.source_files = "source", "source/**/*.{swift,h,m}"
  
  spec.swift_version = '5.0'
end
