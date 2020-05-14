# frozen_string_literal: true

require 'rspec'

if ENV['COVERAGE']
  require 'simplecov'
  SimpleCov.start
end

RSpec.configure do |config|
  config.mock_with :rspec
  config.order = :random
end

require 'rspec/expectations'
