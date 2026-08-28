require "chef-gyoku"

RSpec.configure do |config|
  config.expect_with :rspec do |expectations|
    expectations.syntax = :expect
    expectations.include_chain_clauses_in_custom_matcher_descriptions = true
  end

  config.mock_with :rspec do |mocks|
    mocks.syntax = :expect
    mocks.verify_partial_doubles = true
  end

  # Require RSpec.describe rather than a monkey patched top level describe.
  config.disable_monkey_patching!

  config.shared_context_metadata_behavior = :apply_to_host_groups

  # Records failures so `rspec --only-failures` and `--next-failure` work.
  config.example_status_persistence_file_path = "spec/examples.txt"

  config.filter_run_when_matching :focus

  # Randomize order so an accidental dependency between examples surfaces.
  config.order = :random
  Kernel.srand config.seed
end
