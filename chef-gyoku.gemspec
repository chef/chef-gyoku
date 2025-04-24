$:.push File.expand_path("lib", __dir__)
require "chef-gyoku/version"

Gem::Specification.new do |s|
  s.name = "chef-gyoku"
  s.version = Gyoku::VERSION
  s.platform = Gem::Platform::RUBY
  s.authors = "Daniel Harrington"
  s.email = "me@rubiii.com"
  s.homepage = "https://github.com/savonrb/#{s.name}"
  s.summary = "Translates Ruby Hashes to XML"
  s.description = "Gyoku translates Ruby Hashes to XML"
  s.required_ruby_version = ">= 3.0" # setting the Ruby version requirement to 3.0 or higher to be backwards compatible with Inspec v 5.0.0 and AIX

  s.license = "MIT"

  s.add_dependency "builder", ">= 2.1.2"
  s.add_dependency "rexml", "~> 3.4"

  s.add_development_dependency "rake"
  s.add_development_dependency "rspec"
  s.add_development_dependency "standard"
  s.add_development_dependency "fiddle"
  s.add_development_dependency "cookstyle", "~> 8.0"

  s.files = `git ls-files`.split("\n")

  s.require_paths = ["lib"]
end
