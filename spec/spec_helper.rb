require "bundler"
Bundler.setup(:default, :development)

unless RUBY_PLATFORM.match?(/java/)
  require "simplecov"
  require "coveralls"

  SimpleCov.formatter = Coveralls::SimpleCov::Formatter
  SimpleCov.start do
    add_filter "spec"
  end
end

require "chef-gyoku"
require "rspec"
