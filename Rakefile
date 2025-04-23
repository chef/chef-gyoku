require "bundler"
require "bundler/setup"
Bundler::GemHelper.install_tasks

require "rspec/core/rake_task"

desc "Check Linting and code style."
task :style do
  require "rubocop/rake_task"
  require "cookstyle/chefstyle"

  if RbConfig::CONFIG["host_os"] =~ /mswin|mingw|windows/
    # Windows-specific command, rubocop erroneously reports the CRLF in each file which is removed when your PR is uploaeded to GitHub.
    # This is a workaround to ignore the CRLF from the files before running cookstyle.
    sh "cookstyle --chefstyle -c .rubocop.yml --except Layout/EndOfLine"
  else
    sh "cookstyle --chefstyle -c .rubocop.yml"
  end
rescue LoadError
  puts "Rubocop or Cookstyle gems are not installed. bundle install first to make sure all dependencies are installed."
end

# Run the integration test suite
RSpec::Core::RakeTask.new(:integration) do |task|
  task.pattern = "spec/chef-gyoku/*_spec.rb"
  task.rspec_opts = ["--color", "-f documentation"]
end

RSpec::Core::RakeTask.new do |t|
  t.rspec_opts = %w{-c}
end

task default: :spec
task test: :spec
