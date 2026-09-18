require_relative "lib/chef-gyoku/version"

Gem::Specification.new do |s|
  s.name = "chef-gyoku"
  s.version = Gyoku::VERSION
  s.authors = ["Daniel Harrington"]
  s.email = ["me@rubiii.com"]
  s.homepage = "https://github.com/chef/chef-gyoku"
  s.summary = "Translates Ruby Hashes to XML"
  s.description = "Gyoku translates Ruby Hashes to XML"
  s.license = "MIT"
  s.required_ruby_version = ">= 3.1"

  s.metadata = {
    "bug_tracker_uri" => "https://github.com/chef/chef-gyoku/issues",
    "changelog_uri" => "https://github.com/chef/chef-gyoku/blob/main/CHANGELOG.md",
    "documentation_uri" => "https://github.com/chef/chef-gyoku/blob/main/README.md",
    "source_code_uri" => "https://github.com/chef/chef-gyoku",
  }

  # Ship only what is needed at runtime. The previous `git ls-files` shell-out
  # packaged CI config, editor settings, and the test suite, and failed to
  # build at all outside a git checkout.
  s.files = Dir["lib/**/*.rb"] + %w{CHANGELOG.md MIT-LICENSE README.md}
  s.require_paths = ["lib"]

  s.add_dependency "builder", ">= 2.1.2"
  s.add_dependency "rexml", "~> 3.4"

  s.add_development_dependency "cookstyle", ">= 8.0.0"
  s.add_development_dependency "fiddle"
  s.add_development_dependency "rake"
  s.add_development_dependency "rspec"
  s.add_development_dependency "standard"
end
