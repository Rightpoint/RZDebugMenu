PROJ_PATH="Demo/RZDebugMenuDemo.xcodeproj"
WORKSPACE_PATH="Demo/RZDebugMenuDemo.xcworkspace"
BUILD_SCHEME="RZDebugMenuDemo"

namespace :install do
  task :tools do
    # don't care if this fails on travis
    sh("brew update") rescue nil
    sh("brew upgrade xctool") rescue nil
    sh("gem install cocoapods --no-rdoc --no-ri --no-document --quiet") rescue nil
  end

  task :pods do
    sh("cd Demo && pod install")
  end
end

task :install do
  Rake::Task['install:tools'].invoke
  Rake::Task['install:pods'].invoke
end


#
# Build
#

task :build do		
  sh("xctool -workspace '#{WORKSPACE_PATH}' -scheme '#{BUILD_SCHEME}' -sdk iphonesimulator clean build") rescue nil
end

#
# Clean
#

namespace :clean do
  task :pods do
    sh("rm -f Demo/Podfile.lock")
    sh "rm -rf Demo/Pods"
    sh("rm -rf Demo/*.xcworkspace")
  end
  
  task :demo do
    sh("xctool -project '#{PROJ_PATH}' -scheme '#{TEST_SCHEME}' -sdk iphonesimulator clean") rescue nil
  end
end

task :clean do
  Rake::Task['clean:pods'].invoke
  Rake::Task['clean:demo'].invoke
end

#
# Utils
#

task :usage do
  puts "Usage:"
  puts "  rake install       -- install all dependencies (xctool, cocoapods)"
  puts "  rake install:pods  -- install cocoapods for tests/demo"
  puts "  rake install:tools -- install build tool dependencies"
  puts "  rake clean         -- clean everything"
  puts "  rake clean:demo    -- clean the demo project build artifacts"
  puts "  rake clean:pods    -- clean up cocoapods artifacts"
  puts "  rake sync          -- synchronize project/directory hierarchy (dev only)"
  puts "  rake usage         -- print this message"
end

task :sync do
  sync_project(PROJ_PATH, '--exclusion /Classes')
end

#
# Default
#

task :default => 'usage'

#
# Private
#

private

def sync_project(path, flags)
  sh("synx #{flags} '#{path}'")
end
