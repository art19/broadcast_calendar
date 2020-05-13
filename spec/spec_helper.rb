# frozen_string_literal: true

require 'simplecov'
require 'spork'

if ENV['COVERAGE']
  SimpleCov.start do
    add_filter 'spec/support'
  end
end

Spork.prefork do
  require 'rspec'

  RSpec.configure do |config|
    config.mock_with :rspec

    last_gc_run = Time.now

    config.before do
      GC.disable
    end

    config.after do
      if Time.now - last_gc_run > 1.0
        GC.enable
        GC.start
        last_gc_run = Time.now
      end
    end
  end

  require 'rspec/expectations'
  require 'rspec/core/expecting/with_rspec'
end

Spork.each_run do
end
