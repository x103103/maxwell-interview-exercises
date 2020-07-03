require_relative '../lib/grocery'
require_relative '../lib/data_loader'
require_relative '../lib/models'
require_relative '../lib/repository'
require_relative '../lib/order'
require_relative '../lib/order_item'

RSpec.configure do |config|
  config.expect_with :rspec do |expectations|
    expectations.include_chain_clauses_in_custom_matcher_descriptions = true
  end
  config.mock_with :rspec do |mocks|
    mocks.verify_partial_doubles = true
  end
  config.shared_context_metadata_behavior = :apply_to_host_groups
end
