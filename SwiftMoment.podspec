Pod::Spec.new do |s|

  s.name         = "SwiftMoment"
  s.version      = "0.6"
  s.summary      = "A time and calendar manipulation library for iOS / macOS / tvOS / watchOS written in Swift"
  s.description  = <<-DESC
                    This framework is inspired by Moment.js. Its objectives are the following:

                    * Simplify the manipulation and readability of date and interval values.
                    * Provide help when parsing dates from various string representations.
                    * Simplifying the formatting of date information into strings.
                    * Streamlining getting date components (day, month, etc.) from dates and time intervals.

                    This framework supports iOS 8+, macOS 10.10+, tvOS 9+, watchOS 2+, Xcode 8 and Swift 3.
                   DESC
  s.homepage     = "http://akosma.github.io/SwiftMoment/"
  s.license      = { :type => "BSD", :file => "LICENSE" }
  s.author             = { "Adrian Kosmaczewski" => "akosma@me.com" }
  s.social_media_url   = "http://twitter.com/akosma"
  s.ios.deployment_target = "8.0"
  s.osx.deployment_target = "10.10"
  s.tvos.deployment_target = "9.0"
  s.watchos.deployment_target = "2.0"
  s.source       = { :git => "https://github.com/akosma/SwiftMoment.git", :tag => "v0.5" }
  s.source_files  = "SwiftMoment/SwiftMoment"
  s.resource     = "SwiftMoment/SwiftMoment/MomentFromNow.bundle"
end