
PROJ_PATH="Demo/RZDebugMenuDemo.xcodeproj"
BUILD_SCHEME="RZDebugMenuDemo"

#
# Install
#

task :install do
  sh("brew update") rescue nil
  sh("brew upgrade xctool") rescue nil
end

#
# Test
#

task :build do
  sh("xctool -project '#{PROJ_PATH}' -scheme '#{BUILD_SCHEME}' -sdk iphonesimulator clean build") rescue nil
  exit $?.exitstatus
end

#
# Clean
#

task :clean do
  sh("xctool -project '#{PROJ_PATH}' -scheme '#{BUILD_SCHEME}' -sdk iphonesimulator clean") rescue nil
end

#
# Utils
#

task :sync do
  sync_project(PROJ_PATH, '--exclusion /Classes')
end

#
# Default
#

task :default => 'build'

#
# Private
#

private

def sync_project(path, flags)
  sh("synx #{flags} '#{path}'")
end
