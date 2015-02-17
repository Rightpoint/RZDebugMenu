Pod::Spec.new do |s|
  s.name         = "RZDebugMenu"
  s.version      = "0.1.0"
  s.summary      = "In-app settings bundle using the plist API in XCode"

  s.description  = <<-DESC
                   RZDebugMenu mimics the behavior of a Settings.bundle, but is globally available within your app so you can change whatever setting you'd like at any point.
                   DESC

  s.homepage     = "https://github.com/Raizlabs/RZDebugMenu"
  s.license      = { :type => "MIT" }
  s.author = { "Clayton Rieck" => "cjrieck123@gmail.com", "Nick Donalodson" => "ndonald2@gmail.com", "Michael Gorbach" => "michael.gorbach@raizlabs.com" }
  
  s.platform = :ios, "8.0"
  
  s.source = { :git => "https://github.com/Raizlabs/RZDebugMenu.git", :tag => s.version.to_s }
  s.source_files = "Classes", "Classes/**/*.{h,m}"
  s.exclude_files = "Classes/Exclude"
  
  s.requires_arc = true
end
