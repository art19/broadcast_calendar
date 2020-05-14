# frozen_string_literal: true

require 'rspec'

if ENV['COVERAGE']
  require 'simplecov'
  SimpleCov.start
end

RSpec.configure do |config|
  config.mock_with :rspec
  config.order = :random
  config.after(:suite) { SimpleCov.at_exit_behavior } if ENV['COVERAGE']
end

require 'rspec/expectations'
require 'rspec/core/expecting/with_rspec'
