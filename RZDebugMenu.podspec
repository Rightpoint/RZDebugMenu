Pod::Spec.new do |s|
  s.name         = "RZDebugMenu"
  s.version      = "0.2.0"
  s.summary      = "In-app settings bundle using the plist API in XCode"

  s.description  = <<-DESC
                   RZDebugMenu mimics the behavior of a Settings.bundle, but is globally available within your app so you can change whatever setting you'd like at any point.
                   DESC

  s.homepage     = "https://github.com/Raizlabs/RZDebugMenu"
  s.license      = { :type => "MIT" }
  s.author = { "Clayton Rieck" => "cjrieck123@gmail.com", "Nick Donalodson" => "ndonald2@gmail.com", "Michael Gorbach" => "michael.gorbach@raizlabs.com" }
  
  s.platform = :ios, "8.0"
  s.ios.deployment_target = '8.0'
  
  s.source = { :git => "https://github.com/Raizlabs/RZDebugMenu.git", :tag => s.version.to_s }
  
  s.requires_arc = true
  
  s.dependency 'FXForms', '~>1.2'
  
  s.source_files = "Library/Core/Source/**/*.{h,m}", "Library/Core/Public Headers/**/*.{h,m}"
  s.public_header_files = "Library/Core/Public Headers/*.{h,m}"    
  s.private_header_files = "Library/Core/Source/**/*.h"
  
  submodule_names = ["Settings", "Version"]
  submodule_names.each { |sm|
    s.subspec sm do |ss|
      ss.source_files = "Library/Modules/#{sm}/Source/**/*.{h,m}", "Library/Modules/#{sm}/Public Headers/**/*.{h,m}"
      ss.public_header_files = "Library/Modules/#{sm}/Public Headers/**/*.{h,m}"
      ss.private_header_files = "Library/Modules/#{sm}/Source/**/*.h"
    end
  }
end
